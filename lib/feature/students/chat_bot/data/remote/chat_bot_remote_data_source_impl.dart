import 'package:dio/dio.dart';
import 'package:edusync_app/core/constants/api_constants.dart';
import 'package:edusync_app/core/network/dio_client.dart';
import 'package:edusync_app/feature/students/chat_bot/model/chat_request_model.dart';

import 'package:edusync_app/feature/students/chat_bot/model/chat_response_model.dart';
import 'package:flutter/cupertino.dart';

import 'chat_bot_remote_data_source.dart';

class ChatBotRemoteDataSourceImpl implements ChatBotRemoteDataSource {
  @override
  Future<ChatResponseModel> askAi(ChatRequestModel request) async {
    final response = await DioClient.dio.post(
      APIConstants.askAi,
      data: request.toJson(),
      options: Options(
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
    return ChatResponseModel.fromJson(response.data);
  }
}
