import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/priority.dart';
import '../models/tag_model.dart';
import '../models/task_model.dart';
import '../utils/constants/color.dart';
import '../utils/constants/padding.dart';
import '../utils/constants/text_style.dart';
import '../utils/route_names.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<TaskModel> tasks = [
    TaskModel(
      title: 'Task 1',
      description: 'Description 1',
      createdDate: DateTime.now(),
      date: DateTime.tryParse('2023-11-16')!,
      tags: [
        TagModel(name: 'tag1111'),
        TagModel(name: 'tag2'),
        TagModel(name: 'tag3'),
        TagModel(name: 'tag4'),
        TagModel(name: 'tag5'),
        TagModel(name: 'tag6'),
      ],
      priority: Priority.high,
    ),
    TaskModel(
      title: 'Task 2',
      description: 'Description 2',
      createdDate: DateTime.now(),
      date: DateTime.now(),
      tags: [TagModel(name: 'tag1'), TagModel(name: 'tag2')],
      priority: Priority.high,
    ),
    TaskModel(
      title: 'Task 3',
      description: 'Description 3',
      createdDate: DateTime.now(),
      date: DateTime.now(),
      tags: [TagModel(name: 'tag1'), TagModel(name: 'tag2')],
      priority: Priority.high,
    ),
    TaskModel(
      title: 'Task 4',
      description: 'Description 4',
      createdDate: DateTime.now(),
      date: DateTime.now(),
      tags: [TagModel(name: 'tag1'), TagModel(name: 'tag2')],
      priority: Priority.high,
    ),
    TaskModel(
      title: 'Task 5',
      description: 'Description 5',
      createdDate: DateTime.now(),
      date: DateTime.now(),
      tags: [TagModel(name: 'tag1'), TagModel(name: 'tag2')],
      priority: Priority.high,
    ),
    TaskModel(
      title: 'Task 6',
      description: 'Description 6',
      createdDate: DateTime.now(),
      date: DateTime.now(),
      tags: [TagModel(name: 'tag1'), TagModel(name: 'tag2')],
      priority: Priority.high,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Task Manager'),
      centerTitle: true,
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed(RouteName.addTask.name);
      },
      backgroundColor: ColorConstants.onPrimary,
      foregroundColor: ColorConstants.secondaryColor,
      shape: const CircleBorder(),
      child: const Icon(Icons.add, size: 30),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: ColorConstants.secondaryColor,
            size: 30,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: ColorConstants.secondaryColor,
            size: 30,
          ),
          label: 'Profile',
        ),
      ],
    );
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
      padding: PaddingConstants.all16,
      child: SingleChildScrollView(
        child: SizedBox(
          height: calculateAvailableScreenHeight,
          child: TasksListView(
            tasks: tasks,
          ),
        ),
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

class TasksListView extends StatelessWidget {
  TasksListView({super.key, required this.tasks});

  late List<TaskModel> tasks;

  void initialize() {
    tasks.sort((a, b) {
      if (a.date == null || b.date == null) {
        return 0;
      } else {
        return a.date!.compareTo(b.date!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initialize();

    return tasks.isEmpty
        ? const Text('No tasks')
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tasks'),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  //padding: PaddingConstants.vertical16,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorConstants.secondaryColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: PaddingConstants.all16,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == tasks.length - 1) {
                          return TaskItem(task: tasks[index]);
                        } else {
                          return Padding(
                            padding: PaddingConstants.bottom16,
                            child: TaskItem(task: tasks[index]),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: kBottomNavigationBarHeight + 16),
            ],
          );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    task.date != null
                        ? Text(
                            '${task.date!.month < 10 ? '0${task.date!.month}' : task.date!.month.toString()}/${task.date!.day < 10 ? '0${task.date!.day}' : task.date!.day.toString()}/${task.date!.year}',
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
                      children: task.tags!
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
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  tag.name,
                                  style: TextStyleConstants.bodySmall.copyWith(
                                    color: ColorConstants.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'High',
                  style: TextStyleConstants.bodySmallBold,
                ),
                const SizedBox(width: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
/*

GestureDetector(
                            onTap: () {
                              log('Tag1 tapped');
                            },
                            child: const Text(
                              '#tag1',
                              style: TextStyleConstants.bodySmall,
                            ),
                          )*/