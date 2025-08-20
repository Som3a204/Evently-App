import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:evently_app/models/category_data.dart';
import 'package:evently_app/modules/layout/home/widgets/event_card_item.dart';
import 'package:evently_app/modules/layout/home/widgets/tab_bar_item_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<CategoryData> categoriesDataList = [
    CategoryData(name: "Sports", icon: Icons.sports_soccer),
    CategoryData(name: "Birthday", icon: Icons.sports_soccer),
    CategoryData(name: "Book Club", icon: Icons.menu_book),
    CategoryData(name: "Meeting", icon: Icons.meeting_room_outlined),
    CategoryData(name: "Exhibition", icon: Icons.sports_soccer),
  ];
  int selectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          Container(
            width: mediaQuery.size.width,
            padding: EdgeInsets.only(
              top: mediaQuery.size.height * 0.05,
              bottom: 25,
            ),
            decoration: BoxDecoration(color: theme.primaryColor, borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            )),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back ✨",
                            style: theme.textTheme.bodyLarge,
                          ),
                          Text(
                            "Hossam",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            spacing: 5,
                            children: [
                              ImageIcon(
                                AssetImage(Assets.mapIcn),
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                "Cairo, Egypt",
                                style: theme.textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Icon(
                            Icons.wb_sunny_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "EN",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: ColorPallette.primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                DefaultTabController(
                  length: categoriesDataList.length,
                  child: TabBar(
                    isScrollable: true,
                    indicator: BoxDecoration(),
                    dividerColor: Colors.transparent,
                    labelPadding: EdgeInsets.symmetric(horizontal: 5),
                    tabAlignment: TabAlignment.start,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    onTap: (index) {
                      setState(() {
                        selectedTabIndex = index;
                      });
                    },
                    tabs:
                        categoriesDataList.map((data) {
                          return TabBarItemWidget(categoryData: data,
                            isSelected: selectedTabIndex == categoriesDataList.indexOf(data),);
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return EventCardItem();
              },
              separatorBuilder: (context,index) {
                return SizedBox(height: 10);
              },
              itemCount: 10)
        ],
      ),
    );
  }
}
