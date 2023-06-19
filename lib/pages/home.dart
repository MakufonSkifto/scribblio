import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> animation;

  final LinearGradient gradient = LinearGradient(colors: [
    Colors.purple.shade400,
    Colors.purple.shade700,
  ]);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black87
        ),
        padding: const EdgeInsets.all(15),
        child: SafeArea(
          child: FadeTransition(
            opacity: animation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.brush_rounded, size: 45, color: Colors.white),
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => gradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                      child: const Text(
                        "Scribble",
                        style: TextStyle(
                          fontFamily: "Geologica-Medium",
                          fontSize: 40,
                        )
                      ),
                    )
                  ]
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  child: Text(
                    "Connect through art, without leaving your homescreen.",
                    style: TextStyle(fontFamily: "Geologica-Medium", fontSize: 20, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple.shade500),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )
                    )
                  ),
                  child: const Text(
                    "Get started",
                    style: TextStyle(
                      fontFamily: "Geologica-Medium",
                      fontSize: 19,
                      color: Colors.white,
                    )
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
