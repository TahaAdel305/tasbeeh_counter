import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: double.infinity,
      //color: Colors.red,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
                isDarkMode ? "assets/images/background_dark.png"
                    : "assets/images/background_light.png",
            ),
          fit: BoxFit.cover,
        )
      ),child: child,
    );
  }
}

