import 'package:calling_app_project/contact/provider/contact_provider.dart';
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

  Future fetchContact() async {
    ContactProvider contactProvider =
        Provider.of<ContactProvider>(context, listen: false);
    await contactProvider.fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assetss/images/surefy app bar logo.png'),
        actions: [Image.asset('assetss/images/search icon.png')],
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) {
          if (provider.contacts.isEmpty) {
            return Center(child: Text("No contacts found"));
          }

          Map<String, List<Contact>> groupedContacts = {};

          for (var contact in provider.contacts) {
            if (contact.displayName.isNotEmpty) {
              final firstLetter = contact.displayName[0].toUpperCase();
              if (!groupedContacts.containsKey(firstLetter)) {
                groupedContacts[firstLetter] = [];
              }
              groupedContacts[firstLetter]!.add(contact);
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
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      width: double.infinity,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(40)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 6,bottom: 8),
                        child: Text(
                          letter,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    ...contactsForLetter.map((contact) {
                      final contactType = provider.getContactType(contact);
                      return ListTile(
                        leading: contact.photo != null
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(contact.photo!),
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
                    }),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
