import '../model/department_model.dart';
import 'department_repository.dart';

class DepartmentRepositoryImpl implements DepartmentRepository {
  final List<DepartmentModel> _departments = [];

  @override
  List<DepartmentModel> getDepartments() {
    return _departments;
  }
  @override
  void addDepartment(DepartmentModel department) {
    _departments.add(department);
  }
  @override
  void deleteDepartment(DepartmentModel department) {
    _departments.remove(department);
  }
  @override
  void editDepartment(int index, DepartmentModel department) {
    _departments[index] = department;
  }
}
