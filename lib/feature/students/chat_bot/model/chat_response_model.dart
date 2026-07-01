class ChatResponseModel {
  final bool success;
  final int statusCode;
  final String message;
  final String data;

  const ChatResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatResponseModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      data: json["data"] ?? "",
    );
  }
}
