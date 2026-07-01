import 'package:edusync_app/feature/students/dashboard/data/remote/student_instructor_subject_remote_data_source.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/network/dio_client.dart';
import '../../model/student_instructor_subject_model.dart';

class StudentInstructorSubjectRemoteDataSourceImpl
    implements StudentInstructorSubjectRemoteDataSource {

  @override
  Future<StudentInstructorSubjectModel> getInstructorBySubject(
      int subjectId) async {
    final response = await DioClient.dio.get(
      '${APIConstants.instructorBySubject}/$subjectId',
    );
    return StudentInstructorSubjectModel.fromJson(
      response.data['data'][0],
    );
  }
}