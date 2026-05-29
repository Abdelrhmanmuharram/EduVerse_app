import 'package:edusync_app/feature/admin/departments/model/department_model.dart';

abstract class DepartmentRepository {
  List<DepartmentModel> getDepartments();
  void addDepartment(DepartmentModel department);
  void deleteDepartment(DepartmentModel department);
  void editDepartment(int index, DepartmentModel department);
}
