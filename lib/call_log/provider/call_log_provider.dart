import 'package:call_e_log/call_log.dart';
import 'package:calling_app_project/call_log/service/call_log_service.dart';
import 'package:calling_app_project/core/core.dart';
import 'package:flutter/material.dart';

class CallLogProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMsg;
  final CallLogService callLogService;

  CallLogProvider(this.callLogService);

  List<CallLogEntry> callLogList = [];

  Future fetchCallLogs() async {
    try {
      errorMsg = null;
      isLoading = true;
      // notifyListeners();
      callLogList = await callLogService.fetchCallLogs();
      print('fetched call logs');
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMsg = e.toString();
      Core.flutterToast(errorMsg!);
    }
    notifyListeners();
  }
}
