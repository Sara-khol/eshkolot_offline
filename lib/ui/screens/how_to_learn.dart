import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eshkolot_offline/utils/my_colors.dart' as colors;


class HowToLearn extends StatefulWidget {
  const HowToLearn({super.key});

  @override
  State<HowToLearn> createState() => _HowToLearnState();
}

class _HowToLearnState extends State<HowToLearn> {
  final Map<String, String> aboutProgram = {
    'האם אני צריך להיות מחובר לאשכולות בעת הלמידה?': 'לא. לאחר שהורדת את התוכנה אין צורך להיות מחובר לאתר אשכולות.',
    'האם צריך להתקין את התוכנה על מחשב או שאפשר ללמוד דרך חיבור לדיסק און קי ?': 'אפשר גם כך וגם כך.',
    'אם אני מכבה את התוכנה, הנתונים שלמדתי נשמרים אוטמטית?': 'כן. הנתונים נשמרים עבור כל לומד.',
    'האם אפשר להתחבר עם יותר משם אחד?': 'אפשר להתחבר עם כל המשתמשים שנרשמו איתם ברכישת התוכנה באתר.',
  //  'איך אפשר להוסיף עוד קורסים ונושאים אחרי שכבר רכשתי את האונקי?': 'תשובה',
    'איך אפשר להוסיף קורסים נוספים לאחר הורדת התוכנה ?': 'דרך האתר, וכאשר יש רשת בתוכנה הקורס יתווסף בלחיצה על כפתור הסנכרון.',
    '	האם אפשר להעתיק את התוכנה לדיסק און קי אחר או למחשב נוסף?': 'אפשר להתקין את התוכנה מדיסקונקי. אחר כך לשים את הדיסקונקי על מחשב אחר ולהתקין גם משם.'
  };
  final Map<String, String> aboutLearning = {
    'איך לומדים?': 'מתחברים עם ת.ז של המשתמש המעוניין ללמוד בוחרים את הקורס הרצוי, צופים, מתרגלים ומצליחים.',
    'מתי לומדים?': 'בכל זמן ומכל התקן עליו מותקנת התוכנה.',
  };
  final Map<String, String> sync = {
    'מה זה סנכרון נתונים?': 'כאשר אנחנו מסנכרנים נתונים, זה מאפשר סנכרון נתוני הלמידה שלכם מהתוכנה לאתר וכן להפך.',
    'איך לסנכרן נתונים?': 'נתן לסנכרן נתונים אך ורק כאשר המחשב מחובר לרשת, בלחיצה על כפתור "סנכרון נתונים".',
    ' איך אדע שסנכרון הנתונים התבצע בהצלחה?': 'בסיום הסנכרון ישלח אליכם מייל אישור.',
    'למה כדאי לסנכרן נתונים?': 'משתמש שישלים קורס מלא ויסנכרן את הנתונים יקבל זיכוי מלא על התשלום ששילם בהורדת הקורס',
  };
  late List<bool> isOpen = [];
  QuestionType questionType = QuestionType.aboutProgram;
  String title = 'אודות התוכנה';
  Color color = const Color(0xFF000000);
  late ButtonStyle buttonStyle;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAFAFA),
      padding: EdgeInsets.only(top: 108.h, right: 367.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'איך לומדים כאן',
            style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 43.h),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  if (questionType != QuestionType.aboutProgram) {
                    isOpen.clear();
                    questionType = QuestionType.aboutProgram;
                    title = 'אודות התוכנה';
                    setState(() {});
                  }
                },
                style: setButtonStyle(Color(0xFF32D489)),
                child: SizedBox(
                  height: 124.h,
                  width: 296.w,
                  child: Padding(
                    padding: EdgeInsets.only(right: 19.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 16.h),
                          height: 40.h,
                          width: 40.w,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                              child: Image.asset(
                                'assets/images/save.png',
                                height: 13.h,
                              )),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Text('אודות התוכנה',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600)),
                            Text(
                              'הסבר והכוונה לשימוש\nבתוכנה.',
                              style: TextStyle(
                                fontSize: 18.sp,
                                height: 1,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 28.w),
              ElevatedButton(
                onPressed: () {
                  if (questionType != QuestionType.aboutLearning) {
                    questionType = QuestionType.aboutLearning;
                    isOpen.clear();

                    title = 'אודות הלמידה';
                    setState(() {});
                  }
                },
                style: setButtonStyle(Color(0xFFC8C9CE)),
                child: SizedBox(
                  height: 124.h,
                  width: 296.w,
                  child: Padding(
                    padding: EdgeInsets.only(right: 19.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 16.h),
                          height: 40.h,
                          width: 40.w,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                              child: Image.asset(
                                'assets/images/graduation_cap.png',
                                height: 13.h,
                              )),
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Text('אודות הלמידה',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600)),
                            Text(
                              'הסבר והכוונה איך לומדים\nבאשכולות, איך מתרגלים,\nועוד.',
                              style: TextStyle(height: 1, fontSize: 18.sp),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 28.w),
              ElevatedButton(
                onPressed: () {
                  if (questionType != QuestionType.sync) {
                    questionType = QuestionType.sync;
                    title = 'סינכרון נתונים לאתר';
                    isOpen.clear();
                    setState(() {});
                  }
                },
                style: setButtonStyle(Color(0xFFFFDA6C)),
                child: SizedBox(
                  height: 124.h,
                  width: 296.w,
                  // decoration: BoxDecoration(
                  //     color: color,
                  //     border: Border.all(color: const Color(0xFF000000)),
                  //     borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: EdgeInsets.only(right: 19.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 16.h),
                          height: 40.h,
                          width: 40.w,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                              child: Icon(
                                Icons.refresh,
                                size: 18.sp,
                              )),
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Text('סינכרון נתונים לאתר',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600)),
                            Text(
                              'איך מסנכרנים את נתוני\nהלמידה שלך באונליין\nלאופליין.',
                              style: TextStyle(fontSize: 18.sp, height: 1),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 32.h,
          ),
          Container(
            width: 944.w,
            height: 450.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Color(0xFFF4F4F3))),
            child: Padding(
              padding: EdgeInsets.only(top: 35.h, left: 50.w, right: 45.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 17.h,
                  ),
                  Expanded(
                    child: setQuestionList(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  setButtonStyle(Color color) {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      foregroundColor: colors.blackColorApp,
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: const Color(0xFF000000)),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  setQuestionList() {
    late Map<String, String> currentList;
    switch (questionType) {
      case QuestionType.aboutProgram:
        currentList = aboutProgram;
        break;
      case QuestionType.aboutLearning:
        currentList = aboutLearning;
        break;
      case QuestionType.sync:
        currentList = sync;
        break;
    }

    for (var item in currentList.keys) {
      isOpen.add(false);
    }
    return Scrollbar(
      thumbVisibility: true,
      controller: _controller,
      child: ListView.builder(
          shrinkWrap: true,
          controller: _controller,
          itemCount: currentList.length,
          itemBuilder: (context, index) {
            return questionItem(
                currentList.keys.elementAt(index),
                currentList.values.elementAt(index),
                index);
          }),
    );
  }

  questionItem(String question, String answer, int index) {
    return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 48.h,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              setState(() {
                isOpen[index] = !isOpen[index];
              });
            },
            child: Row(
              children: [
                Text(
                  question,
                  style: TextStyle(fontSize: 18.sp),
                ),
                const Spacer(),
                Icon(
                  isOpen[index] ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  size: 15.sp,
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: isOpen[index],
          child: Text(answer/*,style: TextStyle(fontSize: 18.sp)*/),

        )
      ],
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

enum QuestionType { aboutProgram, aboutLearning, sync }
