import 'package:evently_app/core/constants/assets.dart';
import 'package:evently_app/core/routes/page_route_name.dart';
import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:evently_app/modules/layout/profile/profile_view.dart';
import 'package:flutter/material.dart';

import 'favorites/favorites_view.dart';
import 'home/home_view.dart';
import 'maps/maps_view.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

int selectedIndex = 0;

List<Widget> screens = [
HomeView(),
  MapsView(),
  FavoritesView(),
  ProfileView()
];
class _LayoutViewState extends State<LayoutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.pushNamed(context, PageRouteName.eventCreation);
        },
        child: CircleAvatar(
          radius: 32,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 26,
            backgroundColor: ColorPallette.primaryColor,
            child: Icon(Icons.add,color: Colors.white, size: 30),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Assets.homeIcn)),
            activeIcon: ImageIcon(AssetImage(Assets.homeActiveIcn)),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Assets.mapIcn)),
            activeIcon: ImageIcon(AssetImage(Assets.mapActiveIcn)),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Assets.favouriteIcn)),
            activeIcon: ImageIcon(AssetImage(Assets.favouriteActiveIcn)),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Assets.userIcn)),
            activeIcon: ImageIcon(AssetImage(Assets.userActiveIcn)),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
