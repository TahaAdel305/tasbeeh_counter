import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasbeeh_counter/core/theme/app_color.dart';
import 'package:tasbeeh_counter/widget/Button_Setting.dart';

import '../core/Service/SettingsService.dart';

class settings_screen extends StatelessWidget {
  const settings_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final settings = context.watch<SettingsService>();
    return SafeArea(
      child: Scaffold(
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height*0.03,),
            Text("Setting ",style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                color: isDark
                    ?appcolor.colorlight
                    :appcolor.colordark
            ),
            ),
            SizedBox(height: height*0.02,),
            ButtonSetting(
              title: "الوضع الداكن",
            value: settings.isDark,
              onChanged: (_) => settings.toggleTheme(),
            ),
            SizedBox(height: height*0.01,),

            ButtonSetting(
              title: 'الاهتزاز',
              value: settings.vibrationEnabled,
              onChanged: (value) => settings.setVibration(value),
            ),
            SizedBox(height: height*0.01,),

            ButtonSetting(
              title: 'إبقاء الشاشة شغالة',
              value: settings.keepScreenOn,
              onChanged: (value) => settings.setKeepScreenOn(value),
            ),
        ],),
      ),
    );
  }
}
