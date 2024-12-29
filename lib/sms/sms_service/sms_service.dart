import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

class SmsService {
Telephony telephony=Telephony.instance;
  Future<List<SmsMessage>> fetchSms() async {
    if (await Permission.sms.isGranted) {
      return await telephony.getInboxSms(
      );
    } else {
      throw Exception("SMS Permissions not granted");
    }
  }
}