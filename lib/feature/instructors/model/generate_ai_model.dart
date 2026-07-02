class GenerateAIModel {
  final int format;
  final List<int> materialIds;
  final int type;
  final int difficulty;
  final int mcqCount;
  final int essayCount;

  const GenerateAIModel({
    required this.format,
    required this.materialIds,
    required this.type,
    required this.difficulty,
    required this.mcqCount,
    required this.essayCount,
  });

  Map<String, dynamic> toJson() {
    return {
      "format": format,
      "materialIds": materialIds,
      "type": type,
      "difficulty": difficulty,
      "mcqCount": mcqCount,
      "essayCount": essayCount,
    };
  }
}
