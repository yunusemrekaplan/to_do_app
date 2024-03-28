import '../models/tag_model.dart';
import '../models/user_model.dart';
import 'firestore_service.dart';

class TagService {
  static final TagService _tagService = TagService._internal();

  factory TagService() => _tagService;

  TagService._internal();

  final _firestoreService = FirestoreService();

  final _collectionPath = 'users/${UserModel.currentUser!.userUid}/tags';

  Future<bool> addTag(TagModel tag) async {
    bool isAdded = false;
    TagModel newTag = tag;

    final docRef = await _firestoreService.createDocument(
      path: _collectionPath,
    );
    if (docRef != null) {
      newTag.setUid = docRef.id;
      await _firestoreService.addDocument(
        collection: _collectionPath,
        uid: newTag.uid!,
        data: newTag.toJson(),
      );
      isAdded = true;
    }

    return isAdded;
  }

  Future<List<TagModel>> getTags() async {
    List<TagModel> tags = [];

    final data = await _firestoreService.getAll(
      collection: _collectionPath,
    );
    if (data != null) {
      tags = data.map((e) => TagModel.fromJson(e)).toList();
    }

    return tags;
  }
}
