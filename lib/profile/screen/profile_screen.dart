import 'package:call_e_log/call_log.dart';
import 'package:calling_app_project/profile/screen/profile_gridView_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';

class ProfileDetailsScreen extends StatelessWidget {
  ProfileDetailsScreen({super.key, required this.callLogList});

  final Contact callLogList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assetss/images/Rectangle 39872.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      // Overlay for text and icon
                      Positioned(
                        top: 50,
                        right: 50,
                        left: 50,
                        child: Center(
                          child: Text(
                            'Profile Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        right: 16,
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Profile Image
              Positioned(
                bottom: -50,
                left: MediaQuery.of(context).size.width / 2 - 70,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue[100],
                    radius: 67,
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.blue,
                    ),
                    // backgroundImage: const AssetImage(
                    //   'assetss/images/akshita image.png',
                    // ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Image.asset(
            'assetss/images/Vector.png',
            height: 20,
            width: 20,
          ),
          const SizedBox(height: 10),
          Text(callLogList.displayName ?? 'Unknown'),
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: ProfileGridviewBuilder(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 33.0, top: 8),
            child: Align(
                alignment: Alignment.topLeft, child: Text('Contact Info')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 33.0, top: 8, right: 10),
            child: Container(
              height: 60,
              width: double.infinity,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(callLogList.phones.toString()),
                        Text('Mobile')
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.call),
                        SizedBox(
                          width: 12,
                        ),
                        Icon(Icons.message)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 33.0, top: 8),
            child: Align(alignment: Alignment.topLeft, child: Text('Other')),
          ),
          buildPadding('Add to favourite', Icons.favorite_border, Colors.black,
              Colors.black),
          buildPadding('Delete Contact', Icons.delete, Colors.red, Colors.red),
        ],
      ),
    );
  }

  Padding buildPadding(
      String text, IconData icon, Color iconColor, Color textColors) {
    return Padding(
      padding: const EdgeInsets.only(left: 33.0, top: 8, right: 10),
      child: Container(
          height: 50,
          width: double.infinity,
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
          child: ListTile(
            leading: Icon(
              icon,
              color: iconColor,
            ),
            title: Text(
              text,
              style: TextStyle(color: textColors),
            ),
          )),
    );
  }
}
