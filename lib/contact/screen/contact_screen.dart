import 'package:calling_app_project/contact/provider/contact_provider.dart';
import 'package:calling_app_project/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  void initState() {
    super.initState();
    fetchContact();
  }

  Future<void> fetchContact() async {
    Future.microtask(() {
      ContactProvider contactProvider =
          Provider.of<ContactProvider>(context, listen: false);
      contactProvider.fetchContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) {
          if (provider.contacts.isEmpty) {
            return const Center(child: Text("No contacts found"));
          }

          final Map<String, List<Contact>> groupedContacts = {};
          for (var contact in provider.contacts) {
            if (contact.displayName.isNotEmpty) {
              final firstLetter = contact.displayName[0].toUpperCase();
              groupedContacts.putIfAbsent(firstLetter, () => []).add(contact);
            }
          }

          final sortedKeys = groupedContacts.keys.toList()..sort();

          return ListView.builder(
            itemCount: sortedKeys.length,
            itemBuilder: (context, index) {
              final letter = sortedKeys[index];
              final contactsForLetter = groupedContacts[letter]!;

              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15, top: 10),
                          width: double.infinity,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 6, bottom: 8),
                            child: Text(
                              letter,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        // List of contacts for the specific letter
                        ...contactsForLetter.map((contact) {
                          final contactType = provider.getContactType(contact);
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileDetailsScreen(
                                        callLogList: contact),
                                  ));
                            },
                            leading: contact.photo != null
                                ? CircleAvatar(
                                    backgroundImage:
                                        MemoryImage(contact.photo!),
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.lightBlue[50],
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    ),
                                  ),
                            title: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    contact.displayName,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  height: 22,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.lightBlue[50],
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.blue,
                                      )),
                                  child: Center(
                                    child: Text(
                                      contactType,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: contactType == "Business"
                                            ? Colors.green
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                      ]));
            },
          );
        },
      ),
    );
  }
}
