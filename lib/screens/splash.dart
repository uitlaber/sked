import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: logo(),
    );
  }

  Widget logo() {
    return Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: const Center(
          child: Text('Тэлос Архив', style: TextStyle(fontSize: 32))
        ));
  }
}