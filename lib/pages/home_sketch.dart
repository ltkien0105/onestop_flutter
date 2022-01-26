import 'package:flutter/material.dart';
import 'package:onestop_dev/globals/myColors.dart';
import 'package:onestop_dev/globals/myFonts.dart';
import 'package:onestop_dev/globals/sizeConfig.dart';
import 'package:onestop_dev/stores/login_store.dart';
import 'package:onestop_dev/widgets/appbar.dart';
import 'package:onestop_dev/widgets/homeTabTile.dart';
import 'package:provider/provider.dart';

class HomePageSketch extends StatefulWidget {
  static String id = "/home2";
  const HomePageSketch({Key? key}) : super(key: key);

  @override
  State<HomePageSketch> createState() => _HomePageSketchState();
}

class _HomePageSketchState extends State<HomePageSketch> {
  int index = 0;
  final tabs = [
    HomeTab(),
    Center(
        child: Text(
      'Food',
      style: MyFonts.extraBold.setColor(kWhite).size(30),
    )),
    Center(
        child: Text(
      'Travel',
      style: MyFonts.extraBold.setColor(kWhite).size(30),
    )),
    Center(
        child: Text(
      'Timetable',
      style: MyFonts.extraBold.setColor(kWhite).size(30),
    )),
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: appBar(context),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: lGrey,
              labelTextStyle:
                  MaterialStateProperty.all(MyFonts.medium.setColor(kTabText)),
              iconTheme:
                  MaterialStateProperty.all(IconThemeData(color: kTabText))),
          child: NavigationBar(
            backgroundColor: kTabBar,
            selectedIndex: index,
            onDestinationSelected: (index) => setState(() {
              this.index = index;
            }),
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
                selectedIcon: Icon(
                  Icons.home_filled,
                  color: lBlue2,
                ),
              ),
              NavigationDestination(
                icon: Icon(Icons.restaurant_outlined),
                label: 'Food',
                selectedIcon: Icon(
                  Icons.restaurant_outlined,
                  color: lBlue2,
                ),
              ),
              NavigationDestination(
                icon: Icon(Icons.directions_bus_outlined),
                label: 'Travel',
                selectedIcon: Icon(
                  Icons.directions_bus,
                  color: lBlue2,
                ),
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_today_outlined),
                label: 'Timetable',
                selectedIcon: Icon(
                  Icons.calendar_today,
                  color: lBlue2,
                ),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 1 * MediaQuery.of(context).size.height,
              child: tabs[index],
            ),
          ),
        ));
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: MapSample()),
        Expanded(flex: 1, child: DateCourse()),
        SizedBox(
          height: 10,
        ),
        Expanded(flex: 1, child: QuickLinks()),
        SizedBox(
          height: 10,
        ),
        Expanded(flex: 1, child: Services()),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class MapSample extends StatelessWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/sample_map.png');
  }
}

class DateCourse extends StatelessWidget {
  const DateCourse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: FittedBox(
            child: Column(
              children: [
                FittedBox(
                    child: Text('MON',
                        style: MyFonts.medium.size(25).setColor(kWhite))),
                FittedBox(
                    child: Text(
                  '24',
                  style: MyFonts.extraBold.size(50).setColor(kWhite),
                ))
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromRGBO(101, 174, 130, 0.16)),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 100,
            child: Icon(Icons.keyboard_arrow_down_sharp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromRGBO(101, 174, 130, 0.16)),
          ),
        )
      ],
    );
  }
}

class QuickLinks extends StatelessWidget {
  const QuickLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kHomeTile,
      ),
      child: Container(
        height: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: FittedBox(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    'Quick Links',
                    style: MyFonts.medium.size(10).setColor(kWhite),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  HomeTabTile(
                      label: "IP Settings", icon: Icons.computer_outlined),
                  SizedBox(
                    width: 5,
                  ),
                  HomeTabTile(label: "Papers", icon: Icons.article_outlined),
                  SizedBox(
                    width: 5,
                  ),
                  HomeTabTile(
                      label: "Medical Emergency",
                      icon: Icons.medical_services_outlined),
                  SizedBox(
                    width: 5,
                  ),
                  HomeTabTile(
                      label: "Contacts", icon: Icons.contact_mail_outlined),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}

class Services extends StatelessWidget {
  const Services({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kHomeTile,
      ),
      child: Container(
        height: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: FittedBox(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    'Services',
                    style: MyFonts.medium.size(10).setColor(kWhite),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  HomeTabTile(
                      label: "Lost and Found",
                      icon: Icons.find_in_page_outlined),
                  SizedBox(
                    width: 5,
                  ),
                  HomeTabTile(
                      label: "Rent and Sell", icon: Icons.local_atm_outlined),
                  SizedBox(
                    width: 5,
                  ),
                  HomeTabTile(
                      label: "Shops", icon: Icons.shopping_cart_outlined),
                  SizedBox(
                    width: 5,
                  ),
                  HomeTabTile(label: "Intranet", icon: Icons.language_outlined),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}