import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Core{
   static void flutterToast(String msg){
    Fluttertoast.showToast(msg: msg);
  }
   static String formatTimestamp({required int timestamp, required callType}) {
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
}