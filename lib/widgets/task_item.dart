import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/priority.dart';

import '../models/task_model.dart';
import '../utils/constants/color.dart';
import '../utils/constants/padding.dart';
import '../utils/constants/text_style.dart';
import '../utils/route_names.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.detailTask.name, arguments: task);
      },
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: ColorConstants.onPrimary,
          border: Border.all(
            color: ColorConstants.secondaryColor.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: PaddingConstants.all8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        task.title,
                        style: TextStyleConstants.bodyLargeBold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      task.dueDate != null
                          ? Text(
                              '${DateFormat.d().format(task.dueDate!)} ${DateFormat.MMM().format(task.dueDate!)}, ${DateFormat.jm().format(task.dueDate!)}',
                              style: TextStyleConstants.bodySmall,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                          children: task.tags != null
                              ? task.tags!
                                  .map(
                                    (tag) => InkWell(
                                      onTap: () {
                                        log('${tag.name} tapped');
                                      },
                                      child: Container(
                                        height: 32,
                                        margin: PaddingConstants.right8,
                                        padding: PaddingConstants.all4,
                                        decoration: BoxDecoration(
                                          color: ColorConstants.secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          tag.name,
                                          style: TextStyleConstants.bodySmall
                                              .copyWith(
                                            color: ColorConstants.onPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()
                              : const []),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    task.priority.value,
                    style: TextStyleConstants.bodySmallBold,
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
