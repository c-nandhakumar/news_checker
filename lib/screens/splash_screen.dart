import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:flutter/services.dart';
import 'package:news_checker/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  void dispose() {
    super.dispose();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Color(0x00fcfcfc),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const Text(
              //   "News Mobile",
              //   style: TextStyle(
              //     fontSize: 28,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              const Text.rich(TextSpan(children: [
                TextSpan(
                    text: "NEWS",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1e4da7),
                      fontSize: 28,
                    )),
                TextSpan(
                    text: "MOBILE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xffc40305),
                      fontSize: 28,
                    ))
              ])),
              Text(
                "Fact Checker",
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 36),
                  child: Image.asset(
                    "assets/gifs/newsmobile.gif",
                    height: 200,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
