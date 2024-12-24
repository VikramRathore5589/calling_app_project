import 'package:calling_app_project/contact/provider/contact_provider.dart';
import 'package:calling_app_project/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactListTile extends StatelessWidget {
  final Contact contact;
  final ContactProvider provider;

  const ContactListTile({Key? key, required this.contact, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactType = provider.getContactType(contact) ?? "Unknown";

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileDetailsScreen(callLogList: contact),
          ),
        );
      },
      leading: CircleAvatar(
        backgroundImage: contact.photo != null
            ? MemoryImage(contact.photo!)
            : null,
        backgroundColor: contact.photo == null ? Colors.lightBlue[50] : null,
        child: contact.photo == null ? Icon(Icons.person, color: Colors.blue) : null,
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              contact.displayName ?? "Unknown",
              style: _contactNameStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          ContactTypeBadge(contactType: contactType),
        ],
      ),
    );
  }

  static const TextStyle _contactNameStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}

class ContactTypeBadge extends StatelessWidget {
  final String contactType;

  const ContactTypeBadge({Key? key, required this.contactType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue),
      ),
      child: Center(
        child: Text(
          contactType,
          style: TextStyle(
            fontSize: 12,
            color: contactType == "Business" ? Colors.green : Colors.black,
          ),
        ),
      ),
    );
  }
}
