import 'package:calling_app_project/call_log/call_screen.dart';
import 'package:calling_app_project/contact/provider/contact_provider.dart';
import 'package:calling_app_project/contact/service/contact_service.dart';
import 'package:calling_app_project/sreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactProvider(ContactService()),
        ),

      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: CallLogScreen()),
    );
  }
}
