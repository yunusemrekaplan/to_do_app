import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/color.dart';
import '../../utils/constants/padding.dart';
import '../../utils/constants/text_style.dart';
import 'filter_controller.dart';
import 'package:todo_app/models/tag_model.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});
  final _filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterController>(
      init: _filterController,
      initState: (state) {
        _filterController.init();
      },
      builder: (controller) => Padding(
        padding: PaddingConstant.all16,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size(double.infinity, 96),
              child: _buildAppBar(controller),
            ),
            body: getBody,
          ),
        ),
      ),
    );
  }

  Widget get getBody => Obx(
        () => _filterController.isLoading
            ? const CircularProgressIndicator()
            : _buildBody(_filterController),
      );

  Widget _buildAppBar(FilterController controller) {
    return Container(
      color: ColorConstant.onPrimary,
      child: Padding(
        padding: PaddingConstant.all16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter',
                  style: TextStyleConstant.titleLargeBold,
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                    controller.clear();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(thickness: 1, color: ColorConstant.secondaryColor),
          ],
        ),
      ),
    );
  }

  Container _buildBody(FilterController controller) {
    return Container(
      color: ColorConstant.onPrimary,
      child: Padding(
        padding: PaddingConstant.all16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Tag',
              style: TextStyleConstant.bodyMediumBold,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField(
              hint: const Text('Select Tag'),
              items: controller.tags
                  .map((tag) => DropdownMenuItem(
                        value: tag,
                        child: Text(tag.name),
                      ))
                  .toList(),
              onChanged: controller.onChangedTag,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: controller.tagSelectorHeight,
              child: SingleChildScrollView(
                controller: controller.tagScrollController,
                child: Column(
                  children: [
                    Wrap(
                      children: controller.selectedTags.obs
                          .map(
                            (tag) => _buildChosenItem(tag, controller),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Priority',
              style: TextStyleConstant.bodyMediumBold,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField(
              hint: const Text('Select Priority'),
              items: const [
                DropdownMenuItem(value: 'Low', child: Text('Low')),
                DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                DropdownMenuItem(value: 'High', child: Text('High')),
              ],
              onChanged: (value) {},
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildChosenItem(TagModel tag, FilterController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        child: Container(
          padding: PaddingConstant.all8,
          decoration: BoxDecoration(
            color: Colors.cyan[900]!.withOpacity(0.4),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: Colors.cyan[900]!,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Padding(
                padding: PaddingConstant.all4,
                child: Text(
                  tag.name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyleConstant.bodySmallBold,
                ),
              ),
              InkWell(
                child: Icon(
                  Icons.close,
                  color: Colors.cyan[900]!,
                  size: 18,
                ),
                onTap: () => controller.removeSelectedTag(tag),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
