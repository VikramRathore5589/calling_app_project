import 'package:calling_app_project/contact/provider/contact_provider.dart';
import 'package:calling_app_project/contact/screen/contact_listtile_screen.dart';
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
    ContactProvider contactProvider =
        Provider.of<ContactProvider>(context, listen: false);
    await contactProvider.fetchContacts();
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
                    // Section header for the first letter
                    Container(
                      margin: const EdgeInsets.only(left: 15, top: 10),
                      width: double.infinity,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, top: 6, bottom: 8),
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
                    Column(
                      children: [
                        for (var contact in contactsForLetter)
                          ContactListTile(
                            contact: contact,
                            provider: provider,
                          ),
                      ],
                    )
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
