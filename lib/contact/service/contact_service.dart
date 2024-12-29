import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactService {

  Future<List<Contact>> fetchContacts() async {
    if (await Permission.contacts.isGranted) {
      return await FlutterContacts.getContacts();
    } else {
      throw Exception('Permission Not granted Please allow permission');
    }
  }
}
