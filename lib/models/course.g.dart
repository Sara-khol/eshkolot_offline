// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCourseCollection on Isar {
  IsarCollection<Course> get courses => this.collection();
}

const CourseSchema = CollectionSchema(
  name: r'Course',
  id: -5832084671214696602,
  properties: {
    r'countEndQuiz': PropertySchema(
      id: 0,
      name: r'countEndQuiz',
      type: IsarType.string,
    ),
    r'countHours': PropertySchema(
      id: 1,
      name: r'countHours',
      type: IsarType.string,
    ),
    r'countLesson': PropertySchema(
      id: 2,
      name: r'countLesson',
      type: IsarType.string,
    ),
    r'countQuiz': PropertySchema(
      id: 3,
      name: r'countQuiz',
      type: IsarType.string,
    ),
    r'isSync': PropertySchema(
      id: 4,
      name: r'isSync',
      type: IsarType.bool,
    ),
    r'knowledgeId': PropertySchema(
      id: 5,
      name: r'knowledgeId',
      type: IsarType.long,
    ),
    r'knowledgeNum': PropertySchema(
      id: 6,
      name: r'knowledgeNum',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 7,
      name: r'title',
      type: IsarType.string,
    ),
    r'vimeoId': PropertySchema(
      id: 8,
      name: r'vimeoId',
      type: IsarType.string,
    )
  },
  estimateSize: _courseEstimateSize,
  serialize: _courseSerialize,
  deserialize: _courseDeserialize,
  deserializeProp: _courseDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'subjects': LinkSchema(
      id: 1200823175406644266,
      name: r'subjects',
      target: r'Subject',
      single: false,
    ),
    r'questionnaires': LinkSchema(
      id: 5166100795105764940,
      name: r'questionnaires',
      target: r'Quiz',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _courseGetId,
  getLinks: _courseGetLinks,
  attach: _courseAttach,
  version: '3.1.0+1',
);

int _courseEstimateSize(
  Course object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.countEndQuiz;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.countHours;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.countLesson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.countQuiz;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.knowledgeNum;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.vimeoId.length * 3;
  return bytesCount;
}

void _courseSerialize(
  Course object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.countEndQuiz);
  writer.writeString(offsets[1], object.countHours);
  writer.writeString(offsets[2], object.countLesson);
  writer.writeString(offsets[3], object.countQuiz);
  writer.writeBool(offsets[4], object.isSync);
  writer.writeLong(offsets[5], object.knowledgeId);
  writer.writeString(offsets[6], object.knowledgeNum);
  writer.writeString(offsets[7], object.title);
  writer.writeString(offsets[8], object.vimeoId);
}

Course _courseDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Course(
    countEndQuiz: reader.readStringOrNull(offsets[0]),
    countHours: reader.readStringOrNull(offsets[1]),
    countLesson: reader.readStringOrNull(offsets[2]),
    countQuiz: reader.readStringOrNull(offsets[3]),
    id: id,
    knowledgeId: reader.readLongOrNull(offsets[5]),
    knowledgeNum: reader.readStringOrNull(offsets[6]),
    title: reader.readStringOrNull(offsets[7]) ?? '',
    vimeoId: reader.readStringOrNull(offsets[8]) ?? '',
  );
  object.isSync = reader.readBool(offsets[4]);
  return object;
}

P _courseDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 8:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _courseGetId(Course object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _courseGetLinks(Course object) {
  return [object.subjects, object.questionnaires];
}

void _courseAttach(IsarCollection<dynamic> col, Id id, Course object) {
  object.id = id;
  object.subjects.attach(col, col.isar.collection<Subject>(), r'subjects', id);
  object.questionnaires
      .attach(col, col.isar.collection<Quiz>(), r'questionnaires', id);
}

extension CourseQueryWhereSort on QueryBuilder<Course, Course, QWhere> {
  QueryBuilder<Course, Course, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CourseQueryWhere on QueryBuilder<Course, Course, QWhereClause> {
  QueryBuilder<Course, Course, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Course, Course, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Course, Course, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Course, Course, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CourseQueryFilter on QueryBuilder<Course, Course, QFilterCondition> {
  QueryBuilder<Course, Course, QAfterFilterCondition> countEndQuizIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'countEndQuiz',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countEndQuizIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'countEndQuiz',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countEndQuizEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'countEndQuiz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countEndQuizGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'countEndQuiz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countEndQuizLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'countEndQuiz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countEndQuizBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'countEndQuiz',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countEndQuizStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'countEndQuiz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countEndQuizEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'countEndQuiz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countEndQuizContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'countEndQuiz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countEndQuizMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'countEndQuiz',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countEndQuizIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'countEndQuiz',
        value: '',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countEndQuizIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'countEndQuiz',
        value: '',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countHoursIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'countHours',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countHoursIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'countHours',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countHoursEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'countHours',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countHoursGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'countHours',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countHoursLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'countHours',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countHoursBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'countHours',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countHoursStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'countHours',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countHoursEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'countHours',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countHoursContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'countHours',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countHoursMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'countHours',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countHoursIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'countHours',
        value: '',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countHoursIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'countHours',
        value: '',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countLessonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'countLesson',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countLessonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'countLesson',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countLessonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'countLesson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countLessonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'countLesson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countLessonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'countLesson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countLessonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'countLesson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countLessonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'countLesson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countLessonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'countLesson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countLessonContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'countLesson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countLessonMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'countLesson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countLessonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'countLesson',
        value: '',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countLessonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'countLesson',
        value: '',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countQuizIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'countQuiz',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countQuizIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'countQuiz',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countQuizEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'countQuiz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countQuizGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'countQuiz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countQuizLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'countQuiz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countQuizBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'countQuiz',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countQuizStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'countQuiz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countQuizEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'countQuiz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countQuizContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'countQuiz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countQuizMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'countQuiz',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countQuizIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'countQuiz',
        value: '',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> countQuizIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'countQuiz',
        value: '',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> isSyncEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSync',
        value: value,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'knowledgeId',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'knowledgeId',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'knowledgeId',
        value: value,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'knowledgeId',
        value: value,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'knowledgeId',
        value: value,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'knowledgeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeNumIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'knowledgeNum',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeNumIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'knowledgeNum',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeNumEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'knowledgeNum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeNumGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'knowledgeNum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeNumLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'knowledgeNum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeNumBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'knowledgeNum',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeNumStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'knowledgeNum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeNumEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'knowledgeNum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeNumContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'knowledgeNum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeNumMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'knowledgeNum',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeNumIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'knowledgeNum',
        value: '',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> knowledgeNumIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'knowledgeNum',
        value: '',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> vimeoIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vimeoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> vimeoIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vimeoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> vimeoIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vimeoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> vimeoIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vimeoId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> vimeoIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vimeoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> vimeoIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vimeoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> vimeoIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vimeoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> vimeoIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vimeoId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> vimeoIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vimeoId',
        value: '',
      ));
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> vimeoIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vimeoId',
        value: '',
      ));
    });
  }
}

extension CourseQueryObject on QueryBuilder<Course, Course, QFilterCondition> {}

extension CourseQueryLinks on QueryBuilder<Course, Course, QFilterCondition> {
  QueryBuilder<Course, Course, QAfterFilterCondition> subjects(
      FilterQuery<Subject> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'subjects');
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> subjectsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subjects', length, true, length, true);
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> subjectsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subjects', 0, true, 0, true);
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> subjectsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subjects', 0, false, 999999, true);
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> subjectsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subjects', 0, true, length, include);
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> subjectsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subjects', length, include, 999999, true);
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> subjectsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'subjects', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> questionnaires(
      FilterQuery<Quiz> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'questionnaires');
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition>
      questionnairesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questionnaires', length, true, length, true);
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition> questionnairesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questionnaires', 0, true, 0, true);
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition>
      questionnairesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questionnaires', 0, false, 999999, true);
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition>
      questionnairesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questionnaires', 0, true, length, include);
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition>
      questionnairesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questionnaires', length, include, 999999, true);
    });
  }

  QueryBuilder<Course, Course, QAfterFilterCondition>
      questionnairesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'questionnaires', lower, includeLower, upper, includeUpper);
    });
  }
}

extension CourseQuerySortBy on QueryBuilder<Course, Course, QSortBy> {
  QueryBuilder<Course, Course, QAfterSortBy> sortByCountEndQuiz() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countEndQuiz', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByCountEndQuizDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countEndQuiz', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByCountHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countHours', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByCountHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countHours', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByCountLesson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countLesson', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByCountLessonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countLesson', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByCountQuiz() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countQuiz', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByCountQuizDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countQuiz', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByIsSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSync', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByIsSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSync', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByKnowledgeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'knowledgeId', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByKnowledgeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'knowledgeId', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByKnowledgeNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'knowledgeNum', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByKnowledgeNumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'knowledgeNum', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByVimeoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vimeoId', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> sortByVimeoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vimeoId', Sort.desc);
    });
  }
}

extension CourseQuerySortThenBy on QueryBuilder<Course, Course, QSortThenBy> {
  QueryBuilder<Course, Course, QAfterSortBy> thenByCountEndQuiz() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countEndQuiz', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByCountEndQuizDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countEndQuiz', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByCountHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countHours', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByCountHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countHours', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByCountLesson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countLesson', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByCountLessonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countLesson', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByCountQuiz() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countQuiz', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByCountQuizDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countQuiz', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByIsSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSync', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByIsSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSync', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByKnowledgeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'knowledgeId', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByKnowledgeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'knowledgeId', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByKnowledgeNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'knowledgeNum', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByKnowledgeNumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'knowledgeNum', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByVimeoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vimeoId', Sort.asc);
    });
  }

  QueryBuilder<Course, Course, QAfterSortBy> thenByVimeoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vimeoId', Sort.desc);
    });
  }
}

extension CourseQueryWhereDistinct on QueryBuilder<Course, Course, QDistinct> {
  QueryBuilder<Course, Course, QDistinct> distinctByCountEndQuiz(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'countEndQuiz', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Course, Course, QDistinct> distinctByCountHours(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'countHours', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Course, Course, QDistinct> distinctByCountLesson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'countLesson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Course, Course, QDistinct> distinctByCountQuiz(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'countQuiz', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Course, Course, QDistinct> distinctByIsSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSync');
    });
  }

  QueryBuilder<Course, Course, QDistinct> distinctByKnowledgeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'knowledgeId');
    });
  }

  QueryBuilder<Course, Course, QDistinct> distinctByKnowledgeNum(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'knowledgeNum', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Course, Course, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Course, Course, QDistinct> distinctByVimeoId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vimeoId', caseSensitive: caseSensitive);
    });
  }
}

extension CourseQueryProperty on QueryBuilder<Course, Course, QQueryProperty> {
  QueryBuilder<Course, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Course, String?, QQueryOperations> countEndQuizProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'countEndQuiz');
    });
  }

  QueryBuilder<Course, String?, QQueryOperations> countHoursProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'countHours');
    });
  }

  QueryBuilder<Course, String?, QQueryOperations> countLessonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'countLesson');
    });
  }

  QueryBuilder<Course, String?, QQueryOperations> countQuizProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'countQuiz');
    });
  }

  QueryBuilder<Course, bool, QQueryOperations> isSyncProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSync');
    });
  }

  QueryBuilder<Course, int?, QQueryOperations> knowledgeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'knowledgeId');
    });
  }

  QueryBuilder<Course, String?, QQueryOperations> knowledgeNumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'knowledgeNum');
    });
  }

  QueryBuilder<Course, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<Course, String, QQueryOperations> vimeoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vimeoId');
    });
  }
}
