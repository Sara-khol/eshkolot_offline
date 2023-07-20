
import 'package:isar/isar.dart';

part 'quiz.g.dart';

@collection
class Quiz {
  late Id id;
  late List<Question> questionnaireList = [];
  bool isCompletedCurrentUser=false;


  Quiz.fromJson(List<dynamic> json, int qId) {
    id = qId;
    // questionnaireList = List<Questionnaire>.from(
    //     json['questionnaireList']?.map((q) => Questionnaire.fromJson(q)) ?? []);

    // Iterate over each questionnaire in the list
    for (var questionnaire in json) {
      Question question = Question.fromJson(questionnaire);
      // // Parse the answers for the questionnaire
      // List<dynamic> answers = questionnaire['ans'];
      //
      // // Create a list to store the Answer objects for this questionnaire
      // List<Answer> questionnaireAnswers = [];
      //
      // // Iterate over each answer in the answers list
      // for (var answer in answers) {
      //   // Create an Answer object and populate its properties
      //   Answer questionnaireAnswer = Answer();
      //   questionnaireAnswer.ans = answer['ans'];
      //   questionnaireAnswer.isCorrect = answer['isCurrect'];
      //   questionnaireAnswer.points = answer['points'];
      //
      //   // Add the answer to the questionnaireAnswers list
      //   questionnaireAnswers.add(questionnaireAnswer);
      // }
      //
      // // Create a Questionnaire object and populate its properties
      // Question questionnaireObject = Question();
      // questionnaireObject.question = questionnaire['question'];
      // questionnaireObject.ans = questionnaireAnswers;
      // questionnaireObject.type = QType.values.firstWhere(
      //         (type) => type.toString() == 'QType.${questionnaire['type']}');

      // Add the questionnaire to the questionnaireList
      questionnaireList.add(question);
    }
  }

  Quiz({
    this.id = 0,
    this.questionnaireList = const [],
  });
}

@Embedded()
class Question {
  late String question;
  late List<String>? options = [];
  late List<Answer>? ans = [];
  @Name('id_ques')
  late int idQues;
  @Name('quiz_materials')
  late String quizMaterials;
  @enumerated
  late QType type;

  @Ignore()
   bool isCorrect=false;
  @Ignore()
  bool isFilled=false;


  Question.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    options = json['options']?.cast<String>();
    ans = json['ans']!=''?List<Answer>.from(json['ans']?.map((a) => Answer.fromJson(a)) ?? []):[];
    // fillInQuestion = json['fillInQuestion'];
    idQues = json['id_ques'];
    // type = QType.values.firstWhere(
    //         (qType) => qType.toString() == json['type']);
    type = stringToStatusType(json['type']);
    quizMaterials = json['quiz_materials']??'';

  }

  Question({
    this.question = '',
    this.options = const [],
    this.ans = const [],
    // this.fillInQuestion = '',
    this.type = QType.checkbox,
    this.idQues = -1,
    this.quizMaterials=''
  });

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
    ans = json['answer']??'';
    isCorrect = json['isCurrect'] ?? false;
    points = json['points'];
    matrixMatch = json['sortString'];
  }

  Answer({
    this.ans = '',
    this.isCorrect = false,
    this.points = -1,
    this.matrixMatch=''
  });
}

enum QType { radio, checkbox, fillIn, freeChoice, openQ,sort,sortMatrix }
