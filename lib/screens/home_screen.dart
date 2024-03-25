import 'package:flutter/material.dart';

import '../utils/constants/color.dart';
import '../utils/constants/padding.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      onPressed: () {},
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

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: PaddingConstants.all16,
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.bottom -
              kToolbarHeight -
              kBottomNavigationBarHeight,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16),
              Expanded(child: TasksListView()),
            ],
          ),
        ),
      ),
    );
  }
}

class TasksListView extends StatelessWidget {
  const TasksListView({super.key});

  //List<String> todayTasks = tasks.where((task) => task.date == DateTime.now()).toList();

  @override
  Widget build(BuildContext context) {
    List<String> todayTasks = [
      'Task 1',
      'Task 2',
      'Task 3',
      'Task 4',
      'Task 5',
      'Task 6',
      'Task 7',
    ];
    return todayTasks.isEmpty
        ? const Text('No tasks')
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tasks'),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  padding: PaddingConstants.bottom16,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorConstants.secondaryColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: todayTasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TaskItem(task: todayTasks[index]);
                    },
                  ),
                ),
              ),
              const SizedBox(height: kBottomNavigationBarHeight + 16),
            ],
          );
  }
}

class TaskItem extends StatelessWidget {
  final String task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingConstants.topLeftRight16,
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        task,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '09:30 - 11:00',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
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
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check_box_outline_blank,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '#tag1 #tag2 #tag3',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Spacer(),
                  Text(
                    'Priority: High',
                    style: Theme.of(context).textTheme.bodySmall,
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
