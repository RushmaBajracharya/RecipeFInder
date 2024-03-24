import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_finder/widgets/bottombar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;
  late Animation colorAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    animation = Tween(begin: 30.0, end: 100.0).animate(animationController);
    colorAnimation = ColorTween(
            begin: const Color.fromARGB(255, 95, 175, 240),
            end: const Color.fromARGB(255, 201, 68, 224))
        .animate(animationController);

    animationController.addListener(() {
      setState(() {});
    });

    animationController.forward().then((_) {
      Get.to(() => BottomBar());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: colorAnimation.value,
          child: Center(
            child: CircleAvatar(
                radius: animation.value,
                backgroundImage:
                    const AssetImage('assets/images/girlcook.jpg')),
          )),
    );
  }
}
