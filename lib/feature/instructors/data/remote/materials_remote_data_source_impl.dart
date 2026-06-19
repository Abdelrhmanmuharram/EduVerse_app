import 'package:dio/dio.dart';
import 'package:edusync_app/core/constants/api_constants.dart';
import 'package:edusync_app/feature/instructors/model/materials_model.dart';

import '../../../../core/network/dio_client.dart';
import 'materials_remote_data_source.dart';

class MaterialsRemoteDataSourceImpl implements MaterialsRemoteDataSource {
  @override
  Future<void> addMaterial(MaterialsModel material) async {
   FormData formData =  FormData.fromMap({
     'File' : await MultipartFile.fromFile(material.file.path),
     'InstructorId' : material.instructorId,
     'SubjectId' : material.subjectId,
     'Title' : material.title,
     'Description' : material.description,
   });
   await DioClient.dio.post(
     APIConstants.getMaterials,
     data: formData,
   );
  }
}