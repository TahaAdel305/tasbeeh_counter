import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasbeeh_counter/core/theme/app_color.dart';
import 'package:provider/provider.dart';
import 'package:tasbeeh_counter/core/Service/stats_service.dart';
import 'package:tasbeeh_counter/screen_widget/settings_screen.dart';
import '../core/Service/SettingsService.dart';
import '../widget/Icon_Positioned.dart';
import 'package:flutter/services.dart';

import 'package:vibration/vibration.dart';

class tasbeeh_screen extends StatefulWidget {
  const tasbeeh_screen({super.key});

  @override
  State<tasbeeh_screen> createState() => _tasbeeh_screenState();
}

class _tasbeeh_screenState extends State<tasbeeh_screen> {
  int count = 0;
  int currentIndex = 0;

  final List<String> zeker = [
    "سبحان الله",
    "الحمد لله",
    "لا إله إلا الله",
    "الله أكبر",
    "أستغفر الله",
    "سبحان الله وبحمده",
    "سبحان الله العظيم",
    "سبحان الله وبحمده سبحان الله العظيم",
    "لا حول ولا قوة إلا بالله",
    "اللهم صل على سيدنا محمد",
  ];

  void nextZikr() {
    setState(() {
      currentIndex = (currentIndex + 1) % zeker.length;
      count = 0;
    });
  }

  void previousZikr() {
    setState(() {
      currentIndex = (currentIndex - 1) % zeker.length;
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: Drawer(
        child: settings_screen(),
        backgroundColor: isDark ? appcolor.colordark : appcolor.colorlight,
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: hight * 0.08),
                  child: Text(
                    "عدد التسبيحات",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: SafeArea(
                  child: Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu_rounded),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Text(
            "$count",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
          ),
          Container(child: Text("من 100")),
          SizedBox(height: hight * 0.02),

          ////
          Stack(
            alignment: Alignment.topCenter,
            children: [
              SvgPicture.asset(
                isDark
                    ? "assets/images/tasbeeh_dark.svg"
                    : "assets/images/tasbeeh_light.svg",
              ),
              Padding(
                padding: EdgeInsets.only(top: hight * 0.1),
                child: TextButton(
                  onPressed: () {
                    final settings = context.read<SettingsService>();
                    if (settings.vibrationEnabled) {
                      /*Vibration.hasVibrator().then(
                        (v) => print('hasVibrator: $v'),
                      );*/
                      Vibration.vibrate(duration: 500, amplitude: 255);
                    }
                    setState(() {
                      count++;
                    });
                    context.read<StatsService>().addTasbeeh(
                      "${zeker[currentIndex]}",
                    );
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "سبح",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: appcolor.colordark,
                          ),
                        ),
                        Text(
                          "اضغط لتسبيح",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: appcolor.colordark,
                          ),
                        ),
                      ],
                    ),
                    width: width * 0.40,
                    height: hight * 0.20,
                    decoration: BoxDecoration(
                      border: Border.all(width: 7, color: Colors.black54),
                      color: appcolor.colorlight,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 15,
                bottom: 15,
                child: IconPositioned(
                  Texts: "اعاده",
                  Icons: SvgPicture.asset(
                    "assets/images/icon_history.svg",
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    width: width * 0.04,
                    height: hight * 0.04,
                  ),
                  onPressed: () {
                    setState(() {
                      count = 0;
                    });
                  },
                ),
              ),
              Positioned(
                right: 15,
                bottom: 15,
                child: IconPositioned(
                  Texts: "الهدف",
                  Icons: SvgPicture.asset(
                    //"assets/images/icon_history.svg",
                    "assets/images/icon_goal_test.svg",
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    width: width * 0.04,
                    height: hight * 0.04,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  //only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                  color: isDark
                      ? appcolor.Icon_Positioneddark
                      : appcolor.Icon_Positionedlight,
                ),
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: previousZikr,
                        icon: Icon(
                          Icons.skip_previous_rounded,
                          color: isDark
                              ? appcolor.textDark
                              : appcolor.textLight,
                          size: 49,
                        ),
                      ),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: Text(
                            zeker[currentIndex],
                            key: ValueKey(currentIndex),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? appcolor.textDark
                                  : appcolor.textLight,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: nextZikr,
                        icon: Icon(
                          Icons.skip_next_rounded,
                          color: isDark
                              ? appcolor.textDark
                              : appcolor.textLight,
                          size: 49,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
