import 'package:flutter/material.dart';
import 'package:todo_app/screens/home/home_controller.dart';

import '../../utils/constants/border_radius.dart';
import '../../utils/constants/color.dart';
import '../../utils/constants/padding.dart';
import '../../utils/constants/text_style.dart';

class HomeWidgets {
  static Expanded buildSearchTextFormField(HomeController controller) {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: TextFormField(
          controller: controller.searchTextController,
          decoration: InputDecoration(
            hintText: 'Title',
            hintStyle: TextStyleConstant.textFieldHint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.search),
            isDense: true,
            contentPadding: PaddingConstant.vertical10,
          ),
          textAlignVertical: TextAlignVertical.center,
          style: TextStyleConstant.bodySmall,
          onFieldSubmitted: controller.searchTasks,
          enabled: !controller.isLoading,
        ),
      ),
    );
  }

  static InkWell buildFilterButton(HomeController controller) {
    return InkWell(
      onTap: () {
        controller.showFilterScreen();
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: controller.filterButtonBoxColor,
          borderRadius: BorderRadiusConstant.borderRadius8,
        ),
        child: const Icon(
          Icons.filter_list_outlined,
          color: ColorConstant.primaryColor,
        ),
      ),
    );
  }

  static Padding buildTabBar(HomeController controller) {
    return Padding(
      padding: PaddingConstant.vertical24,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorConstant.onPrimary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton(
                onPressed: controller.onTapIncompleteTab,
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.incompleteTabColor,
                ),
                child: Text(
                  "Incomplete",
                  style: TextStyle(
                    color: controller.incompleteTabTextColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: controller.onTapCompletedTab,
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.completedTabColor,
                ),
                child: Text(
                  "Completed",
                  style: TextStyle(
                    color: controller.completedTabTextColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
