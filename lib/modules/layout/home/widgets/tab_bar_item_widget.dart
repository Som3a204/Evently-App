import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:evently_app/models/category_data.dart';
import 'package:flutter/material.dart';

class TabBarItemWidget extends StatelessWidget {
  const TabBarItemWidget({super.key, required this.categoryData, required this.isSelected});
final CategoryData categoryData;
final bool isSelected;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white)
      ),
      child: 
      Row(
        spacing: 6,
        children: [
          Icon(categoryData.icon,color: isSelected ? ColorPallette.primaryColor: Colors.white,),
          Text(categoryData.name,style: theme.textTheme.titleSmall?.copyWith(
            color: isSelected? ColorPallette.primaryColor: Colors.white
          ),)
        ],
      ),
    );
  }
}
