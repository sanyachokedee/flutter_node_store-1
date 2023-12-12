// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_node_store/app_router.dart';
import 'package:flutter_node_store/screens/bottomnavpage/home_screen.dart';
import 'package:flutter_node_store/screens/bottomnavpage/notification_screen.dart';
import 'package:flutter_node_store/screens/bottomnavpage/profile_screen.dart';
import 'package:flutter_node_store/screens/bottomnavpage/report_screen.dart';
import 'package:flutter_node_store/screens/bottomnavpage/setting_screen.dart';
import 'package:flutter_node_store/themes/colors.dart';
import 'package:flutter_node_store/utils/utility.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Start การสร้าง Bottom Navigation bar ------------------------
  // สร้างตัวแปรเก็บ Title ของแต่ละหน้า
  String _title = 'Flutter Store';

  // สร้างตัวแปรเก็บ index ของแต่ละหน้า
  int _currentIndex = 2; // เริ่มต้นให้เป็น 0

  // สร้าง List ของแต่ละหน้า
  final List<Widget> _children = [
    HomeScreen(),
    ReportScreen(),
    NotificationScreen(),
    SettingScreen(),
    ProfileScreen(),
  ];

  // ฟังก์ชันในการเปลี่ยนหน้า โดยรับค่า index จากการกดที่ bottomNavigationBar https://youtu.be/nPotlSREjpM?t=8118
  void onTabTapped(int index) {
    setState(
      () {
        _currentIndex = index;
        switch (index) {
          case 0:
            _title = AppLocalizations.of(context)!.menu_home;
            break;
          case 1:
            _title = AppLocalizations.of(context)!.menu_report;
            break;
          case 2:
            _title = AppLocalizations.of(context)!.menu_notification;
            break;
          case 3:
            _title = AppLocalizations.of(context)!.menu_setting;
            break;
          case 4:
            _title = AppLocalizations.of(context)!.menu_profile;
            break;
          default:
            _title = 'Flutter Store';
        }
      },
    );
  }
// End การสร้าง Bottom Navigation bar ------------------------

  // Logout function ---------------------------------------
  _logout() {
    Utility.removeSharedPreference('token');
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouter.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      // Drawer ทางด้านซ้าย
      drawer: Drawer(
        // backgroundColor: primary,
        child: Column(
          children: [
            ListView(
              shrinkWrap: true, // ShrinkWrap คือ การให้เมนูเลื่อนไปทั้งก้อน
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text('Nutthakit Anansuksakul'),
                  accountEmail: Text('nutthakit@gmail.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/samitk.jpg'),
                  ),
                  otherAccountsPictures: [
                    CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/noavartar.png')),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/samitk.jpg'),
                    )
                  ],
                ),
                ListTile(
                    leading: Icon(Icons.timer_outlined),
                    title: Text('Counter (With Stateful)'),
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.counterStateful);
                    }),
                ListTile(
                  leading: Icon(Icons.timer_outlined),
                  title: Text('Counter (With StaleProvider)'),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.counterProvider);
                  },
                ),
                ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text('Info'),
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.info);
                    }),
                ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('About'),
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.about);
                    }),
                ListTile(
                  leading: Icon(Icons.email_outlined),
                  title: Text('contact'),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.contact);
                  },
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    leading: Icon(Icons.exit_to_app_outlined),
                    title: Text('Logout'),
                    onTap: _logout,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      // endDrawer: Drawer(),  // Drawer ทางด้านขวา
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          onTabTapped(value);
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryDark,
        unselectedItemColor: secondaryText,
        // backgroundColorL primary,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: AppLocalizations.of(context)!.menu_home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: AppLocalizations.of(context)!.menu_report,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: AppLocalizations.of(context)!.menu_notification,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: AppLocalizations.of(context)!.menu_setting,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: AppLocalizations.of(context)!.menu_profile,
          ),
        ],
      ),
    );
  }
}
