import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';


import 'components.dart';

// String channelName = 'ten_four_test';
// String token =
//     '007eJxTYMitECxis9h/d78+qzqn8vO87se/TYU5eO+eiDFofrbxSbMCg3lKcqKZkbFhqkWyiUmSpXFSanKyuUVysoVRkoWRhZlh4zy31IZARgZ72X9MjAwQCOLzMpSk5sWn5ZcWxZekFpcwMAAA+Twh6g==';
// int uid = 0; // uid of the local user
const String appId = '7dca6231e8c44b93becc78cc82b82861';

class Call extends StatefulWidget {
  String channelName;
  String token;
  int uid;

  Call(
      {Key? key,
      required this.channelName,
      required this.token,
      required this.uid})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => CallState();
}

class CallState extends State<Call> {
  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; // Agora engine instance
  bool _isMuted = false; // Indicates if the local user is muted

  // String get channelName => widget.channelName;
  // String get token => widget.token;
  // int get uid => widget.uid;

  String channelName = "please_work";
  String token = '007eJxTYNDOKeHlrb/E4OJm8GHpGYOsa0tvH6lkl3zqw271a8OyvWUKDOYpyYlmRsaGqRbJJiZJlsZJqcnJ5hbJyRZGSRZGFmaGFsfcUxsCGRnmCrxjYWSAQBCfm6EgJzWxODW+PL8om4EBAONiIaQ=';
  // int uid = rng.nextInt(200);
  int get uid => widget.uid;

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setupVoiceSDKEngine(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // image and texxt
                    const Text(
                      '10-4',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // space
                    const SizedBox(width: 10),
                    Image.asset(
                      'assets/radio_image.png',
                      height: 50,
                    ),
                  ],
                ),
                Image.asset(
                  'assets/divider.png',
                ),
                Image.asset(
                  'assets/sound_waves.png',
                  height: 300,
                ),

                Text(
                  'Public Channel: $channelName',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Image.asset(
                //   'assets/divider.png',
                // ),
                // const Text(
                //   "Public Channel",
                //   style: TextStyle(height: 3, fontSize: 40),
                // ),
                // custom button with image
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isMuted = !_isMuted;
                    });
                    agoraEngine.muteLocalAudioStream(_isMuted);
                  },
                  child: Image.asset(
                    _isMuted
                        ? 'assets/muted_microphone.png'
                        : 'assets/microphone.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                // const Text(
                //   "Members",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ButtonWidget(
                        title: 'Leave',
                        width: 250,
                        color: Colors.grey,
                        onPressed: () async {
                          () => {leave()};
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                statusWidget(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget statusWidget() {
    String statusText;

    if (!_isJoined) {
      statusText = 'Join a channel';
    } else if (_remoteUid == null) {
      statusText = 'Waiting for a remote user to join...';
    } else {
      statusText = 'Connected to remote user, uid:$_remoteUid';
    }

    return Text(
      statusText,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Set up an instance of Agora engine
    setupVoiceSDKEngine().then((_) {
      print(
          'channelName: $channelName, token: $token, uid: $uid, appId: $appId');
      // Join channel after initializing
      join();
    });
  }

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: appId));

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          if (!mounted) return;
          showMessage(
              "Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          if (!mounted) return;
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          if (!mounted) return;
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  void join() async {
    print("joining ");
    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }

  void leave() {
    if (!mounted) return;
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }

  // Clean up the resources when you leave
  @override
  void dispose() async {
    super.dispose();
    await agoraEngine.leaveChannel();
  }

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
