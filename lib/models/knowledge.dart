import 'package:isar/isar.dart';

part 'knowledge.g.dart';

@Collection()
class Knowledge {
  // Id id = Isar.autoIncrement;
  late Id id;

  late String title;
  late String? iconPath;
   MyIcon icon;
  @Ignore()
  late bool isOpen = false;

  // @Index(unique: true,replace: true,name:'serverId' )
  // late int serverId;

  factory Knowledge.fromJson(Map<String, dynamic> parsedJson, int knowledgeId) {
    return Knowledge(
      title: parsedJson['title'],
      iconPath: parsedJson['iconPath'] ?? '',
      id: knowledgeId,
      icon: MyIcon.fromJson(parsedJson['icon'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'iconPath': iconPath,
      'id': id,
      'icon':icon
    };
  }

  Knowledge(
      {this.title = '', this.iconPath = '', this.id = 0, required this.icon});
}

@Embedded()
class MyIcon {
  // @Name('name_icon')
  late String nameIcon;
  late String color;
  // @Name('text_color')
  late String textColor;

  MyIcon.fromJson(Map<String, dynamic> json) {
    nameIcon = json['name_icon'] ?? '';
    color =json['color'] != null
        ? (json['color'] as String).startsWith('#')
        ? (json['color'] as String).replaceFirst('#', '0xff')
        : json['color']
        : '';
    textColor = json['text_color'] != null
        ? (json['text_color'] as String).startsWith('#')
        ? (json['text_color'] as String).replaceFirst('#', '0xff')
        : json['text_color']
        : '';
  }

  MyIcon({this.nameIcon = '', this.color = '', this.textColor = ''});
}
