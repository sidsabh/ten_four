const express = require("express");
const app = express();
app.use(express.json());

const { auth } = require("express-oauth2-jwt-bearer");
const { RtcTokenBuilder, RtcRole } = require("agora-access-token");
const dotenv = require("dotenv");
const { requiredScopes } = require("express-oauth2-jwt-bearer");
const checkScopes = requiredScopes("read:messages");

const port = process.env.PORT || 3000;

const nocache = (_, resp, next) => {
  resp.header("Cache-Control", "private, no-cache, no-store, must-revalidate");
  resp.header("Expires", "-1");
  resp.header("Pragma", "no-cache");
  next();
};

// const jwtCheck = auth({
//   audience: 'https://ten-four/api',
//   issuerBaseURL: 'https://dev-b28y4sop0va1xoas.us.auth0.com/',
//   tokenSigningAlg: 'RS256'
// });

// // enforce on all endpoints
// app.use(jwtCheck);

// get agora app id and certificatea
dotenv.config();
const APP_ID = process.env.APP_ID;
const APP_CERTIFICATE = process.env.APP_CERTIFICATE;

clusters = [];
num_users = 0;
server_name = "tenfour_public";

max_distance = 1;

function getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
  var R = 6371; // Radius of the earth in km
  var dLat = deg2rad(lat2-lat1);  // deg2rad below
  var dLon = deg2rad(lon2-lon1); 
  var a = 
    Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * 
    Math.sin(dLon/2) * Math.sin(dLon/2)
    ; 
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
  var d = R * c; // Distance in km
  return d;
}

function deg2rad(deg) {
  return deg * (Math.PI/180)
}

app.post("/rtc", nocache, (req, resp) => {
  // get the params
  resp.header("Access-Control-Allow-Origin", "*");
  const longitude = req.body.longitude;
  const latitude = req.body.latitude;

  console.log("hello", longitude, latitude);
  if (!longitude || longitude === "") {
    return resp.status(500).json({ error: "longitude is required" });
  }
  if (!latitude || latitude === "") {
    return resp.status(500).json({ error: "latitude is required" });
  }

  const currentTime = Math.floor(Date.now() / 1000);
  const privilegeExpireTime = currentTime + 3600;
  num_users += 1;
  channelName = server_name + "_" + clusters.length;

  let token = null;
  for (cluster of clusters) {
    for (point of cluster.points) {
      if (getDistanceFromLatLonInKm(point.longitude, point.latitude, longitude, latitude) < 1) {
        token = cluster.token;
        channelName = cluster.channelName;
        cluster.points.push({ longitude: longitude, latitude: latitude });
        break;
      }
    }
  }
  if (token == null) {
    token = RtcTokenBuilder.buildTokenWithAccount(
      APP_ID,
      APP_CERTIFICATE,
      channelName,
      num_users,
      RtcRole.PUBLISHER,
      privilegeExpireTime,
    );
    channelName = server_name + "_" + clusters.length;
  }

  clusters.push({
    token: token,
    channelName: channelName,
    points: [{ longitude: longitude, latitude: latitude }],
  });

  console.log({ token: token, uid: num_users, channelName: channelName });
  return resp.json({
    token: token,
    uid: String(num_users),
    channelName: channelName,
  });
});

app.listen(port);

console.log("Running on port ", port);

// app.get("/authorized", function (req, res) {
//   res.send("Secured Resource");
// });

// This route doesn't need authentication
// app.post("/api/public", function (req, res) {
//   res.json({
//     message:
//       "Hello from a public endpoint! You don't need to be authenticated to see this.",
//   });
// });

// We communicate with our Agora API to get the token
// We also run the clustering algorithm to get the clusters based on the location
// Provided in the request is the user's location

// // This route needs authentication
// app.get('/api/private', checkJwt, function(req, res) {
//   res.json({
//     message: 'Hello from a private endpoint! You need to be authenticated to see this.'
//   });
// });

// app.get('/api/private-scoped', checkJwt, checkScopes, function(req, res) {
//   res.json({
//     message: 'Hello from a private endpoint! You need to be authenticated and have a scope of read:messages to see this.'
//   });
// });

// send
// String channelName = 'ten_four_test';
// String token = '007eJxTYMitECxis9h/d78+qzqn8vO87se/TYU5eO+eiDFofrbxSbMCg3lKcqKZkbFhqkWyiUmSpXFSanKyuUVysoVRkoWRhZlh4zy31IZARgZ72X9MjAwQCOLzMpSk5sWn5ZcWxZekFpcwMAAA+Twh6g==';
// String appId = '7dca6231e8c44b93becc78cc82b82861';
