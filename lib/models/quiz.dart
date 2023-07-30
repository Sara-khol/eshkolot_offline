import 'package:isar/isar.dart';

part 'quiz.g.dart';

@collection
class Quiz {
  late Id id;
  late String title;
  // @Name('quiz_materials')
  late String quizMaterials;
  late String time;
  late List<Question> questionList = [];
  bool isCompletedCurrentUser = false;

   Quiz.fromJson(Map<String, dynamic> parsedJson, int qId) {
    id = qId;
    title=parsedJson['title']??'';
    quizMaterials=parsedJson['quiz_materials']??'';
    time=parsedJson['time']??'';
    for (var questionnaire in parsedJson['questionList']) {
      Question question = Question.fromJson(questionnaire);
      questionList.add(question);
    }
  }

  Quiz(
      {this.id = 0,
      this.questionList = const [],
      this.title = '',
      this.quizMaterials = '',
      this.time=''});
}

@Embedded()
class Question {
  late String question;
  late List<String>? options = [];
  late List<Answer>? ans = [];
  @Name('id_ques')
  late int idQues;
  @enumerated
  late QType type;

  @Ignore()
  bool isCorrect = false;
  @Ignore()
  bool isFilled = false;

  Question.fromJson(Map<String, dynamic> json) {
    question = json['question']??'';
    options = json['options']?.cast<String>();
    ans = json['ans'] != ''
        ? List<Answer>.from(json['ans']?.map((a) => Answer.fromJson(a)) ?? [])
        : [];
    // fillInQuestion = json['fillInQuestion'];
    idQues = json['id_ques'];
    // type = QType.values.firstWhere(
    //         (qType) => qType.toString() == json['type']);
    type = stringToStatusType(json['type']);
  }

  Question(
      {this.question = '',
      this.options = const [],
      this.ans = const [],
      this.type = QType.checkbox,
      this.idQues = -1});

  QType stringToStatusType(String value) {
    switch (value) {
      case 'cloze_answer':
        return QType.fillIn;
      case 'free_answer':
        return QType.freeChoice;
      case 'single':
        return QType.radio;
      case 'multiple':
        return QType.checkbox;
      case 'matrix_sort_answer':
        return QType.sortMatrix;
      case 'sort_answer':
        return QType.sort;
      case 'essay':
        return QType.openQ;
      default:
        // todo change
        return QType.freeChoice;
    }
  }
}

@Embedded()
class Answer {
  late String ans;
  @Name('isCurrect')
  late bool isCorrect;
  late int points;

  // @Name('sortString')
  late String? matrixMatch;

  Answer.fromJson(Map<String, dynamic> json) {
    ans = json['answer'] ?? '';
    isCorrect = json['isCurrect'] ?? false;
    points = json['points'];
    matrixMatch = json['sortString'];
  }

  Answer(
      {this.ans = '',
      this.isCorrect = false,
      this.points = -1,
      this.matrixMatch = ''});
}

enum QType { radio, checkbox, fillIn, freeChoice, openQ, sort, sortMatrix }
