import 'package:edusync_app/core/network/dio_client.dart';
import 'package:edusync_app/feature/students/subjects/data/remote/student_subject_instructor_remote_data_source.dart';
import 'package:edusync_app/feature/students/subjects/model/student_subject_instructor_model.dart';

import '../../../../../core/constants/api_constants.dart';

class StudentSubjectInstructorRemoteDataSourceImpl
    implements StudentSubjectInstructorRemoteDataSource {
  @override
  Future<List<StudentSubjectInstructorModel>> getSubjectInstructors(
    int subjectId,
  ) async {
    final response = await DioClient.dio.get(
      '${APIConstants.instructorBySubject}/$subjectId',
    );
    return (response.data['data'] as List)
        .map((e) => StudentSubjectInstructorModel.fromJson(e))
        .toList();
  }
}
