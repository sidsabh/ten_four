import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';

import 'components.dart';

class Profile extends StatelessWidget {
  final Future<void> Function() logoutAction;
  final UserProfile? user;

  const Profile(this.logoutAction, this.user, {final Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 4),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(user?.pictureUrl.toString() ?? ''),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '${user?.name}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            ButtonWidget(
                title: 'Back',
                width: 250,
                color: Colors.grey,
                onPressed: () async {
                  Navigator.pop(context);
                }),
            ButtonWidget(
              title: 'Logout',
              width: 250,
              color: Colors.grey,
              onPressed: () async {
                logoutAction();
                Navigator.pop(context);
              },
            ),
          ],
        ));
  }
}
