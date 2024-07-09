import 'dart:async';
import 'package:flutter/material.dart';

// import 'home_screen.dart'; // Import your HomeScreen widget

class IntroductPage extends StatefulWidget {
  const IntroductPage({super.key});

  @override
  _IntroductState createState() => _IntroductState();
}

class _IntroductState extends State<IntroductPage> {
  int _currentIndex = 0;
  late Timer _timer;

  final List<Map<String, String>> _contentList = [
    {
      'image': "assets/images/advertisement1.png", 
      'title': 'Welcome',
      'description': 'It’s a pleasure to meet you. We are excited that you’re here so let’s get started!'
    },
    {
      'image': "assets/images/advertisement4.png", 
      'title': 'All your favorites',
      'description': 'Order from the best local restaurants with easy,on-demand delivery'
    },
    // {
    //   'image': rWelcomeScreenImagetwo, 
    //   'title': 'Free delivery offers',
    //   'description': 'Free delivery for new customes visa Apple Pay and orthers payment methods'
    // },
    {
      'image': "assets/images/advertisement3.png", 
      'title': 'Choose your food',
      'description': 'Easily find your type of food craving and you will get delivery in wide range'
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _contentList.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Image(
                    image: AssetImage("assets/images/logo.png"),
                    height: 70,
                  ),
                ),
                const SizedBox(width: 10), // Add some spacing between logo and text
                const Text(
                  "Tamang FoodService",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 31,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16), // Space between logo row and changing content
            Image(
              image: AssetImage(_contentList[_currentIndex]['image']!),
              height: 320,
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Text(
                  _contentList[_currentIndex]['title']!,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  _contentList[_currentIndex]['description']!,
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 3,
                  backgroundColor: _currentIndex == index
                      ? Colors.red
                      : Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
          ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to HomeScreen
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const Home()),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // Text color white
                  backgroundColor: Colors.red, // Background color red
                ),
                child: const Text(
                  'GET STARTED',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}