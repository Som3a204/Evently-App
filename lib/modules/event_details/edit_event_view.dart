import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/constants/assets.dart';
import 'package:evently_app/core/routes/page_route_name.dart';
import 'package:evently_app/core/services/snackbar_service.dart';
import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:evently_app/core/utils/firebase_firestore_utils.dart';
import 'package:evently_app/core/widgets/custom_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/models/event_data.dart';
import 'package:evently_app/modules/event_creation/widgets/create_event_tab_bar_item_widget.dart';
import 'package:evently_app/modules/layout/layout_view.dart';
import 'package:evently_app/modules/manager/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/category_data.dart';

class EditEventView extends StatefulWidget {
   EditEventView({super.key,required this.eventData});
  EventData eventData;
  @override
  State<EditEventView> createState() => _EditEventViewState();
}


class _EditEventViewState extends State<EditEventView> {

  int selectedTabIndex = 0;
  DateTime? selectedDate;
  late AppProvider appProvider;

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
  late TextEditingController titleController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    appProvider = Provider.of<AppProvider>(context, listen: false);
    titleController.text = widget.eventData.eventTitle;
    descriptionController.text = widget.eventData.eventDescription;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    String formattedDate = DateFormat.yMMMd().format(widget.eventData.selectedDate);
    return Scaffold(
      appBar: AppBar(title: Text("Edit Event")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomButtonWidget(
            onTap: () {
              if(appProvider.eventLocation == null){
                return SnackBarService.showErrorMessage("Please select event Location");
              }
              if (formKey.currentState!.validate()) {
                if (selectedDate != null) {
                  var eventData = EventData(
                    eventId: widget.eventData.eventId,
                      eventTitle: titleController.text,
                      eventDescription: descriptionController.text,
                      eventCategoryImg: categoriesDataList[selectedTabIndex].image,
                      eventCategoryId: categoriesDataList[selectedTabIndex].id,
                      selectedDate: selectedDate ?? widget.eventData.selectedDate,
                      lat: appProvider.eventLocation?.latitude ?? widget.eventData.lat,
                      long: appProvider.eventLocation?.longitude ?? widget.eventData.long
                  );
                  EasyLoading.show();

                  FirebaseFirestoreUtils.updateEventTask(eventData: eventData);
                  SnackBarService.showSuccessMessage("Event Updated Successfully");
                  Navigator.pop(context);
                  Navigator.pop(context);
                  EasyLoading.dismiss();
                }
              }
            },
            child: Text("Edit Event", style: theme.textTheme.titleSmall),
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
                  hintText: widget.eventData.eventTitle,
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
                  hintText: widget.eventData.eventDescription,
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
                            ?  formattedDate
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
                Text(
                  "Location",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Consumer<AppProvider>(
                  builder: (context,provider,child) => CustomButtonWidget(
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(PageRouteName.pickEventLocation);
                    },
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
                          Text( appProvider.eventLocation== null ?
                          "Location: \n${widget.eventData.lat}, \n${widget.eventData.long}" : "Location : \n${appProvider.eventLocation!.latitude.toString()}, \n${appProvider.eventLocation!.longitude.toString()}",
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
