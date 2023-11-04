// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'package:agora_rtc_engine/agora_rtc_engine.dart';

// const String appId = "7dca6231e8c44b93becc78cc82b82861";

// void main() => runApp(const MaterialApp(home: MyApp()));

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class MyHomePage extends StatefulWidget {

//  @override
//  State<MyHomePage> createState() => _MyHomePageState();
// }


// class _MyHomePageState extends State<MyHomePage> {

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Container(
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            begin: Alignment.topRight,
//            end: Alignment.bottomLeft,
//            colors: [
//              Colors.black,
//              Colors.deepPurple,
//              Colors.red,
//            ],
//          ),
//        ),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: <Widget>[
//            Spacer(),
//            Text(
//              '10-4',
//              style: TextStyle(
//                color: Colors.white,
//                fontSize: 80,
//                fontWeight: FontWeight.bold,
//              ),
//            ),
//            Spacer(),
//            Image.asset(
//              'assets/radio_image.png',
//              height: 250,
//            ),
//            Spacer(),
//            Padding(
//              padding: EdgeInsets.symmetric(horizontal: 50),
//              child: ElevatedButton(
//                onPressed: () {
//                  //switch to a new screen
//                 //  Navigator.push(
//                 //    context,
//                 //    MaterialPageRoute(builder: (context) => const HomeScreen()),
//                 //  );
//                },
//                style: ElevatedButton.styleFrom(
//                  primary: Colors.grey[850], // Button background color
//                  onPrimary: Colors.white, // Button text color
//                  minimumSize: Size(double.infinity, 50), // Set the button's size
//                ),
//                child: Text(
//                  'enter',
//                  style: TextStyle(
//                    fontSize: 18,
//                  ),
//                ),
//              ),
//            ),
//            Spacer(),
//          ],
//        ),
//      ),
//    );
//  }
// }



// class TenFourState extends State<MyApp> {
//   String channelName = "ten_four_test";
//   String token = "007eJxTYMitECxis9h/d78+qzqn8vO87se/TYU5eO+eiDFofrbxSbMCg3lKcqKZkbFhqkWyiUmSpXFSanKyuUVysoVRkoWRhZlh4zy31IZARgZ72X9MjAwQCOLzMpSk5sWn5ZcWxZekFpcwMAAA+Twh6g==";

//   int uid = 0; // uid of the local user

//   int? _remoteUid; // uid of the remote user
//   bool _isJoined = false; // Indicates if the local user has joined the channel
//   late RtcEngine agoraEngine; // Agora engine instance

//   final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
//       GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

//   // Build UI
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       scaffoldMessengerKey: scaffoldMessengerKey,
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Get started with Voice Calling'),
//           ),
//           body: ListView(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//             children: [
//               // Status text
//               SizedBox(height: 40, child: Center(child: _status())),
//               // Button Row
//               Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: ElevatedButton(
//                       child: const Text("Join"),
//                       onPressed: () => {join()},
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: ElevatedButton(
//                       child: const Text("Leave"),
//                       onPressed: () => {leave()},
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           )),
//     );
//   }

//   Widget _status() {
//     String statusText;

//     if (!_isJoined) {
//       statusText = 'Join a channel';
//     } else if (_remoteUid == null) {
//       statusText = 'Waiting for a remote user to join...';
//     } else {
//       statusText = 'Connected to remote user, uid:$_remoteUid';
//     }

//     return Text(
//       statusText,
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Set up an instance of Agora engine
//     setupVoiceSDKEngine();
//   }

//   Future<void> setupVoiceSDKEngine() async {
//     // retrieve or request microphone permission
//     await [Permission.microphone].request();

//     //create an instance of the Agora engine
//     agoraEngine = createAgoraRtcEngine();
//     await agoraEngine.initialize(const RtcEngineContext(appId: appId));

//     // Register the event handler
//     agoraEngine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           showMessage(
//               "Local user uid:${connection.localUid} joined the channel");
//           setState(() {
//             _isJoined = true;
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           showMessage("Remote user uid:$remoteUid joined the channel");
//           setState(() {
//             _remoteUid = remoteUid;
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           showMessage("Remote user uid:$remoteUid left the channel");
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//       ),
//     );
//   }

//   void join() async {
//     // Set channel options including the client role and channel profile
//     ChannelMediaOptions options = const ChannelMediaOptions(
//       clientRoleType: ClientRoleType.clientRoleBroadcaster,
//       channelProfile: ChannelProfileType.channelProfileCommunication,
//     );
//     // print agoraEngine

//     await agoraEngine.joinChannel(
//       token: token,
//       channelId: channelName,
//       options: options,
//       uid: uid,
//     );
//   }

//   void leave() {
//     setState(() {
//       _isJoined = false;
//       _remoteUid = null;
//     });
//     agoraEngine.leaveChannel();
//   }

//   // Clean up the resources when you leave
//   @override
//   void dispose() async {
//     await agoraEngine.leaveChannel();
//     super.dispose();
//   }

//   showMessage(String message) {
//     scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
//       content: Text(message),
//     ));
//   }
// }

import 'package:flutter/material.dart';


void main() {
 runApp(const MyApp());
}


class MyApp extends StatelessWidget {
 const MyApp({super.key});


 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: '10-4',
     theme: ThemeData(
       primarySwatch: Colors.blue,
       useMaterial3: true,
     ),
     home: const MyHomePage(),
   );
 }
}

//LandingPage
class MyHomePage extends StatefulWidget {
 const MyHomePage({super.key});
 @override
 State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
       decoration: BoxDecoration(
         gradient: LinearGradient(
           begin: Alignment.topRight,
           end: Alignment.bottomLeft,
           colors: [
             Colors.black,
             Colors.deepPurple,
             Colors.red,
           ],
         ),
       ),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: <Widget>[
           Spacer(),
           Text(
             '10-4',
             style: TextStyle(
               color: Colors.white,
               fontSize: 80,
               fontWeight: FontWeight.bold,
             ),
           ),
           Spacer(),
           Image.asset(
             'assets/radio_image.png',
             height: 250,
           ),
           Spacer(),
           Padding(
             padding: EdgeInsets.symmetric(horizontal: 50),
             child: ElevatedButton(
               onPressed: () {
                 //switch to a new screen
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => const HomeScreen()),
                 );
               },
               style: ElevatedButton.styleFrom(
                 primary: Colors.grey[850], // Button background color
                 onPrimary: Colors.white, // Button text color
                 minimumSize: Size(double.infinity, 50), // Set the button's size
               ),
               child: Text(
                 'enter',
                 style: TextStyle(
                   fontSize: 18,
                 ),
               ),
             ),
           ),
           Spacer(),
         ],
       ),
     ),
   );
 }
}



class HomeScreen extends StatelessWidget {
 const HomeScreen({super.key});


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.deepPurple[700],
     body: Container(
      decoration: BoxDecoration(
         gradient: LinearGradient(
           begin: Alignment.topRight,
           end: Alignment.bottomLeft,
           colors: [
             Colors.black,
             Colors.deepPurple,
             Colors.red,
           ],
         ),
       ),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           Image.asset(
             'assets/map.png',
             height: 250,
           ),
           ButtonWidget(title: 'sign in', width: 200, color: Colors.green, onPressed: () {}),
           ButtonWidget(title: 'join', width:250, color: Colors.grey, onPressed: () {}),
           InfoText(text: '4 people broadcasting'),
           ButtonWidget(title: 'notify', width:265, color: Colors.grey, onPressed: () {}),
           InfoText(text: '10 people monitoring'),
         ],
       ),
     ),
   );
 }
}


class ButtonWidget extends StatelessWidget {
 final String title;
 final double width; 
 final Color color;
 final VoidCallback onPressed;


 const ButtonWidget({
   Key? key,
   required this.title,
   required this.width,
   required this.color,
   required this.onPressed,
 }) : super(key: key);


 @override
 Widget build(BuildContext context) {
   return Container(
     width: width,
     margin: EdgeInsets.all(8.0),
     child: ElevatedButton(
       onPressed: onPressed,
       style: ElevatedButton.styleFrom(
         primary: color,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(30.0),
         ),
         padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
       ),
       child: Text(title.toUpperCase()),
     ),
   );
 }
}


class InfoText extends StatelessWidget {
 final String text;


 const InfoText({
   Key? key,
   required this.text,
 }) : super(key: key);


 @override
 Widget build(BuildContext context) {
   return Container(
     margin: EdgeInsets.symmetric(vertical: 8.0),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Icon(Icons.circle, size: 10.0, color: Colors.orange),
         SizedBox(width: 8.0),
         Text(text),
       ],
     ),
   );
 }
}
