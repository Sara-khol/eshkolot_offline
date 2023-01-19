import 'package:eshkolot_offline/models/subject.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:isar/isar.dart';

part 'cc.g.dart';

@JsonSerializable()
class Course {
  Id id = Isar.autoIncrement;
  late String title;

  // @Backlink(to: "course")
  List<Subject> subjects;


  // /// A necessary factory constructor for creating a new User instance
  // /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  // /// The constructor is named after the source class, in this case, User.
  // factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  //
  // /// `toJson` is the convention for a class to declare support for serialization
  // /// to JSON. The implementation simply calls the private, generated
  // /// helper method `_$UserToJson`.
  // Map<String, dynamic> toJson() => _$CourseToJson(this);
  //
  // Course(this.id, this.title, this.subjects);
}