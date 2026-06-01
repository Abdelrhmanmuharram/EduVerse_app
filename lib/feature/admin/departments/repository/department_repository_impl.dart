import '../data/remote/department_remote_data_source.dart';
import '../model/department_model.dart';
import 'department_repository.dart';

class DepartmentRepositoryImpl implements DepartmentRepository {
  final DepartmentRemoteDataSource _remoteDataSource;
  DepartmentRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<DepartmentModel>> getDepartments() {
    return _remoteDataSource.getDepartment();
  }
  @override
  Future<void> addDepartment(DepartmentModel department) {
    return _remoteDataSource.addDepartment(department);
  }

  @override
  Future<void> deleteDepartment(int id) {
    return _remoteDataSource.deleteDepartment(id);
  }

  @override
  Future<void> updateDepartment(DepartmentModel department) {
    return _remoteDataSource.updateDepartment(department);
  }
}
