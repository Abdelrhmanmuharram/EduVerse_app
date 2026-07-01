import 'package:edusync_app/feature/students/chat_bot/model/chat_response_model.dart';
import '../../model/chat_request_model.dart';

abstract class ChatBotRemoteDataSource {
  Future<ChatResponseModel> askAi(ChatRequestModel request);
}
