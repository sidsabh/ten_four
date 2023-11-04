const express = require('express');
const app = express();
const { auth } = require('express-oauth2-jwt-bearer');

const port = process.env.PORT || 3000;

app.get('/authorized', function (req, res) {
    res.send('Secured Resource');
});

// This route doesn't need authentication
app.get('/api/public', function(req, res) {
  res.json({
    message: 'Hello from a public endpoint! You don\'t need to be authenticated to see this.'
  });
});

const nocache = (_, resp, next) => {
  resp.header('Cache-Control', 'private, no-cache, no-store, must-revalidate');
  resp.header('Expires', '-1');
  resp.header('Pragma', 'no-cache');
  next();
}

const {RtcTokenBuilder, RtcRole} = require('agora-access-token');

const dotenv = require('dotenv');

// get agora app id and certificate
dotenv.config();
const APP_ID = process.env.APP_ID;
const APP_CERTIFICATE = process.env.APP_CERTIFICATE

const generateRTCToken = (req, resp) => {
  resp.header('Access-Control-Allow-Origin', '*');
  const channelName = req.params.channel;
  if (!channelName) {
    return resp.status(500).json({ 'error': 'channel is required' });
  }
  let uid = req.params.uid;
  if(!uid || uid === '') {
    return resp.status(500).json({ 'error': 'uid is required' });
  }
  // get role
  let role;
  if (req.params.role === 'publisher') {
    role = RtcRole.PUBLISHER;
  } else if (req.params.role === 'audience') {
    role = RtcRole.SUBSCRIBER
  } else {
    return resp.status(500).json({ 'error': 'role is incorrect' });
  }
  let expireTime = req.query.expiry;
  if (!expireTime || expireTime === '') {
    expireTime = 3600;
  } else {
    expireTime = parseInt(expireTime, 10);
  }
  const currentTime = Math.floor(Date.now() / 1000);
  const privilegeExpireTime = currentTime + expireTime;
  let token;
  if (req.params.tokentype === 'userAccount') {
    token = RtcTokenBuilder.buildTokenWithAccount(APP_ID, APP_CERTIFICATE, channelName, uid, role, privilegeExpireTime);
  } else if (req.params.tokentype === 'uid') {
    token = RtcTokenBuilder.buildTokenWithUid(APP_ID, APP_CERTIFICATE, channelName, uid, role, privilegeExpireTime);
  } else {
    return resp.status(500).json({ 'error': 'token type is invalid' });
  }
  return resp.json({ 'rtcToken': token });
}

app.get('/rtc/:channel/:role/:tokentype/:uid', nocache , generateRTCToken)

app.listen(port);

console.log('Running on port ', port);


// Here, we continuously get pinged by our frontend with locations
// We return the token of the call they should join
// We communicate with our Agora API to get the token
// We also run the clustering algorithm to get the clusters based on the location
// Provided in the request is the user's location



// // This route needs authentication
// app.get('/api/private', checkJwt, function(req, res) {
//   res.json({
//     message: 'Hello from a private endpoint! You need to be authenticated to see this.'
//   });
// });

// const { requiredScopes } = require('express-oauth2-jwt-bearer');

// const checkScopes = requiredScopes('read:messages');

// app.get('/api/private-scoped', checkJwt, checkScopes, function(req, res) {
//   res.json({
//     message: 'Hello from a private endpoint! You need to be authenticated and have a scope of read:messages to see this.'
//   });
// });

// const jwtCheck = auth({
//   audience: 'https://ten-four/api',
//   issuerBaseURL: 'https://dev-b28y4sop0va1xoas.us.auth0.com/',
//   tokenSigningAlg: 'RS256'
// });

// // enforce on all endpoints
// app.use(jwtCheck);

// send 
// String channelName = 'ten_four_test';
// String token = '007eJxTYMitECxis9h/d78+qzqn8vO87se/TYU5eO+eiDFofrbxSbMCg3lKcqKZkbFhqkWyiUmSpXFSanKyuUVysoVRkoWRhZlh4zy31IZARgZ72X9MjAwQCOLzMpSk5sWn5ZcWxZekFpcwMAAA+Twh6g==';
// String appId = '7dca6231e8c44b93becc78cc82b82861';