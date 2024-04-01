import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/priority.dart';

import '../../models/attachment_model.dart';
import '../../utils/constants/border_radius.dart';
import '../../utils/constants/color.dart';
import '../../utils/constants/padding.dart';
import '../../utils/constants/text_style.dart';
import 'task_detail_controller.dart';

class TaskDetailScreen extends StatelessWidget {
  TaskDetailScreen({super.key});

  final _taskDetailController = Get.put(
    TaskDetailController(task: Get.arguments),
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskDetailController>(
      init: _taskDetailController,
      builder: (controller) {
        return _buildScaffold(controller);
      },
    );
  }

  Scaffold _buildScaffold(TaskDetailController controller) {
    return Scaffold(
      appBar: _buildAppBar(controller),
      body: SingleChildScrollView(
        child: SizedBox(
          child: _buildBody(controller),
        ),
      ),
    );
  }

  AppBar _buildAppBar(TaskDetailController controller) {
    return AppBar(
      title: Text(controller.task.title),
      centerTitle: true,
    );
  }

  Widget _buildBody(TaskDetailController controller) {
    return Padding(
      padding: PaddingConstants.all16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTaskDetail(controller),
          const SizedBox(height: 16),
          controller.task.description != null
              ? controller.task.description!.isNotEmpty
                  ? _buildTaskDescription(controller)
                  : const SizedBox()
              : const SizedBox(),
          const SizedBox(height: 16),
          _buildTaskNotes(controller),
          _buildTaskAttachment(controller),
          _buildTaskActions(controller),
        ],
      ),
    );
  }

  Column _buildTaskDetail(TaskDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Task Detail', style: TextStyleConstants.bodyMediumBold),
        const SizedBox(height: 16),
        Container(
          padding: PaddingConstants.all16,
          decoration: const BoxDecoration(
            borderRadius: BorderRadiusConstants.borderRadius12,
            color: ColorConstants.onPrimary,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Created At: ',
                    style: TextStyleConstants.bodySmallBold,
                  ),
                  Text(
                    DateFormat.yMMMMd().format(controller.task.createdDate),
                    style: TextStyleConstants.bodySmallBold,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              controller.task.dueDate != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Due Date: ',
                          style: TextStyleConstants.bodySmallBold,
                        ),
                        Text(
                          DateFormat.yMMMMd().format(controller.task.dueDate!),
                          style: TextStyleConstants.bodySmallBold,
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Priority Level: ',
                    style: TextStyleConstants.bodySmallBold,
                  ),
                  Text(
                    controller.task.priority.value,
                    style: TextStyleConstants.bodySmallBold,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Is Completed: ',
                    style: TextStyleConstants.bodySmallBold,
                  ),
                  Obx(
                    () => Text(
                      controller.isCompleted.value ? 'Yes' : 'No',
                      style: TextStyleConstants.bodySmallBold,
                    ),
                  ),
                  /*
                  Obx(
                    () => Switch(
                      value: controller.isCompleted.value,
                      onChanged: (_) => controller.toggleTask(),
                    ),
                  ),
                  */
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildTaskDescription(TaskDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Task Description',
          style: TextStyleConstants.bodyMediumBold,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: PaddingConstants.all16,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadiusConstants.borderRadius12,
                  color: ColorConstants.onPrimary,
                ),
                child: Text(
                  controller.task.description!,
                  style: TextStyleConstants.bodySmallBold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _buildTaskNotes(TaskDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Task Notes', style: TextStyleConstants.bodyMediumBold),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: PaddingConstants.all16,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadiusConstants.borderRadius12,
                  color: ColorConstants.onPrimary,
                ),
                child: Column(
                  children: controller.task.notes != null
                      ? (controller.task.notes!
                          .map(
                            (note) => _buildNoteItem(note),
                          )
                          .toList()
                        ..add(
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Add Note'),
                          ),
                        ))
                      : const [],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _buildTaskAttachment(TaskDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Task Attachments',
            style: TextStyleConstants.bodyMediumBold),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: PaddingConstants.all16,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadiusConstants.borderRadius12,
                  color: ColorConstants.onPrimary,
                ),
                child: Column(
                  children: controller.task.attachments
                      .map(
                        (attachment) => _buildAttachmentItem(attachment),
                      )
                      .toList()
                    ..add(
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Add Attachment'),
                      ),
                    ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _buildTaskActions(TaskDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Task Actions', style: TextStyleConstants.bodyMediumBold),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstants.secondaryColor),
                  borderRadius: BorderRadiusConstants.borderRadius12,
                ),
                child: Row(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                    const Text(
                      'Edit Task',
                      style: TextStyleConstants.bodySmallBold,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstants.secondaryColor),
                  borderRadius: BorderRadiusConstants.borderRadius12,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                    ),
                    const Text(
                      'Delete Task',
                      style: TextStyleConstants.bodySmallBold,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstants.secondaryColor),
                  borderRadius: BorderRadiusConstants.borderRadius12,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications),
                    ),
                    const Expanded(
                      child: Text(
                        'Turn Off Notifications',
                        style: TextStyleConstants.bodySmallBold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstants.secondaryColor),
                  borderRadius: BorderRadiusConstants.borderRadius12,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.check_circle_outline),
                    ),
                    const Expanded(
                      child: Text(
                        'Mark as Completed',
                        style: TextStyleConstants.bodySmallBold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNoteItem(String note) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                note,
                style: TextStyleConstants.bodySmallBold,
              ),
            ),
          ],
        ),
        const Divider(color: ColorConstants.secondaryColor, height: 32),
      ],
    );
  }

  Widget _buildAttachmentItem(AttachmentModel attachment) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                attachment.name,
                style: TextStyleConstants.bodySmallBold,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.download),
            ),
          ],
        ),
      ],
    );
  }
}
