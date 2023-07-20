import 'package:awsome_weather/main.dart';
import 'package:awsome_weather/style.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgDark,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/cloudy.png',
            filterQuality: FilterQuality.high,
            width: 260,
            height: 260,),
            const SizedBox(
              height: 60,
            ),
            Text("Discover the Weather",
            style: TextStyle(
              color: textWhite,
              fontSize: 24,
              fontWeight: FontWeight.w500
            ),),
            Text("in Your City",
            style: TextStyle(
              color: textWhite,
              fontSize: 24,
              fontWeight: FontWeight.w500
            ),),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Get to know your weather maps and radar precipitation forecast",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textWhite,
                fontSize: 16,
                fontWeight: FontWeight.w400
              ),),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(400, 60),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return const HomePage();
              }));
            }, child: Text("Get Started",
            style: TextStyle(
              color: textWhite,
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),))
          ],
                ),
        ),
      )
    );
  }
}