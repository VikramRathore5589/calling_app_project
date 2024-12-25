import 'package:calling_app_project/core/core.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestAllPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.contacts,
    Permission.sms,
    Permission.phone,
  ].request();

  if (statuses[Permission.contacts]!.isGranted &&
      statuses[Permission.sms]!.isGranted &&
      statuses[Permission.phone]!.isGranted) {
    Core.flutterToast('All Permissions granted Continue ');
  } else {
    if (statuses[Permission.contacts]!.isDenied ||
        statuses[Permission.sms]!.isDenied ||
        statuses[Permission.phone]!.isDenied) {
      Core.flutterToast(
          'Some permissions were denied. Opening app settings... and allow to continue ');
      await openAppSettings();
    } else {
      Core.flutterToast('Some permissions are still pending.');
    }
  }
}
