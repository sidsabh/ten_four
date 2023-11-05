import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';

import 'profile.dart';
import 'call.dart';
import 'components.dart';
import 'maps.dart';

class JoinScreen extends StatelessWidget {
  final Future<void> Function() logoutAction;
  final UserProfile? user;

  const JoinScreen(this.logoutAction, this.user, {final Key? key})
      : super(key: key);

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
            const SizedBox(
              height: 300,
              child: GoogleMapComponent(),
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
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Call()),
                  );
                }),
            const InfoText(text: '1,000 meter radius')
          ],
        ),
      ),
    );
  }
}
