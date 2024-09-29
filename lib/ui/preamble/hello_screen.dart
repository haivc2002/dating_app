import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

import 'animate_to_next_screen.dart';

class HelloScreen extends StatefulWidget {
  const HelloScreen({Key? key}) : super(key: key);

  @override
  State<HelloScreen> createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2100), () async {
      // Navigator.of(context).pushReplacement(
      //   PageRouteBuilder(
      //     pageBuilder: (_, __, ___) => const AnimateToNextScreen(),
      //     transitionDuration: const Duration(seconds: 0),
      //   ),
      // );
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AnimateToNextScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: const rive.RiveAnimation.asset(
            'assets/n2.riv',
            fit: BoxFit.cover,
          )
      ),
    );
  }
}
