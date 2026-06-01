import 'package:edusync_app/feature/admin/departments/model/department_model.dart';

abstract class DepartmentRemoteDataSource {
  Future<List<DepartmentModel>> getDepartment();
  Future<void> addDepartment(DepartmentModel department);
  Future<void> deleteDepartment(int id);
  Future<void> updateDepartment(DepartmentModel department);
}
