import 'package:calling_app_project/profile/model/profile_model_class.dart';
import 'package:flutter/material.dart';

class ProfileGridviewBuilder extends StatelessWidget {
   ProfileGridviewBuilder({super.key});
  List<CallIcon> iconTextList = [
    CallIcon(text: 'Call', icon: Icons.call),
    CallIcon(text: 'Message', icon: Icons.message),
    CallIcon(
      text: 'Notes',
      icon: Icons.note_alt_sharp,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: iconTextList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1.8),
        itemBuilder: (context, index) {
          CallIcon list = iconTextList[index];
          return Padding(
            padding: const EdgeInsets.only(left: 30, right: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    list.icon,
                    color: Color(0xFF000000),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    list.text,
                    style: const TextStyle(color: Color(0xFF000000)),
                  )
                ],
              ),
            ),
          );
        });
  }
}
