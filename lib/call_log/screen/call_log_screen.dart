import 'package:call_e_log/call_log.dart';
import 'package:calling_app_project/call_log/provider/call_log_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart'; // For date formatting

class CallLogScreen extends StatefulWidget {
  const CallLogScreen({super.key});

  @override
  State<CallLogScreen> createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      fetchCallLogs();
    });
  }

  Future fetchCallLogs() async {
    CallLogProvider provider = Provider.of(context, listen: false);
    await provider.fetchCallLogs();
  }

  String formatTimestamp(int timestamp, {required String callType}) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return DateFormat('hh:mm a').format(dateTime);
    } else if (dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day) {
      return "Yesterday";
    } else {
      return DateFormat('MM/dd/yyyy').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Consumer<CallLogProvider>(builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.callLogList.length,
            itemBuilder: (context, index) {
              CallLogEntry callLog=provider.callLogList[index];
              String callType =
                  callLog.callType?.name.toLowerCase() ?? '-';
              int timestamp = callLog.timestamp ?? 0;

              IconData callIcon;
              Color iconColor;

              switch (callType) {
                case 'missed':
                  callIcon = Icons.call_missed;
                  iconColor = Colors.red;
                  break;
                case 'outgoing':
                  callIcon = Icons.call_made;
                  iconColor = Colors.green;
                  break;
                case 'incoming':
                  callIcon = Icons.call_received;
                  iconColor = Colors.blue;
                  break;
                case 'spam':
                  callIcon = Icons.warning;
                  iconColor = Colors.red;
                  break;
                default:
                  callIcon = Icons.help;
                  iconColor = Colors.grey;
              }

              return ListTile(
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) =>
                //             ProfileDetailsScreen(callLogList: callLogEntry),
                //       ));
                // },
                leading: CircleAvatar(
                  backgroundColor: Colors.lightBlue[50],
                  child: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                ),
                title: Text(
                  callLog.name ?? callLog.number ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: [
                    Icon(
                      callIcon,
                      color: iconColor,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(callType),
                    SizedBox(width: 8),
                    Text(formatTimestamp(timestamp, callType: callType)),
                  ],
                ),
                trailing: FaIcon(
                  FontAwesomeIcons.circleExclamation,
                  size: 17,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
