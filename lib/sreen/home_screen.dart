import 'package:calling_app_project/contact/screen/contact_screen.dart';
import 'package:calling_app_project/core/core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    allowContactPermission();
  }

  void allowContactPermission() async {
    if (await Permission.contacts.isGranted) {
      if (mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ContactScreen(),
            ));
      }
    } else {
      PermissionStatus status = await Permission.contacts.request();
      if (status.isGranted) {
        if (mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ContactScreen(),
              ));
        }
      } else {
        if (await Permission.contacts.isPermanentlyDenied) {
          Core.flutterToast(
              'Permission denied permanently. Please enable it in settings.');
          openAppSettings();
        } else {
          Core.flutterToast(
              'Permission denied. Please allow access to proceed.');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assetss/images/contact.png',
              width: 390,
              height: 396.34,
            ),
            Text(
              'Access Your Call Logs',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'We need access to your contacts and call logs to help connect and manage your communication seamlessly.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5864F8),
                    minimumSize: Size(197, 44)),
                onPressed: () async {
                  allowContactPermission();
                },
                child: Text(
                  'Allow Access',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
