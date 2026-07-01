import 'package:dio/dio.dart';
import 'package:edusync_app/feature/students/chat_bot/repository/chat_bot_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/model/user_model.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../materials/model/student_material_model.dart';
import '../../materials/model/student_subject_model.dart';
import '../../materials/repository/student_material_repository.dart';
import '../../materials/repository/student_subject_repository.dart';
import '../../semester/model/system_setting_model.dart';
import '../../semester/repository/system_setting_repository.dart';
import '../model/chat_message_model.dart';
import '../model/chat_request_model.dart';

class StudentChatBotViewModel extends ChangeNotifier {
  final StudentSubjectRepository _subjectRepository;
  final SystemSettingRepository _systemSettingRepository;
  final StudentMaterialRepository _materialRepository;
  final ChatBotRepository _chatBotRepository;
  StudentChatBotViewModel(
    this._subjectRepository,
    this._systemSettingRepository,
    this._materialRepository,
    this._chatBotRepository,
  );
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  UserModel? _user;

  SystemSettingModel? _systemSetting;

  List<StudentMaterialModel> _materials = [];
  List<StudentMaterialModel> get materials => _materials;

  List<StudentSubjectModel> _subjects = [];
  List<StudentSubjectModel> get subjects => _subjects;

  StudentSubjectModel? _selectedSubject;
  StudentSubjectModel? get selectedSubject => _selectedSubject;

  final List<StudentMaterialModel> _selectedMaterials = [];
  List<StudentMaterialModel> get selectedMaterials => _selectedMaterials;

  final List<ChatMessageModel> _messages = [];
  List<ChatMessageModel> get messages => _messages;

  bool _isTyping = false;
  bool get isTyping => _isTyping;

  Future<void> _loadUser() async {
    _user = await LocalStorageService.getUser();
    if (_user == null) {
      throw Exception("User not found");
    }
    if (_messages.isEmpty) {
      _messages.add(
        ChatMessageModel(
          message:
              "👋 Hi ${_user!.fullName}! Select your course materials and ask me anything about them.",
          isUser: false,
        ),
      );
    }

    notifyListeners();
  }

  Future<void> _loadSubjects() async {
    _systemSetting = await _systemSettingRepository.getSystemSetting();
    _subjects = await _subjectRepository.getSubjects(
      departmentId: _user!.departmentId!,
      semesterId: _systemSetting!.currentSemester.id,
      yearId: _user!.yearId!,
    );
  }

  Future<void> selectSubject(StudentSubjectModel subject) async {
    _selectedSubject = subject;
    notifyListeners();
    _materials = await _materialRepository.getSubjectMaterials(subject.id);
    notifyListeners();
  }

  void toggleMaterial(StudentMaterialModel material) {
    if (_selectedMaterials.any((e) => e.id == material.id)) {
      _selectedMaterials.removeWhere((e) => e.id == material.id);
    } else {
      _selectedMaterials.add(material);
    }
    notifyListeners();
  }

  bool isMaterialSelected(StudentMaterialModel material) {
    return _selectedMaterials.any((e) => e.id == material.id);
  }

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _loadUser();
      await _loadSubjects();
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  String? validateBeforeSend(String message) {
    if (_selectedSubject == null) {
      return "Please select a subject.";
    }
    if (_selectedMaterials.isEmpty) {
      return "Please select at least one material.";
    }
    if (message.trim().isEmpty) {
      return "Please enter your question.";
    }
    return null;
  }

  void addUserMessage(String text) {
    _messages.add(ChatMessageModel(message: text, isUser: true));
    notifyListeners();
  }

  void addBotMessage(String text) {
    _messages.add(ChatMessageModel(message: text, isUser: false));
    notifyListeners();
  }

  Future<bool> sendMessage(String text) async {
    try {
      final message = text.trim();
      final validation = validateBeforeSend(message);
      if (validation != null) {
        throw Exception(validation);
      }
      addUserMessage(message);
      _isTyping = true;
      notifyListeners();
      final request = ChatRequestModel(
        materialIds: _selectedMaterials.map((e) => e.id).toList(),
        question: message,
      );

      debugPrint("REQUEST => ${request.toJson()}");
      final response = await _chatBotRepository.ask(
        ChatRequestModel(
          materialIds: _selectedMaterials.map((e) => e.id).toList(),
          question: message,
        ),
      );
      _isTyping = false;
      addBotMessage(response.data);
      notifyListeners();
    } on DioException catch (e) {
      _isTyping = false;
      notifyListeners();
      if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception(
          "The AI is taking longer than expected. Please try again.",
        );
      }
      throw Exception(e.response?.data['message'] ?? "Something went wrong.");
    } catch (e, s) {
      debugPrint("ERROR => $e");
      debugPrint("$s");
      rethrow;
    } finally {
      _isTyping = false;
      notifyListeners();
    }
    return true;
  }
}
