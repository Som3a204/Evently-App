import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:evently_app/core/utils/firebase_firestore_utils.dart';
import 'package:evently_app/models/event_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/assets.dart';

class EventCardItem extends StatelessWidget {
  final EventData eventData;
  const EventCardItem({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: 210,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorPallette.primaryColor),
        image: DecorationImage(image: AssetImage(eventData.eventCategoryImg),fit: BoxFit.cover)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 43,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6)
            ),
            child: Text(DateFormat("dd MMM").format(eventData.selectedDate),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorPallette.primaryColor,
                height: 1
              ),
              textAlign: TextAlign.center,),
          ),
          Container(
            width: double.infinity,
            height: 50,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6 ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6)
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(eventData.eventTitle,
                    style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        height: 1.2
                    ),
                    textAlign: TextAlign.start,),
                ),
                Bounceable(
                  onTap: () {
                    eventData.isFavorite = !eventData.isFavorite;
                    FirebaseFirestoreUtils.updateEventTask(
                        eventData: eventData);
                  },
                  child: Icon(eventData.isFavorite?
                  Icons.favorite :
                  Icons.favorite_border,
                    color: ColorPallette.primaryColor,),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
