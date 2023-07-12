import 'package:isar/isar.dart';

part 'knowledge.g.dart';

@Collection()
class Knowledge {
  // Id id = Isar.autoIncrement;
  late Id id ;
  late String title;
  late String? iconPath;
  late String color;
  @Ignore()
  late bool isOpen=false;

  // @Index(unique: true,replace: true,name:'serverId' )
  // late int serverId;


 factory Knowledge.fromJson(Map<String, dynamic> parsedJson,int knowledgeId) {
  return Knowledge(
   title: parsedJson['title'],
   iconPath:parsedJson['iconPath'] ??'',
   color:parsedJson['color']!=null? (parsedJson['color'] as String).startsWith('#')?
   (parsedJson['color'] as String).replaceFirst('#', '0xff'):parsedJson['color']:'',
   id: knowledgeId,
  );
 }

   Map<String, dynamic> toJson() {
    return {
      'title': title,
      'iconPath': iconPath,
      'color': color,
      'id': id,
    };
  }

  Knowledge({
   this.title='',
   this.iconPath='',
   this.color='',
   this.id=0
  });
}