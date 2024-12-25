import 'package:calling_app_project/all_permissions.dart';
import 'package:calling_app_project/bottom_navigation_bar/provider/bottom_navigation_bar_provider.dart';
import 'package:calling_app_project/bottom_navigation_bar/screen/bottom_navigation_bar_screen.dart';
import 'package:calling_app_project/call_log/provider/call_log_provider.dart';
import 'package:calling_app_project/call_log/service/call_log_service.dart';
import 'package:calling_app_project/contact/provider/contact_provider.dart';
import 'package:calling_app_project/contact/service/contact_service.dart';
import 'package:calling_app_project/sms/provider/sms_provider.dart';
import 'package:calling_app_project/sms/sms_service/sms_service.dart';
import 'package:calling_app_project/screens/splash_screen.dart';
import 'package:calling_app_project/tabbar/provider/tabbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  requestAllPermissions();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactProvider(ContactService()),
        ),
        ChangeNotifierProvider(
          create: (context) => TabProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SmsProvider(SmsService()),
        ),
        ChangeNotifierProvider(
          create: (context) => CallLogProvider(CallLogService()),
        ),ChangeNotifierProvider(
          create: (context) => BottomNavigationBarProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: BottomNavigationBarScreen()),
    );
  }
}
