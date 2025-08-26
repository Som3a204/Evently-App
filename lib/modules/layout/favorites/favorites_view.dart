import 'package:evently_app/core/utils/firebase_firestore_utils.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/models/event_data.dart';
import 'package:evently_app/modules/event_creation/event_creation_view.dart';
import 'package:evently_app/modules/layout/home/widgets/event_card_item.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/color_pallette.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
   return Column(
     children: [
       CustomTextFormField(
         hintText: "search for event",
         prefixIcon: Icon(Icons.search, color: ColorPallette.primaryColor,),
       ),
       Padding(
         padding: const EdgeInsets.all(16.0),
         child: StreamBuilder(
           stream: FirebaseFirestoreUtils.getStreamFavoriteEventTasksList(),
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

             return eventDataList.isEmpty ?
             Center(child: Text("No Data"),): Expanded(
               child: ListView.separated(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemBuilder: (context, index) {
                   return EventCardItem(eventData: eventDataList[index]);
                 },
                 separatorBuilder: (context, index) {
                   return SizedBox(height: 10);
                 },
                 itemCount: eventDataList.length,
               ),
             );
           },
         ),
       ),
     ],
   );
  }
}
