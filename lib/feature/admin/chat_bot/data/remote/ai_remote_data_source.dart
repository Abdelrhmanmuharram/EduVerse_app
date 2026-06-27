import '../../../materials/model/materials_admin_model.dart';
import '../../model/generate_ai_request_model.dart';

abstract class AiRemoteDataSource {
  Future<List<MaterialsAdminModel>> getSubjectMaterials(int subjectId);
  Future<dynamic> generate(GenerateAiRequestModel model);
}