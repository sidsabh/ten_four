import 'package:flutter/material.dart';

import 'components.dart';

class MyHomePage extends StatelessWidget {
  final Future<void> Function() loginAction;
  final String loginError;

  const MyHomePage(this.loginAction, this.loginError, {final Key? key})
      : super(key: key);

  Widget build(BuildContext context) {
    // fill entire screen with gradient
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black,
              Color.fromRGBO(103, 58, 183, 1),
              Colors.red,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Spacer(),
            const Text(
              '10-4',
              style: TextStyle(
                color: Colors.white,
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Image.asset(
              'assets/radio_image.png',
              height: 250,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonWidget(
                    title: 'Login',
                    width: 250,
                    color: Colors.blue,
                    onPressed: () async {
                      await loginAction();
                    },
                  ),
                  Text(
                    loginError,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
