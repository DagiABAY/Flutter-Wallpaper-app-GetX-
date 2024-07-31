import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitalizationComplete;

  const SplashPage({super.key, required this.onInitalizationComplete});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 5), () => widget.onInitalizationComplete());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Wallpaper",
        home: Scaffold(
          body: Stack(
            children: [
              _backgroundUI(),
              _foregroundUI(),
            ],
          ),
        ));
  }

  Widget _backgroundUI() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/back.jpg"),
        fit: BoxFit.cover,
      )),
    );
  }

  Widget _foregroundUI() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: SizedBox(
            height: 450,
            width: 450,
            child: Center(
              child: Text(
                "Wallpaper",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontFamily: "myfont",
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Develped by: dagi@softs.com",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
