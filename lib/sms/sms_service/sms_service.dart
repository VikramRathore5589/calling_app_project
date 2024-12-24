import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

class SmsService {
  final Telephony telephony = Telephony.instance;

  Future<List<SmsMessage>> fetchSms() async {
     final bool? permissionsGranted = await telephony.requestSmsPermissions;
    if (permissionsGranted!) {
      return await telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
        sortOrder: [OrderBy(SmsColumn.DATE, sort: Sort.DESC)],
      );
    } else {
      throw Exception("SMS Permissions not granted");
    }
  }
}