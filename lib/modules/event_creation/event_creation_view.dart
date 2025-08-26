import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/constants/assets.dart';
import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:evently_app/core/utils/firebase_firestore_utils.dart';
import 'package:evently_app/core/widgets/custom_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/models/event_data.dart';
import 'package:evently_app/modules/event_creation/widgets/create_event_tab_bar_item_widget.dart';
import 'package:evently_app/modules/layout/layout_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../models/category_data.dart';

class EventCreationView extends StatefulWidget {
  const EventCreationView({super.key});

  @override
  State<EventCreationView> createState() => _EventCreationViewState();
}

int selectedTabIndex = 0;
DateTime? selectedDate;

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
final TextEditingController titleController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();

class _EventCreationViewState extends State<EventCreationView> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Create Event")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomButtonWidget(
            onTap: () {
              if (formKey.currentState!.validate()) {
                if(selectedDate != null){
                     var eventData = EventData(
                  eventTitle: titleController.text,
                  eventDescription: descriptionController.text,
                  eventCategoryImg: categoriesDataList[selectedIndex].image,
                  eventCategoryId: categoriesDataList[selectedIndex].id,
                  selectedDate: selectedDate!);
                     EasyLoading.show();

                     FirebaseFirestoreUtils.createNewEventTask(eventData).then((bool value){
                 Future.delayed(Duration(seconds: 4), (){
                              EasyLoading.dismiss();
                              if(value){
                              Navigator.pop(context);
                              SnackBarService.showSuccessMessage("Event has been created successfully");
                              }
                              else{
                              SnackBarService.showErrorMessage("Something went wrong");
                              }
                              }
                             );
                       });
                          }
                           }
                            },
            child: Text("Add Event", style: theme.textTheme.titleSmall),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    categoriesDataList[selectedTabIndex].image,
                    height: 200,
                    fit: BoxFit.cover,
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
                          return CreateEventTabBarItemWidget(
                            categoryData: data,
                            isSelected:
                                selectedTabIndex ==
                                categoriesDataList.indexOf(data),
                          );
                        }).toList(),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Title",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: ColorPallette.generalTextColor,
                  ),
                ),
                SizedBox(height: 5),
                CustomTextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Title is required";
                    }
                    return null;
                  },
                  controller: titleController,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ImageIcon(AssetImage(Assets.noteIcn)),
                  ),
                  hintText: "Event Title",
                ),
                SizedBox(height: 15),
                Text(
                  "Description",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: ColorPallette.generalTextColor,
                  ),
                ),
                SizedBox(height: 5),
                CustomTextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Description is required";
                    }
                    return null;
                  },
                  controller: descriptionController,
                  hintText: "Event Description",
                  maxLines: 4,
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Icon(Icons.calendar_month),
                    SizedBox(width: 15),
                    Text(
                      "Event Date",
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: ColorPallette.primaryColor,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        getCurrentDate();
                      },
                      child: Text(
                        selectedDate == null
                            ? "Choose Date"
                            : DateFormat(
                              "yyyy-MM-dd",
                            ).format(selectedDate!).toString(),
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: ColorPallette.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                CustomButtonWidget(
                  backgroundColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: ColorPallette.primaryColor,
                          ),
                          child: Icon(
                            Icons.my_location,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 25),
                        Text(
                          "Choose Event Location",
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: ColorPallette.primaryColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: ColorPallette.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getCurrentDate() {
    showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((value) {
      setState(() {
        selectedDate = value;
      });
    });
  }
}
