import 'package:edusync_app/feature/students/chat_bot/model/chat_request_model.dart';

import 'package:edusync_app/feature/students/chat_bot/model/chat_response_model.dart';

import '../data/remote/chat_bot_remote_data_source.dart';
import 'chat_bot_repository.dart';

class ChatBotRepositoryImpl implements ChatBotRepository {
  final ChatBotRemoteDataSource _remoteDataSource;
  ChatBotRepositoryImpl(this._remoteDataSource);
  @override
  Future<ChatResponseModel> ask(ChatRequestModel request) {
    return _remoteDataSource.askAi(request);
  }
}