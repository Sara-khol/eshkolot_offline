import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HowToLearn extends StatefulWidget {
  const HowToLearn({super.key});

  @override
  State<HowToLearn> createState() => _HowToLearnState();
}

class _HowToLearnState extends State<HowToLearn> {

  final Map<String,String> aboutProgram={
    'האם צריך להתקין את התוכנה על המחשב, או שאפשר להשתמש דרך האונקי?':'תשובה',
    'אם אני מכבה את התוכנה, הנתונים שלמדתי נשמרים אוטמטית?':'תשובה',
    'אפשר להתחבר מכמה שמות משתמשים או רק שם משתמש אחד?':'תשובה',
    'איך אפשר להוסיף עוד קורסים ונושאים אחרי שכבר רכשתי את האונקי?':'תשובה',
    'אפשר להתקין את התוכנה על המחשב? איך?':'תשובה',
    'אפשר להעתיק את התוכנה לאונקי אחר? הנתונים ישמרו לי?':'תשובה'};
  final Map<String,String> aboutLearning= {};
  final Map<String,String> sync= {};
  late List<bool> isOpen=[];

  @override
  void initState() {
    for(var item in aboutProgram.keys){
      isOpen.add(false);
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 108.h,right: 367.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('איך לומדים כאן',style: TextStyle(fontSize: 32.sp,fontWeight: FontWeight.w600),),
          SizedBox(height: 43.h),
          Row(
            children: [
              Container(
                height: 124.h,
                width: 296.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFB9FFDD),
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(5))
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h,right: 19.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                        ),
                        child: Center(child: Image.asset('assets/images/save.png',height: 13.h,)),
                      ),
                      SizedBox(width: 16.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('אודות התוכנה',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600)),
                          Expanded(
                            child:
                              Text('הסבר והכוונה לשימוש\nבתוכנה.',
                                style: TextStyle(fontSize: 18.sp),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              )
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 28.w),
              Container(
                height: 124.h,
                width: 296.w,
                decoration: BoxDecoration(
                    color: const Color(0xFFE5E4F6),
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(5))
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h,right: 19.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                        ),
                        child: Center(child: Image.asset('assets/images/graduation_cap.png',height: 13.h,)),
                      ),
                      SizedBox(width: 16.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('אודות הלמידה',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600)),
                          Expanded(
                              child:
                              Text('הסבר והכוונה איך לומדים\nבאשכולות, איך מתרגלים,\nועוד.',
                                style: TextStyle(fontSize: 18.sp),
                              )
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 28.w),
              Container(
                height: 124.h,
                width: 296.w,
                decoration: BoxDecoration(
                    color: const Color(0xFFFFF7E8),
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(5))
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h,right: 19.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                        ),
                        child: Center(child: Icon(Icons.refresh,size: 18.sp,)),
                      ),
                      SizedBox(width: 16.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('סינכרון נתונים לאתר',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600)),
                          Expanded(
                              child:
                              Text('איך מסנכרנים את נתוני\nהלמידה שלך באונליין\nלאופליין.',
                                style: TextStyle(fontSize: 18.sp),
                              )
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h,),
          Container(
            width:944.w ,
            height: 450.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 35.h,left: 50.w,right: 45.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('אודות התוכנה',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600),),
                  SizedBox(height: 17.h,),
                  const Divider(),
                  SizedBox(height: 17.h,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: aboutProgram.length,
                              itemBuilder: (context, index) {
                                return questionItem(aboutProgram.keys.elementAt(index),
                                    aboutProgram.values.elementAt(index),
                                    index);
                              }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  questionItem(String question,String answer,int index){
    return Column(
      children: [
        SizedBox(
          height: 48.h,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              setState(() {
                isOpen[index]=!isOpen[index];
              });
            },
            child: Row(
              children: [
                Text(question,style: TextStyle(fontSize: 18.sp),),
                const Spacer(),
                Icon(isOpen[index]?Icons.arrow_drop_up:Icons.arrow_drop_down,size: 15.sp,)
              ],
            ),
          ),
        ),
        Visibility(
          visible: isOpen[index],
          child: Padding(
            padding: EdgeInsets.only(right: 10.w),
              child: Text(answer),
            ),
          )
      ],
    );
  }
}
