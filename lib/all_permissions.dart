
import 'package:calling_app_project/core/core.dart';
import 'package:permission_handler/permission_handler.dart';

Future requestAllPermissions() async {
  var statuses =
      await [Permission.contacts, Permission.phone, Permission.sms].request();
  if (statuses[Permission.contacts]!.isGranted &&
      statuses[Permission.sms]!.isGranted &&
      statuses[Permission.phone]!.isGranted) {
    Core.flutterToast('All Permissions are granted');
  } else {
    if (statuses[Permission.contacts]!.isDenied ||
        statuses[Permission.sms]!.isDenied ||
        statuses[Permission.phone]!.isDenied) {
      await openAppSettings();
    } else {
      Core.flutterToast(
          'Some permission are still pending please allow pending permissions');
    }
  }
}
