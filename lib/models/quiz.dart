import 'package:isar/isar.dart';

part 'quiz.g.dart';

@collection
class Quiz {
  late Id id;
  late String title;

  // @Name('quiz_materials')
  late String quizMaterials;

  // @Name('quiz_urls')
  late List<String> quizUrls = [];
  late String time;
  late List<Question> questionList = [];
  bool isCompletedCurrentUser = false;
  late int grade1;
  late int grade2;

  Quiz.fromJson(Map<String, dynamic> parsedJson, int qId) {
    id = qId;

    title = parsedJson['title'] ?? '';
    grade1 = parsedJson['grade1'] ?? 0;
    grade2 = parsedJson['grade2'] ?? 0;
   quizMaterials = parsedJson['quiz_materials'] ?? '';
   // quizUrls = parsedJson['quiz_urls'] ?? '';
    time = parsedJson['time'] ?? '';

    if(parsedJson['quiz_urls']!=null) {
      for (String url in parsedJson['quiz_urls']) {
        if(url.contains('wordpress-775052-2636048.cloudwaysapps.com')) {
        url=  url.replaceAll('wordpress-775052-2636048.cloudwaysapps.com', 'eshkolot.net');
        }
        quizUrls.add(url);
      }
    }


    for (var questionnaire in parsedJson['questionList']) {
      Question question = Question.fromJson(questionnaire);
      questionList.add(question);
    }
    // quizUrls=parsedJson['quiz_urls']??'';
  }

  Quiz(
      {this.id = 0,
      this.questionList = const [],
      this.title = '',
      this.quizMaterials = '',
      this.grade1 = 0,
      this.grade2 = 0,
      this.time = ''});
}

@Embedded()
class Question {
  late String question;
  late List<String>? options = [];
  late List<Answer>? ans = [];
  @Name('id_ques')
  late int idQues;
  @Name('more_data')
  late MoreData? moreData;
  @enumerated
  late QType type;
  late int points;


  @Ignore()
  bool isCorrect = false;
  @Ignore()
  bool isFilled = false;
  @Ignore()
  int quizId = 0;

  void setAllAnswersToFalse() {
    ans?.forEach((answer) {
      answer.isSelected = false;
    });
  }

  Question.fromJson(Map<String, dynamic> json) {
    question = json['question'] ?? '';
    options = json['options']?.cast<String>();
    ans = json['ans'] != ''
        ? List<Answer>.from(json['ans']?.map((a) => Answer.fromJson(a)) ?? [])
        : [];
    // fillInQuestion = json['fillInQuestion'];
    idQues = json['id_ques'];
    // type = QType.values.firstWhere(
    //         (qType) => qType.toString() == json['type']);
    type = stringToStatusType(json['type']);
    moreData = json['more_data'] is List || json['more_data'] == null
        ? null
        : MoreData.fromJson(json['more_data']);
    points = json['points'];
  }

  Question(
      {this.question = '',
      this.options = const [],
      this.ans = const [],
      this.type = QType.checkbox,
      this.idQues = -1,
      this.points=0});

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
      case 'custom_editor':
        return QType.customEditor;
      default:
        // todo change
        return QType.freeChoice;
    }
  }
}

@Embedded()
class Answer {
  // @Name('answer')
  late String ans;
  @Name('isCurrect')
  late bool isCorrect;
  late int points;
  late bool html;

  // @Name('sortString')
  late String? matrixMatch;
  @Ignore()
   bool isSelected=false;

  Answer.fromJson(Map<String, dynamic> json) {
    ans = json['answer'] ?? '';
    isCorrect = json['isCurrect'] ?? false;
    points = json['points'];
    matrixMatch = json['sortString'];
    html = json['html'];

  }

  Answer(
      {this.ans = '',
        this.html=false,
      this.isCorrect = false,
      this.points = -1,
      this.matrixMatch = ''});
}

@Embedded()
class MoreData {
  @Name('background_image_option')
  late String backgroundImageOption;
  @Name('custom_quiz_questions_height')
  late String customQuizQuestionsHeight;
  @Name('custom_quiz_questions_width')
  late String customQuizQuestionsWidth;
  @Name('custom_quiz_questions_fields')
  late List<CustomQuizQuestionsFields> quizFields;

  MoreData.fromJson(Map<String, dynamic> json) {
    backgroundImageOption = json['background_image_option'] ?? '';
    customQuizQuestionsHeight = json['custom_quiz_questions_height'];
    customQuizQuestionsWidth = json['custom_quiz_questions_width'];
    quizFields = json['custom_quiz_questions_fields'] != ''
        ? List<CustomQuizQuestionsFields>.from(
            json['custom_quiz_questions_fields']
                    ?.map((c) => CustomQuizQuestionsFields.fromJson(c)) ??
                [])
        : [];
  }

  MoreData(
      {this.backgroundImageOption = '',
      this.customQuizQuestionsHeight = '',
      this.customQuizQuestionsWidth = '',
      this.quizFields = const []});
}

@Embedded()
class CustomQuizQuestionsFields {
  late String name;
  late String type;
  late String height;
  late String width;
  @Name('max_width')
  late String maxWidth;
  @Name('x_position')
  late String xPosition;
  @Name('y_position')
  late String yPosition;
  late String editable;
  @Name('correct_answer')
  late String correctAnswer;
  @Name('default_value')
  late String defaultValue;
  @Name('font_size')
  late String fontSize;
  late String color;
  late String background;
  late String points;
  late String direction;
 late String bold;

  CustomQuizQuestionsFields.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    height = json['height'] ?? '';
    width = json['width'] ?? '';
    xPosition = json['x_position'];
    yPosition = json['y_position'];
    maxWidth = json['max_width'] ?? '';
    editable = json['editable'] ?? '';
    correctAnswer = json['correct_answer'] ?? '';
    defaultValue = json['default_value'];
    fontSize = json['font_size']??'';
    // color = json['color'] ?? '';
    color =json['color'] != null
        ? (json['color'] as String).startsWith('#')
        ? (json['color'] as String).replaceFirst('#', '0xff')
        : json['color']: '';
    // background = json['background'] ?? '';
    background =json['background'] != null
        ? (json['background'] as String).startsWith('#')
        ? (json['background'] as String).replaceFirst('#', '0xff')
        : json['background']: '';
    points = json['points'] ?? '';
    direction = json['direction'] ?? '';
   bold = json['bold'] ?? '';
  }

  CustomQuizQuestionsFields(
      {this.name = '',
      this.type = '',
      this.height = '',
      this.width = '',
      this.xPosition = '',
      this.maxWidth = '',
      this.yPosition = '',
      this.editable = '',
      this.correctAnswer = '',
      this.defaultValue = '',
      this.fontSize = '',
      this.color = '',
      this.background = '',
      this.points = '',
      this.direction = '',
      this.bold=''});
}

enum QType {
  radio,
  checkbox,
  fillIn,
  freeChoice,
  openQ,
  sort,
  sortMatrix,
  customEditor
}
