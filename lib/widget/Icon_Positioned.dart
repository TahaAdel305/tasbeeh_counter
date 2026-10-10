import 'package:flutter/material.dart';

import '../core/theme/app_color.dart';

class IconPositioned extends StatelessWidget {
  final String Texts;
  final Widget Icons;
  final VoidCallback onPressed;
   IconPositioned({
    super.key,
  required this.Texts,
  required this.Icons,
  required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: isDark?appcolor.Icon_Positioneddark:appcolor.Icon_Positionedlight,
        borderRadius: BorderRadius.circular(12),),
      width:  width*0.20,
      height: hight*0.10,

      child: TextButton(
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icons ,
            //SizedBox(height: 6),
            Text(
              Texts,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isDark
                  ?appcolor.textDark
                      :appcolor.textLight
              ),
            ),
          ],
        ),
      ),
    );
  }
}
