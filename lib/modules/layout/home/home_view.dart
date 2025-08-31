import 'package:evently_app/core/routes/page_route_name.dart';
import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:evently_app/core/utils/firebase_firestore_utils.dart';
import 'package:evently_app/models/category_data.dart';
import 'package:evently_app/models/event_data.dart';
import 'package:evently_app/modules/layout/home/widgets/event_card_item.dart';
import 'package:evently_app/modules/layout/home/widgets/tab_bar_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../../../core/constants/assets.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<CategoryData> categoriesDataList = [
    CategoryData(
      id: "sports",
      image: Assets.sportsImg,
      name: "Sports",
      icon: Icons.sports_soccer,
    ),
    CategoryData(
      id: "book_club",
      image: Assets.bookClubImg,
      name: "Book Club",
      icon: Icons.music_note,
    ),
    CategoryData(
      id: "birthday",
      image: Assets.birthdayImg,
      name: "Birthday",
      icon: Icons.cake_outlined,
    ),
    CategoryData(
      id: "meeting",
      image: Assets.meetingImg,
      name: "Meeting",
      icon: Icons.art_track,
    ),
    CategoryData(
      id: "gaming",
      image: Assets.gamingImg,
      name: "Gaming",
      icon: Icons.theater_comedy,
    ),
    CategoryData(
      id: "eating",
      image: Assets.eatingImg,
      name: "Eating",
      icon: Icons.fastfood_outlined,
    ),
    CategoryData(
      id: "holiday",
      image: Assets.holidayImg,
      name: "Holiday",
      icon: Icons.music_note,
    ),
    CategoryData(
      id: "exhibition",
      image: Assets.exhibitionImg,
      name: "Exhibition",
      icon: Icons.slideshow,
    ),
    CategoryData(
      id: "workshop",
      image: Assets.workshopImg,
      name: "Workshop ",
      icon: Icons.work_history_outlined,
    ),
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
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
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
                            "Ismaeil Sherif",
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
                          return TabBarItemWidget(
                            categoryData: data,
                            isSelected:
                                selectedTabIndex ==
                                categoriesDataList.indexOf(data),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),

          StreamBuilder(
            stream: FirebaseFirestoreUtils.getStreamEventTasksList(
              categoryId: categoriesDataList[selectedTabIndex].id,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              List<EventData> eventDataList =
                  snapshot.data!.docs.map((element) {
                    return element.data();
                  }).toList();

              return eventDataList.isEmpty
                  ? Center(child: Text("No Data"))
                  : Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Bounceable(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              PageRouteName.eventDetails,
                              arguments: eventDataList[index],
                            );
                          },
                          child: EventCardItem(eventData: eventDataList[index]),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemCount: eventDataList.length,
                    ),
                  );
            },
          ),

          /*FutureBuilder<List<EventData>>(future: FirebaseFirestoreUtils.getEventTasksList(),
              builder: (context, snapshot) {
            if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString(),style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.black
              ),),);
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }

            List<EventData> eventDataList = snapshot.data ?? [];

           return Expanded(
             child: ListView.separated(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemBuilder: (context,index){
                   return EventCardItem(
                     eventData: eventDataList[index],
                   );
                 },
                 separatorBuilder: (context,index) {
                   return SizedBox(height: 10);
                 },
                 itemCount: eventDataList.length),
           );
              }),*/
        ],
      ),
    );
  }
}
