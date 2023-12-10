import 'package:flutter/material.dart';
import 'package:reddit/images.dart';
import 'package:reddit/splash/splashservices.dart';

class SplashScreen extends StatefulWidget
{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices services = SplashServices();

  @override
  void initState() {
    super.initState();
    services.splash(context);
  }

  Widget build(BuildContext context)
  {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor : Colors.black,
      body : Center(
        child: CircleAvatar(
          radius: size.width*0.15,
          backgroundColor: Colors.black,
          backgroundImage: const AssetImage(appIcon),
        ),
      ),
    );
  }
}