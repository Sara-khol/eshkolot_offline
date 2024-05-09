import 'package:eshkolot_offline/models/course.dart';
import 'package:isar/isar.dart';

part 'learn_path.g.dart';

@Collection()
class LearnPath
{
 late Id id;

  // @Index(unique: true,replace: true)
  // late int serverId;

  late String title;
  late String color;
  late String? iconPath;
  bool isOpen=false;
  @Name('courses')
 List<int> coursesIds=[];
  // List<int> coursesId=[];
  final coursesPath = IsarLinks<Course>();


 factory LearnPath.fromJson(Map<String, dynamic> parsedJson,int pathId) {
  return LearnPath(
   title: parsedJson['title'],
   iconPath: parsedJson['iconPath'] !=null?parsedJson['iconPath'] as String:null,
   color: (parsedJson['color'] as String).startsWith('#')?
   (parsedJson['color'] as String).replaceFirst('#', '0xff'):parsedJson['color'],
   coursesIds: parsedJson['courses'].cast<int>() ,
   id: pathId ,
  );
 }

 LearnPath({
  this.title='',
  this.iconPath='',
  this.color='',
  this.coursesIds=const [],
  this.id=0
 });

}