import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:calling_app_project/sms/provider/sms_provider.dart';

class SmsScreen extends StatelessWidget {
  const SmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future loadMessage() async {
      await Provider.of<SmsProvider>(context, listen: false).loadMessages();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("SMS Viewer"),
      ),
      body: FutureBuilder(
        future:Future.microtask((){ loadMessage();}),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Consumer<SmsProvider>(
              builder: (context, smsProvider, child) {
                if (smsProvider.messagesList.isEmpty) {
                  return const Center(child: Text("No SMS found"));
                } else {
                  Map<String, List<dynamic>> groupedMessages =
                      <String, List<dynamic>>{};
                  for (var sms in smsProvider.messagesList) {
                    if (sms.address != null) {
                      groupedMessages
                          .putIfAbsent(sms.address!, () => [])
                          .add(sms);
                    }
                  }
                  return ListView.builder(
                    itemCount: groupedMessages.length,
                    itemBuilder: (context, index) {
                      final sender = groupedMessages.keys.elementAt(index);
                      final messages = groupedMessages[sender]!;
                      return ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        title: Text(sender),
                        subtitle: Text(
                          messages.first.body?? 'no messages',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 10,
                          child: Text(
                            "${messages.length}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
