import 'package:edusync_app/core/network/dio_client.dart';
import 'package:edusync_app/feature/admin/chat_bot/data/remote/ai_remote_data_source.dart';
import 'package:edusync_app/feature/admin/chat_bot/model/generate_ai_request_model.dart';
import 'package:edusync_app/feature/admin/materials/model/materials_admin_model.dart';

import '../../../../../core/constants/api_constants.dart';

class AiRemoteDataSourceImpl implements AiRemoteDataSource {
  @override
  Future<dynamic> generate(GenerateAiRequestModel model) async {
    final response = await DioClient.dio.put(
      APIConstants.generateAi,
      data: model.toJson(),
    );
    return response.data;
  }
  @override
  Future<List<MaterialsAdminModel>> getSubjectMaterials(
      int subjectId,
      ) async {
    final response = await DioClient.dio.get(
      APIConstants.subjects,
      queryParameters: {
        'subjectId': subjectId,
      },
    );
    return (response.data['data'] as List)
        .map((e) => MaterialsAdminModel.fromJson(e))
        .toList();
  }
}
