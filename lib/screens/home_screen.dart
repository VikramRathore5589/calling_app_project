import 'package:calling_app_project/contact/screen/contact_screen.dart';
import 'package:calling_app_project/core/core.dart';
import 'package:calling_app_project/tabbar/screen/tabbar_screen.dart';
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
    PermissionStatus permissionStatus = await Permission.contacts.status;

    if (permissionStatus.isGranted) {
      if (mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TabBarExample(),
            ));
      }
    } else {
      PermissionStatus status = await Permission.contacts.request();

      if (status.isGranted) {
        if (mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TabBarExample(),
              ));
        }
      } else {
        if (status.isDenied) {
          Core.flutterToast('Permission denied. Please allow access to proceed.');
        } else if (status.isPermanentlyDenied) {
          Core.flutterToast(
              'Permission denied permanently. Please enable it in settings.');
          openAppSettings();
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
                  allowContactPermission(); // Trigger permission request when button is pressed
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
