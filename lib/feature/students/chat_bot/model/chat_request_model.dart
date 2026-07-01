class ChatRequestModel {
  final List<int> materialIds;
  final String question;

  ChatRequestModel({required this.materialIds, required this.question});
  Map<String, dynamic> toJson() {
    return {
      'materialIds': materialIds,
      'question': question,
    };
  }
}
