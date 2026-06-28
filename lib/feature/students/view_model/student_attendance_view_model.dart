import 'package:flutter/cupertino.dart';

import '../../../core/services/local_storage_service.dart';
import '../../admin/attendance/repository/attendance_repository.dart';
import '../model/attendance_scan_request_model.dart';

class StudentAttendanceViewModel extends ChangeNotifier {
  final AttendanceRepository attendanceRepository;

  StudentAttendanceViewModel(this.attendanceRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> scanAttendance({
    required String qrData,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    try {
      final parts = qrData.split('|');

      if (parts.length != 2) {
        _errorMessage = 'Invalid QR Code';
        return false;
      }
      final sessionId = parts[0];
      final timestamp = int.tryParse(parts[1]);
      if (timestamp == null) {
        _errorMessage = 'Invalid QR Code';
        return false;
      }
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      if (now - timestamp > 10) {
        _errorMessage = 'QR Code Expired';
        return false;
      }
      final user = await LocalStorageService.getUser();
      if (user == null) {
        _errorMessage = 'User not found';
        return false;
      }
      final request = AttendanceScanRequestModel(
        attendanceTime: DateTime.now(),
        isPresent: true,
        sessionId: sessionId,
        studentId: user.id,
      );
      await attendanceRepository.addAttendance(request);
      return true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
