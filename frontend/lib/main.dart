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
            ButtonWidget(title: 'sign in', width: 200, color: Colors.green, onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogInPage()),
                  );}),
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

// log in 
class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

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
              Text(
                "Log In with Google",
                style: TextStyle(height: 3, fontSize: 40),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                child: ButtonWidget(title: 'log in with google', width: 450, color: Colors.white, onPressed: () { Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => const PublicChannel()),
                 );}),
              ),
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


// breakout channel page
class PublicChannel extends StatefulWidget {
  const PublicChannel({super.key});
  @override
  State<PublicChannel> createState() => _PublicChannel();
}


class _PublicChannel extends State<PublicChannel> {
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
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[


            Spacer(),
            Text(
                "Public Channel",
                style: TextStyle(height: 3, fontSize: 40),
              ),
            Image.asset(
              'assets/sound_waves.png',
            ),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}