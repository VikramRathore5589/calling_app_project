import 'package:flutter_contacts/flutter_contacts.dart';

class ContactService {

  Future<List<Contact>> fetchContacts() async {
    if (await FlutterContacts.requestPermission()) {
      return await FlutterContacts.getContacts();
    } else {
      throw Exception('Permission denied');
    }
  }
}
