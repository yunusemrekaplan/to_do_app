import 'storage_service.dart';

class AttachmentService {
  static final AttachmentService _instance = AttachmentService._();

  AttachmentService._();

  factory AttachmentService() => _instance;

  final _storageService = StorageService();

  Future<bool> uploadAttachment(
    String fileName,
    String filePath,
  ) async {
    return await _storageService.uploadFile('attachment', fileName, filePath);
  }
}
