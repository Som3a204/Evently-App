import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeCard extends StatelessWidget {
   DateTimeCard({super.key,required this.dateTime});
  DateTime dateTime;


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    String formattedDate = DateFormat.yMMMd().format(dateTime);
    String formattedTime = DateFormat.jm().format(dateTime);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorPallette.primaryColor)
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorPallette.primaryColor,
                borderRadius: BorderRadius.circular(16)
              ),
              child: Icon(Icons.calendar_month,color: Colors.white,),
            ),
            SizedBox(width: 8),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(formattedDate, style: theme.textTheme.titleSmall?.copyWith(
                  color: ColorPallette.primaryColor
                )),
                Text(formattedTime, style: theme.textTheme.titleSmall?.copyWith(
                  color: ColorPallette.primaryColor
                )),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
