import 'package:edusync_app/feature/admin/chat_bot/model/generate_ai_request_model.dart';
import 'package:edusync_app/feature/admin/chat_bot/repository/ai_repository.dart';

import '../../materials/model/materials_admin_model.dart';
import '../data/remote/ai_remote_data_source.dart';

class AiRepositoryImpl implements AiRepository {
  final AiRemoteDataSource _remoteDataSource;
  AiRepositoryImpl(this._remoteDataSource);

  @override
  Future<dynamic> generate(GenerateAiRequestModel request) {
    return _remoteDataSource.generate(request);
  }

  @override
  Future<List<MaterialsAdminModel>> getSubjectMaterials(int subjectId) async {
    return _remoteDataSource.getSubjectMaterials(subjectId);
  }
}
