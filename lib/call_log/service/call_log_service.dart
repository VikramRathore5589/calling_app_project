import 'package:call_e_log/call_log.dart';

class CallLogService {
   Future<List<CallLogEntry>> fetchCallLogs() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    return entries.toList();
  }
}