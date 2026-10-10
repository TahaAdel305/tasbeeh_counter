import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasbeeh_counter/screen_widget/alzehr_screen.dart';
import 'package:tasbeeh_counter/screen_widget/settings_screen.dart';
import 'package:tasbeeh_counter/screen_widget/statistics_screen.dart';
import 'package:tasbeeh_counter/screen_widget/tasbeeh_screen.dart';
import 'package:tasbeeh_counter/widget/app_background.dart';

class homeScreen extends StatefulWidget {

  static const String routeName = "homeScreen";
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int currentIndex = 2;

  final List<Widget>pages = [
    settings_screen(),
    alzehr_screen(),
    tasbeeh_screen(),
    statistics_screen(),
    //remembrance_screen()
  ];
  @override

  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:AppBackground(
        child : pages[currentIndex]
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: "الاعدادات",
          ),
          NavigationDestination(
             icon: Icon(Icons.eighteen_mp_outlined),
            label: "الاذكار",
          ),
          NavigationDestination(
           // icon: Icon(Icons.settings),
          icon: Icon(Icons.one_x_mobiledata_sharp),
            label: "السبحه",
          ),
          NavigationDestination(
            icon: Icon(Icons.radar),
            label: "الاحصائيات",
          ),
          /*NavigationDestination(
            icon: Icon(Icons.settings),
            label: "Settings",
          )*/
        ],

      ),
    );
  }
}
