import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:pro/call/call_log_service.dart';

class CallLogScreen extends StatefulWidget {
  const CallLogScreen({super.key});

  @override
  State<CallLogScreen> createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen> {
  List<CallLogEntry> callLogsList = [];

  @override
  void initState() {
    fetchCallLogs();
    super.initState();
  }

  Future fetchCallLogs() async {
    callLogsList = await CallLogService.fetchCallLogs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call logs'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
            itemCount: callLogsList.length,
            itemBuilder: (context, index) {
              CallLogEntry callLogEntry = callLogsList[index];

              String callType = callLogEntry.callType?.name ?? '-';
              int timestamp = callLogEntry.timestamp ?? 0;
              return ListTile(
                title: Text(
                  callLogEntry.name ?? callLogEntry.number ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: [
                    Text(callType),
                    Text(timestamp.toString()),
                  ],
                ),
              );
            }),
      ),
    );
  }
}