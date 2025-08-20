import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/assets.dart';

class EventCardItem extends StatelessWidget {
  const EventCardItem({super.key});

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
        image: DecorationImage(image: AssetImage(Assets.birthdayImg),fit: BoxFit.cover)
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
            child: Text("22 Nov",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
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
                  child: Text("Meeting for updating the development method",
                    style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        height: 1.2
                    ),
                    textAlign: TextAlign.start,),
                ),
                Icon(Icons.favorite_border, color: ColorPallette.primaryColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
