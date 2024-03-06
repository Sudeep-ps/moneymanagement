import 'package:flutter/material.dart';


class AboutPage extends StatelessWidget {
  static const routename='about';
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ABOUT APP',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Text('Developed by :\nSudeep',style: TextStyle(fontSize: 50,fontFamily: 'Estonia'),textAlign: TextAlign.end,)
          ),
        )
      ),
    );
  }
}