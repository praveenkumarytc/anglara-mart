// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce/data/model/dash_board_tab_model.dart';
import 'package:ecommerce/ui/cart/cart_screen.dart';
import 'package:ecommerce/utils/asset_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../helper/network_info.dart';
import '../../utils/color_resources.dart';
import '../home/home_screen.dart';
import '../profile/profile_page.dart';
import 'custom_drawer.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _pageIndex = 2;

  final List<Widget> _screens = [
    HomeScreen(),
    CartScreen(isBackButton: false),
    ProfilePage(
      backExist: false,
    )
  ];

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.initialIndex;

    NetworkInfo.checkConnectivity(context);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _pageIndex != 0
          ? null
          : AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer(); // Open the drawer
                  },
                  icon: Image.asset(
                    Images.drawerImage,
                    scale: 15,
                  )),
              backgroundColor: Colors.white,
            ),
      drawer: CustomDrawer(),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(4),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            currentIndex: _pageIndex,
            onTap: (int index) {
              setState(() {
                _pageIndex = index;
              });
            },
            backgroundColor: ColorResources.PRIMARY_MATERIAL.shade50,
            showSelectedLabels: true,
            iconSize: 20,
            showUnselectedLabels: true,
            elevation: 0.0,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            selectedItemColor: ColorResources.PRIMARY_MATERIAL,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorResources.PRIMARY_MATERIAL,
            ),
            type: BottomNavigationBarType.fixed,
            items: List.generate(
              _tabs.length,
              (index) => BottomNavigationBarItem(
                icon: Icon(_tabs[index].icondata),
                label: _tabs[index].tabTitle,
                tooltip: _tabs[index].tabTitle,
              ),
            ),
          ),
        ),
      ),
      body: _screens[_pageIndex],
    );
  }

  final List<TabModel> _tabs = [
    TabModel(icondata: CupertinoIcons.home, tabTitle: 'Home'),
    TabModel(icondata: Icons.shopping_cart_outlined, tabTitle: 'Cart'),
    TabModel(icondata: CupertinoIcons.person, tabTitle: 'Profile')
  ];
}
