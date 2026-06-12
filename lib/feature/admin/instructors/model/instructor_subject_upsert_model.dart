class InstructorSubjectUpsertModel {
  final int id;
  final String instructorId;
  final int subjectId;

  InstructorSubjectUpsertModel({
    required this.id,
    required this.instructorId,
    required this.subjectId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'instructorId': instructorId,
      'subjectId': subjectId,
    };
  }
}