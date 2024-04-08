import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/tag_model.dart';

class FilterController extends GetxController {
  //final _isInit = true.obs;
  final _isLoading = false.obs;

  final _tagSelectorHeight = 0.0.obs;
  final _prioritySelectorHeight = 0.0.obs;

  final _tags = <TagModel>[
    TagModel(name: 'Tag1'),
    TagModel(name: 'Tag2'),
    TagModel(name: 'Tag3'),
  ].obs;
  final _selectedTags = <TagModel>[].obs;

  final _tagScrollController = ScrollController();

  //bool get isInit => _isInit.value;
  bool get isLoading => _isLoading.value;
  double get tagSelectorHeight => _tagSelectorHeight.value;
  double get prioritySelectorHeight => _prioritySelectorHeight.value;
  List<TagModel> get tags => _tags;
  List<TagModel> get selectedTags => _selectedTags;
  ScrollController get tagScrollController => _tagScrollController;

  //set setIsInit(bool value) => _isInit.value = value;
  set setIsLoading(bool value) => _isLoading.value = value;
  set setTagSelectorHeight(double value) => _tagSelectorHeight.value = value;
  set setPrioritySelectorHeight(double value) =>
      _prioritySelectorHeight.value = value;
  set setTags(List<TagModel> tags) => _tags.value = tags;
  set setSelectedTags(List<TagModel> tags) => _selectedTags.value = tags;

  void init() async {
    setIsLoading = true;

    //TODO

    setIsLoading = false;
  }

  void onChangedTag(TagModel? tag) async {
    if (!selectedTags.contains(tag)) {
      selectedTags.add(tag!);
    }

    if (tagSelectorHeight == 0) {
      setTagSelectorHeight = 65;
    } else {
      if (tagSelectorHeight != 130 && selectedTags.length > 4) {
        setTagSelectorHeight = 130;
        log(tagSelectorHeight.toString());
      }
    }
    animateScrollToBottomAfterDelay();
  }

  void removeSelectedTag(TagModel tag) {
    selectedTags.remove(tag);
    if (tagSelectorHeight == 130 && selectedTags.length <= 4) {
      setTagSelectorHeight = 65;
    } else if (tagSelectorHeight == 65 && selectedTags.isEmpty) {
      setTagSelectorHeight = 0;
    }
  }

  Future<void> animateScrollToBottomAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 500)).then((value) {
      _tagScrollController
          .jumpTo(_tagScrollController.position.maxScrollExtent);
    });
  }

  void clear() {
    setIsLoading = false;
    setTagSelectorHeight = 0.0;
    setPrioritySelectorHeight = 0.0;
    setSelectedTags = <TagModel>[];
  }
}
