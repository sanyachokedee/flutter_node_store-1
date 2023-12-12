// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_print

// หน้า login samit@email.com 123456

import 'package:flutter/material.dart';
import 'package:flutter_node_store/app_router.dart';
import 'package:flutter_node_store/providers/counter_provider.dart';
import 'package:flutter_node_store/providers/locale_provider.dart';
import 'package:flutter_node_store/providers/timer_provider.dart';
import 'package:flutter_node_store/themes/styles.dart';
import 'package:flutter_node_store/utils/utility.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_node_store/utils/utility.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// กำหนดตัวแปร initialRoute ให้กับ MaterialApp
var initialRoute;

void main() async {
  // Test Logger
  // Utility().testLogger();

  // ต้องเรียกใช้ WidgetsFlutterBinding.ensureInitialized()
  // เพื่อให้สามารถเรียกใช้ SharedPreferences ได้
  WidgetsFlutterBinding.ensureInitialized();

  // สร้างตัวแปร prefs เพื่อเรียกใช้ SharedPreferences
  // SharedPreferences prefs = await SharedPreferences.getInstance(); // เอาออกเพราะใช้แบบ re-use ใหม่ด้านล่าง
  // แบบใหม่
  await Utility.initSharedPrefs(); // จะไปทั่วทั้ง App

  // ถ้า login แล้ว ให้ไป ที่ Dashboard
  if (Utility.getSharedPreference('loginStatus') == true) {
    initialRoute = AppRouter.dashboard;
  }
  // ตรวจสอบว่าเคยแสดง Intro แล้วหรือยัง
  else if (Utility.getSharedPreference('welcomeStatus') == true) {
    // ถ้าเคยแสดง Intro แล้ว ให้ไปยังหน้า Login
    initialRoute = AppRouter.login;
  } else {
    // ถ้ายังไม่เคยแสดง Intro ให้ไปยังหน้า Welcome
    initialRoute = AppRouter.welcome;
  }

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CounterProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TimerProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocaleProvider(
            const Locale('en'),
          ),
        )
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, locale, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale.locale,
            theme: AppTheme.lightTheme,
            initialRoute: initialRoute,
            routes: AppRouter.routes,
          );
        },
      ),
    );
  }
}
