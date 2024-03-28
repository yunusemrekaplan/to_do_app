import '../models/tag_model.dart';
import '../services/tag_service.dart';

class TagRepository {
  static final TagRepository _tagRepository = TagRepository._internal();

  factory TagRepository() => _tagRepository;

  TagRepository._internal();

  final _tagService = TagService();

  List<TagModel> _tags = <TagModel>[];

  List<TagModel> get tags => _tags;

  Future<bool> addTag(TagModel tag) async {
    bool isAdded = await _tagService.addTag(tag);

    if (isAdded) {
      _tags.add(tag);
    }

    return isAdded;
  }

  Future<List<TagModel>> getTags() async {
    List<TagModel> newTags = await _tagService.getTags();
    _tags = newTags;

    return newTags;
  }
}
