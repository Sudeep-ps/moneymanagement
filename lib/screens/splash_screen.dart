import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moneymanagement/screens/home/screen_home.dart';

class ScreenSlash extends StatefulWidget {
  const ScreenSlash({super.key});

  @override
  State<ScreenSlash> createState() => _ScreenSlashState();
}

class _ScreenSlashState extends State<ScreenSlash> {

  @override
  void initState() {
    gotohome();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color.fromARGB(255, 0, 116, 4),Color.fromARGB(255, 169, 13, 2)],begin: Alignment.bottomLeft,end: Alignment.topRight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Animate(
                effects: const [FadeEffect(duration: Duration(milliseconds: 400)),ScaleEffect()],
                child: Image.asset("assets/images/images.png",scale: 2,)
              )
            ),
            //const SizedBox(height: 20,),
           const Text("MONEY MANAGER",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'Bungee',color: Colors.white70),)
           .animate()
           .fadeIn(duration: 200.ms)
           .then()
           .slide()
          ],
        ),
      )
    );
  }
  Future<void> gotohome() async{
    await Future.delayed(const Duration(seconds: 2));
    await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> const Screenhome()));
  }
}