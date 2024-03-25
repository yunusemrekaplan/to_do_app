import 'package:flutter/material.dart';

import '../utils/constants/border_radius.dart';
import '../utils/constants/padding.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
      padding: PaddingConstants.all16,
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadiusConstants.borderRadius12,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                padding: PaddingConstants.all16,
                child: Column(
                  children: [
                    _buildTitleAndTextField(
                      context,
                      'Task Title',
                      'Enter task title...',
                    ),
                    _buildTitleAndTextField(
                      context,
                      'Task Description',
                      'Enter task description...',
                      minLines: 3,
                      maxLines: 3,
                    ),
                    _buildTitleAndTextField(
                      context,
                      'Notes',
                      'Add notes... (optional)',
                      minLines: 3,
                      maxLines: 3,
                    ),
                    _buildDateField(context, 'Start Date'),
                    _buildDateField(context, 'Due Date'),
                    _buildPrioritySelector(context),
                    _buildCategoryDropdown(context),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildTitleAndTextField(
    BuildContext context,
    String title,
    String hintText, {
    int maxLines = 1,
    int minLines = 1,
  }) {
    return Padding(
      padding: PaddingConstants.bottom24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          TextFormField(
            style: Theme.of(context).textTheme.bodyMedium,
            minLines: minLines,
            maxLines: maxLines,
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

  Padding _buildDateField(BuildContext context, String hintText) {
    return Padding(
      padding: PaddingConstants.bottom24,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.calendar_today),
          ),
          Expanded(
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildPrioritySelector(BuildContext context) {
    return Padding(
      padding: PaddingConstants.bottom24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Priority',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildRadioMenuButton(context, 'Low', (String? value) {}),
              const SizedBox(width: 16),
              _buildRadioMenuButton(context, 'Medium', (String? value) {}),
              const SizedBox(width: 16),
              _buildRadioMenuButton(context, 'High', (String? value) {}),
            ],
          ),
        ],
      ),
    );
  }

  RadioMenuButton<String> _buildRadioMenuButton(
    BuildContext context,
    String value,
    void Function(String?) onChanged,
  ) {
    return RadioMenuButton(
      value: value,
      groupValue: 'priority',
      onChanged: onChanged,
      child: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Column _buildCategoryDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          items: [
            _buildDropdownMenuItem('Personal'),
            _buildDropdownMenuItem('Work'),
            _buildDropdownMenuItem('Meeting'),
          ],
          onChanged: (String? value) {},
        ),
      ],
    );
  }

  DropdownMenuItem<String> _buildDropdownMenuItem(String value) {
    return DropdownMenuItem(
      value: value,
      child: Text(value),
    );
  }
}
