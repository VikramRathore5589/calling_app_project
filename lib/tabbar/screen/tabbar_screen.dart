import 'package:calling_app_project/call_log/screen/call_log_screen.dart';
import 'package:calling_app_project/contact/screen/contact_screen.dart';
import 'package:calling_app_project/sms/screen/sms_screen.dart';
import 'package:calling_app_project/tabbar/provider/tabbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabBarExample extends StatelessWidget {
  final List<String> titles = ["Calls", "Contacts", "Messages", "Favourite"];
  final List<Widget> screens = [
    CallLogScreen(),
    ContactScreen(),
    SmsScreen(),
    ContactScreen(),
  ];

   TabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TabProvider>(
      builder: (context, provider, child) {
        return DefaultTabController(
          length: titles.length,
          child: Scaffold(
            appBar: AppBar(
              title: Image.asset('assetss/images/surefy app bar logo.png'),
              actions: [Image.asset('assetss/images/search icon.png'),SizedBox(width: 10,)],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  isScrollable: true,
                  onTap: (index) {
                    provider.updateIndex(index);
                  },
                  tabs: List.generate(titles.length, (index) {
                    String title = titles[index];
                    return buildTab(title, index, provider.selectedIndex);
                  }),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: IndexedStack(
                index: provider.selectedIndex,
                children: screens,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildTab(String title, int index, int selectedIndex) {
    return Container(
      height: 30,
      width: 100,
      margin: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: selectedIndex == index ? Colors.blue : Colors.grey[300],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: selectedIndex == index ? Colors.white : Colors.black,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: selectedIndex == index ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
