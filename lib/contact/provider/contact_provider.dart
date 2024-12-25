import 'package:calling_app_project/contact/service/contact_service.dart';
import 'package:calling_app_project/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactProvider extends ChangeNotifier {
  ContactProvider(this.contactService);

  final ContactService contactService;
  List<Contact> contacts = [];
  bool isLoading = false;
  bool permissionDenied = false;
  String? errorMsg;

  Future fetchContacts() async {
    try {
      isLoading = true;
      permissionDenied = true;
      errorMsg = null;
      notifyListeners();

      contacts = await contactService.fetchContacts();
      notifyListeners();

      if (contacts.isEmpty && !await FlutterContacts.requestPermission()) {
        permissionDenied = true;
        Core.flutterToast("Permission denied. Please enable it in settings.");
      }
    } catch (e) {
      errorMsg = "Failed to fetch contacts: ${e.toString()}";
      Core.flutterToast(errorMsg!);
    }notifyListeners();
  }

  String getContactType(Contact contact) {
    if (contact.organizations.isNotEmpty) {
      return "Business";
    }

    for (var phone in contact.phones) {
      if (phone.label.toString().toLowerCase().contains("work")) {
        return "Business";
      }
      if (phone.label.toString().toLowerCase().contains("home")) {
        return "Personal";
      }
    }

    return "Personal";
  }
}
