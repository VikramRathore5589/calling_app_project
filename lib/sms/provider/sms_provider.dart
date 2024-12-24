import 'package:calling_app_project/core/core.dart';
import 'package:calling_app_project/sms/sms_service/sms_service.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class SmsProvider extends ChangeNotifier {
  final SmsService smsService;

  SmsProvider(this.smsService);

  List<SmsMessage> messagesList = [];
  bool isLoading = false;
  String? errorMsg;

  Future<void> loadMessages() async {
    errorMsg = null;
    isLoading = true;
    notifyListeners();

    try {
      messagesList = await smsService.fetchSms();
      notifyListeners();
    } catch (e) {
      errorMsg = e.toString();
      isLoading = false;
      Core.flutterToast(errorMsg!);
    }

    notifyListeners();
  }
}
