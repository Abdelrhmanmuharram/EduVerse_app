class GenerateAiRequestModel {
  final int format;
  final List<int> materialIds;
  final int type;
  final int difficulty;
  final int mcqCount;
  final int essayCount;

  GenerateAiRequestModel({
    required this.format,
    required this.materialIds,
    required this.type,
    required this.difficulty,
    required this.mcqCount,
    required this.essayCount,
  });

  Map<String, dynamic> toJson() {
    return {
      'format': format,
      'material_ids': materialIds,
      'type': type,
      'difficulty': difficulty,
      'mcq_count': mcqCount,
      'essay_count': essayCount,
    };
  }
}
