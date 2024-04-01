import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo_app/models/tag_model.dart';

import '../../models/attachment_model.dart';
import '../../models/priority.dart';
import '../../utils/constants/border_radius.dart';
import '../../utils/constants/color.dart';
import '../../utils/constants/padding.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/route_names.dart';
import '../../utils/validator.dart';
import 'add_task_controller.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  final _addTaskController = Get.put(AddTaskController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTaskController>(
      init: _addTaskController,
      id: RouteName.addTask,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: const Text('Add Task'), centerTitle: true),
          body: FutureBuilder(
            future: controller.init(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _buildBody(controller);
              }
            },
          ),
        );
      },
    );
  }

  Padding _buildBody(AddTaskController controller) {
    return Padding(
      padding: PaddingConstants.all16,
      child: SizedBox(
        height: calculateAvailableScreenHeight,
        child: _buildForm(controller),
      ),
    );
  }

  Obx _buildForm(AddTaskController controller) {
    return Obx(
      () => Form(
        key: controller.formKey,
        autovalidateMode: controller.autovalidateMode,
        child: Column(
          children: <Widget>[
            _buildFormFields(controller),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: controller.isLoading ? null : controller.onSaveTask,
              child: controller.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildFormFields(AddTaskController controller) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.primaryColor,
          borderRadius: BorderRadiusConstants.borderRadius12,
          border: Border.all(color: ColorConstants.secondaryColor),
        ),
        padding: PaddingConstants.all16,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildTitleAndTextField(
                'Task Title',
                'Enter task title...',
                controller.taskTitleController,
                CustomValidator().validateTaskTitle,
              ),
              _buildTitleAndTextField(
                'Task Description',
                'Enter task description... (optional)',
                controller.taskDescriptionController,
                CustomValidator().validateTaskDescription,
                minLines: 3,
                maxLines: 3,
              ),
              _buildNotesField(controller),
              _buildAttechmentsField(controller),
              _buildDateField(
                'Date and Time',
                'Date and Time (optional)',
                controller,
                CustomValidator().validateDate,
              ),
              _buildPrioritySelector(controller),
              _buildTagSelector(controller),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildAttechmentsField(AddTaskController controller) {
    return Padding(
      padding: PaddingConstants.bottom24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Attachments', style: TextStyleConstants.bodyMedium),
          const SizedBox(height: 8),
          SizedBox(
            height: controller.attachments.isEmpty ? 50 : 100,
            child: SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: controller.attachments
                          .map(
                            (attachment) =>
                                _buildAttachmentChip(attachment, controller),
                          )
                          .toList()
                        ..add(
                          IconButton(
                            onPressed: () async =>
                                await controller.pickAttachment(),
                            icon: const Icon(Icons.attach_file),
                          ),
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentChip(
    AttachmentModel attachment,
    AddTaskController controller,
  ) {
    return Chip(
      label: Text(attachment.name, style: TextStyleConstants.bodySmall),
      backgroundColor: ColorConstants.secondaryColor.withOpacity(0.1),
      deleteIcon: const Icon(Icons.close),
      onDeleted: () => controller.removeAttachment(attachment),
    );
  }

  Column _buildNotesField(AddTaskController controller) {
    return Column(
      children: [
        _buildTitleAndTextField(
          'Notes',
          'Add notes... (optional)',
          controller.taskNotesController,
          CustomValidator().validateNotes,
          minLines: 1,
          maxLines: 1,
          onFieldSubmitted: (_) => controller.addNote(),
        ),
        SizedBox(
          height: controller.notes.length * 56.0 >= 130
              ? 130
              : controller.notes.length * 56.0,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.notes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: PaddingConstants.bottom8,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadiusConstants.borderRadius12,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 30,
                        child: Icon(Icons.circle, size: 8),
                      ),
                      Expanded(
                        child: Text(
                          controller.notes[index],
                          style: TextStyleConstants.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () => controller.removeNoteAt(index),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: PaddingConstants.bottom8,
          child: IconButton(
            onPressed: controller.addNote,
            icon: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Padding _buildTitleAndTextField(
    String title,
    String hintText,
    TextEditingController controller,
    String? Function(String?)? validator, {
    int maxLines = 1,
    int minLines = 1,
    void Function(String)? onFieldSubmitted,
  }) {
    return Padding(
      padding: title == 'Notes'
          ? PaddingConstants.bottom8
          : PaddingConstants.bottom24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyleConstants.bodyMedium),
          const SizedBox(height: 8),
          TextFormField(
            style: TextStyleConstants.bodySmall,
            minLines: minLines,
            maxLines: maxLines,
            controller: controller,
            validator: validator,
            onFieldSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadiusConstants.borderRadius12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildDateField(
    String label,
    String hintText,
    AddTaskController controller,
    String? Function(String?)? validator,
  ) {
    return Padding(
      padding: PaddingConstants.bottom24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyleConstants.bodyMedium),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: controller.pickDate,
                icon: const Icon(Icons.calendar_today),
              ),
              Expanded(
                child: InkWell(
                  onTap: controller.pickDate,
                  child: TextFormField(
                    style: TextStyleConstants.bodySmall,
                    controller: controller.taskDateController,
                    validator: validator,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadiusConstants.borderRadius12,
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadiusConstants.borderRadius12,
                        borderSide:
                            BorderSide(color: ColorConstants.secondaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _buildPrioritySelector(AddTaskController controller) {
    return Padding(
      padding: PaddingConstants.bottom24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Priority',
            style: TextStyleConstants.bodyMedium,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor,
              borderRadius: BorderRadiusConstants.borderRadius12,
              border: Border.all(color: ColorConstants.secondaryColor),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  _buildRadioMenuButton(Priority.low, controller),
                  const SizedBox(width: 16),
                  _buildRadioMenuButton(Priority.medium, controller),
                  const SizedBox(width: 16),
                  _buildRadioMenuButton(Priority.high, controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  RadioMenuButton<Priority> _buildRadioMenuButton(
    Priority value,
    AddTaskController controller,
  ) {
    return RadioMenuButton(
      value: value,
      groupValue: controller.selectedPriority,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        ),
      ),
      onChanged: controller.pickPriority,
      child: Text(value.value, style: TextStyleConstants.bodySmall),
    );
  }

  Widget _buildTagSelector(AddTaskController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tags', style: TextStyleConstants.bodyMedium),
        const SizedBox(height: 8),
        SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: controller.selectedTags
                          .map((tag) => _buildTagChip(tag, controller))
                          .toList()
                        ..add(
                          _buildTagSelectAndAddButton(controller),
                        ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTagChip(TagModel tag, AddTaskController controller) {
    return Chip(
      label: Text(tag.name, style: TextStyleConstants.bodySmall),
      backgroundColor: ColorConstants.secondaryColor.withOpacity(0.1),
      deleteIcon: const Icon(Icons.close),
      onDeleted: () => controller.removeTag(tag),
    );
  }

  DropdownButton<TagModel> _buildTagSelectAndAddButton(
      AddTaskController controller) {
    return DropdownButton<TagModel>(
      items: controller.tags
          .map((tag) => DropdownMenuItem<TagModel>(
                value: tag,
                child: Text(tag.name, style: TextStyleConstants.bodySmall),
              ))
          .toList()
        ..add(
          const DropdownMenuItem<TagModel>(
            value: null,
            child: Text(
              'Add Tag',
              style: TextStyleConstants.bodySmall,
            ),
          ),
        ),
      onChanged: (TagModel? value) {
        print('Selected tag: $value');
        if (value == null) {
          showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add Tag'),
                content: TextFormField(
                  controller: controller.addTagController,
                  validator: CustomValidator().validateTag,
                  decoration: const InputDecoration(
                    hintText: 'Enter tag name',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (controller.addTagController.text.isNotEmpty) {
                        controller.addTag();
                        controller.addTagController.clear();
                        Navigator.of(context).pop();
                      } else {
                        Get.snackbar(
                          'Error',
                          'Tag name cannot be empty',
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 1),
                        );
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        } else {
          controller.pickTag(value);
        }
      },
      hint: const Text(
        'Select or add tag',
        style: TextStyleConstants.bodySmall,
      ),
    );
  }

  double get calculateAvailableScreenHeight {
    return Get.height -
        Get.mediaQuery.padding.bottom -
        kToolbarHeight -
        kBottomNavigationBarHeight;
  }
}
