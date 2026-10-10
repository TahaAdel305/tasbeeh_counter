import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasbeeh_counter/core/theme/app_color.dart';

import '../core/Service/SettingsService.dart';

class ButtonSetting extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ButtonSetting({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    var width = MediaQuery.of(context).size.width;
    var hight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isDark ? appcolor.colordark : appcolor.colorlight,
          border: Border.all(
            width: 2,
            color: isDark ? appcolor.colorlight : appcolor.colordark,
          ),
        ),

        width: width * 0.95,
        height: hight * 0.06,
        child: SwitchListTile(
          title: Text(title),
          value: value,
          onChanged: onChanged,
          activeThumbColor: appcolor.colorlight,
        ),
      ),
    );
  }
}
