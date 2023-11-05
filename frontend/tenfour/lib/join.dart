import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'profile.dart';
import 'call.dart';
import 'components.dart';
import 'maps.dart';
import 'api.dart';
import 'dart:math';

class JoinScreen extends StatefulWidget {
  final Future<void> Function() logoutAction;
  final UserProfile? user;

  JoinScreen(this.logoutAction, this.user);

  @override
  State<StatefulWidget> createState() =>
      JoinScreenState(logoutAction: logoutAction, user: user);
}

class JoinScreenState extends State<JoinScreen> {
  final Future<void> Function() logoutAction;
  final UserProfile? user;
  late LatLng? location;

  JoinScreenState({Key? key, required this.logoutAction, required this.user});

  void onUserLocationChanged(LatLng location) async {
    setState(() {
      this.location = location;
    });
  }

  Future<HashMap<String, String>> loadParams() async {
    var response = await myPost(
      endpoint: '/rtc',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'latitude': location!.latitude.toString(),
        'longitude': location!.longitude.toString(),
        // 'jwt': user!.getAccessToken().toString(),
      }),
    );

    if (response.statusCode == 200) {
      return HashMap<String, String>.from(json.decode(response.body));
    } else {
      print('Request failed with error: ${response.statusCode}.');
      return HashMap<String, String>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[700],
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
          children: <Widget>[
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
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: GoogleMapComponent(
                  onUserLocationChanged: onUserLocationChanged),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(logoutAction, user)),
                );
              },
              child: user == null
                  ? const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/icon.png'),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(user?.pictureUrl.toString() ?? ''),
                    ),
            ),
            const SizedBox(height: 20),
            ButtonWidget(
                title: 'Radio-in!',
                width: 250,
                color: Colors.grey,
                onPressed: () {
                  var rng = Random();
                  loadParams().then((value) => {
                        print('values: $value'),
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Call(
                                    token: '',
                                    channelName: '',
                                    uid: rng.nextInt(200),
                                    // token: value['token']! ?? '',
                                    // channelName: value['channelName']! ?? '',
                                    // uid: int.parse(value['uid']! ?? '-1'),
                                  )),
                        )
                      });
                }),
            const InfoText(text: '1,000 meter radius')
          ],
        ),
      ),
    );
  }
}
