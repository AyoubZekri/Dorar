import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constant/routes.dart';

class DorrarSplashPage extends StatefulWidget {
  const DorrarSplashPage({super.key});

  @override
  State<DorrarSplashPage> createState() => _DorrarSplashPageState();
}

class _DorrarSplashPageState extends State<DorrarSplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offNamed(Approutes.dorrarHome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/Logo.png',
          width: MediaQuery.of(context).size.width * 0.6,
        ),
      ),
    );
  }
}
