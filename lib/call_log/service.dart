import 'package:call_log/call_log.dart';

class CallLogService {
  static Future<List<CallLogEntry>> fetchCallLogs() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    return entries.toList();
  }
}