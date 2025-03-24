import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin/constants/colors.dart';
import 'package:pingcoin/controllers/coinController.dart';
import 'package:pingcoin/controllers/contentController.dart';
import 'package:pingcoin/views/dashboard/subScreens/demo.dart';
import 'package:pingcoin/views/dashboard/subScreens/home.dart';
import 'package:pingcoin/views/dashboard/subScreens/more.dart';
import 'package:pingcoin/views/dashboard/subScreens/profile.dart';
import 'package:pingcoin/views/dashboard/subScreens/search.dart';

class Dashboard extends StatefulWidget {
  int? index;

  Dashboard({super.key, this.index});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  Widget _selectedScreen = Container();

  @override
  void initState() {
    if (widget.index == null) {
      setState(() {
        _selectedScreen = HomeScreen();
      });
    } else {
      setState(() {
        _selectedScreen = DemoScreen();
        _selectedIndex = 2;
      });
    }

    Get.find<CoinController>().getCoins();
    Get.find<ContentController>().getContent();
    Get.find<ContentController>().getAllFaqs();

  }

  final List<Widget> _pages = const [
    HomeScreen(),
    SearchScreen(),
    DemoScreen(),
    ProfileScreen(),
    MoreScreen(),
  ];

  // Function to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedScreen = _pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: _selectedScreen,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: rBg,
        selectedItemColor: rGreen,
        unselectedItemColor: rHint,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedLabelStyle: TextStyle(color: rGreen),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svgs/home.svg"),
              label: 'Home',
              activeIcon: SvgPicture.asset(
                "assets/svgs/home.svg",
                color: rGreen,
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svgs/search.svg"),
              label: 'Search',
              activeIcon: SvgPicture.asset(
                "assets/svgs/search.svg",
                color: rGreen,
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svgs/video.svg"),
              label: 'Demo',
              activeIcon: SvgPicture.asset(
                "assets/svgs/video.svg",
                color: rGreen,
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svgs/profile.svg"),
              label: 'Profile',
              activeIcon: SvgPicture.asset(
                "assets/svgs/profile.svg",
                color: rGreen,
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svgs/more.svg"),
              label: 'More',
              activeIcon: SvgPicture.asset(
                "assets/svgs/more.svg",
                color: rGreen,
              )),
        ],
      ),
    );
  }
}
