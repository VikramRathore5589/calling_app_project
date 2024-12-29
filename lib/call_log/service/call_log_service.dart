import 'package:call_e_log/call_log.dart';
import 'package:permission_handler/permission_handler.dart';

class CallLogService {
  Future<List<CallLogEntry>> fetchCallLogs() async {
    if (await Permission.phone.isGranted) {
      Iterable<CallLogEntry> entries = await CallLog.get();
      return entries.toList();
    } else {
      throw 'Permission is not granted Please allow Permission';
    }
  }
}
