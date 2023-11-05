import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
              // if user is null, display assets/icon.png else display user picture
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
            const InfoText(text: '1 mile radius')
          ],
        ),
      ),
    );
  }
}

//Make a switch that toggles back and forth when pressed (on/off)
class SwitchWidget extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchWidget({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SwitchWidgetState();
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
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.circle, size: 12.0, color: Colors.blue),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool _currentValue = false;

  @override
  void initState() {
    super.initState();
    _currentValue =
        widget.value; // Initialize switch state based on passed value
  }

  // Clean up the resources when you leave
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
          value: _currentValue,
          onChanged: (bool newValue) {
            setState(() {
              _currentValue = newValue; // Update the switch state
            });
            widget
                .onChanged(newValue); // Notify the parent widget of the change
          },
        ),
      ],
    );
  }
}
