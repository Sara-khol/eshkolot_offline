// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserCollection on Isar {
  IsarCollection<User> get users => this.collection();
}

const UserSchema = CollectionSchema(
  name: r'User',
  id: -7838171048429979076,
  properties: {
    r'UserCourse': PropertySchema(
      id: 0,
      name: r'UserCourse',
      type: IsarType.objectList,
      target: r'UserCourse',
    ),
    r'knowledgeIds': PropertySchema(
      id: 1,
      name: r'knowledgeIds',
      type: IsarType.longList,
    ),
    r'lessonCompleted': PropertySchema(
      id: 2,
      name: r'lessonCompleted',
      type: IsarType.longList,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'pathIds': PropertySchema(
      id: 4,
      name: r'pathIds',
      type: IsarType.longList,
    ),
    r'percentages': PropertySchema(
      id: 5,
      name: r'percentages',
      type: IsarType.objectList,
      target: r'UserGrade',
    ),
    r'questionCompleted': PropertySchema(
      id: 6,
      name: r'questionCompleted',
      type: IsarType.longList,
    ),
    r'subjectCompleted': PropertySchema(
      id: 7,
      name: r'subjectCompleted',
      type: IsarType.longList,
    ),
    r'tz': PropertySchema(
      id: 8,
      name: r'tz',
      type: IsarType.string,
    ),
    r'userType': PropertySchema(
      id: 9,
      name: r'userType',
      type: IsarType.string,
    )
  },
  estimateSize: _userEstimateSize,
  serialize: _userSerialize,
  deserialize: _userDeserialize,
  deserializeProp: _userDeserializeProp,
  idName: r'id',
  indexes: {
    r'tz': IndexSchema(
      id: 2166409964335084001,
      name: r'tz',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'tz',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'UserCourse': UserCourseSchema,
    r'UserGrade': UserGradeSchema
  },
  getId: _userGetId,
  getLinks: _userGetLinks,
  attach: _userAttach,
  version: '3.1.0+1',
);

int _userEstimateSize(
  User object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.courses.length * 3;
  {
    final offsets = allOffsets[UserCourse]!;
    for (var i = 0; i < object.courses.length; i++) {
      final value = object.courses[i];
      bytesCount += UserCourseSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.knowledgeIds.length * 8;
  bytesCount += 3 + object.lessonCompleted.length * 8;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.pathIds.length * 8;
  bytesCount += 3 + object.percentages.length * 3;
  {
    final offsets = allOffsets[UserGrade]!;
    for (var i = 0; i < object.percentages.length; i++) {
      final value = object.percentages[i];
      bytesCount += UserGradeSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.questionCompleted.length * 8;
  bytesCount += 3 + object.subjectCompleted.length * 8;
  bytesCount += 3 + object.tz.length * 3;
  bytesCount += 3 + object.userType.length * 3;
  return bytesCount;
}

void _userSerialize(
  User object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<UserCourse>(
    offsets[0],
    allOffsets,
    UserCourseSchema.serialize,
    object.courses,
  );
  writer.writeLongList(offsets[1], object.knowledgeIds);
  writer.writeLongList(offsets[2], object.lessonCompleted);
  writer.writeString(offsets[3], object.name);
  writer.writeLongList(offsets[4], object.pathIds);
  writer.writeObjectList<UserGrade>(
    offsets[5],
    allOffsets,
    UserGradeSchema.serialize,
    object.percentages,
  );
  writer.writeLongList(offsets[6], object.questionCompleted);
  writer.writeLongList(offsets[7], object.subjectCompleted);
  writer.writeString(offsets[8], object.tz);
  writer.writeString(offsets[9], object.userType);
}

User _userDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = User();
  object.courses = reader.readObjectList<UserCourse>(
        offsets[0],
        UserCourseSchema.deserialize,
        allOffsets,
        UserCourse(),
      ) ??
      [];
  object.id = id;
  object.knowledgeIds = reader.readLongList(offsets[1]) ?? [];
  object.lessonCompleted = reader.readLongList(offsets[2]) ?? [];
  object.name = reader.readString(offsets[3]);
  object.pathIds = reader.readLongList(offsets[4]) ?? [];
  object.percentages = reader.readObjectList<UserGrade>(
        offsets[5],
        UserGradeSchema.deserialize,
        allOffsets,
        UserGrade(),
      ) ??
      [];
  object.questionCompleted = reader.readLongList(offsets[6]) ?? [];
  object.subjectCompleted = reader.readLongList(offsets[7]) ?? [];
  object.tz = reader.readString(offsets[8]);
  object.userType = reader.readString(offsets[9]);
  return object;
}

P _userDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<UserCourse>(
            offset,
            UserCourseSchema.deserialize,
            allOffsets,
            UserCourse(),
          ) ??
          []) as P;
    case 1:
      return (reader.readLongList(offset) ?? []) as P;
    case 2:
      return (reader.readLongList(offset) ?? []) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLongList(offset) ?? []) as P;
    case 5:
      return (reader.readObjectList<UserGrade>(
            offset,
            UserGradeSchema.deserialize,
            allOffsets,
            UserGrade(),
          ) ??
          []) as P;
    case 6:
      return (reader.readLongList(offset) ?? []) as P;
    case 7:
      return (reader.readLongList(offset) ?? []) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userGetId(User object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userGetLinks(User object) {
  return [];
}

void _userAttach(IsarCollection<dynamic> col, Id id, User object) {
  object.id = id;
}

extension UserByIndex on IsarCollection<User> {
  Future<User?> getByTz(String tz) {
    return getByIndex(r'tz', [tz]);
  }

  User? getByTzSync(String tz) {
    return getByIndexSync(r'tz', [tz]);
  }

  Future<bool> deleteByTz(String tz) {
    return deleteByIndex(r'tz', [tz]);
  }

  bool deleteByTzSync(String tz) {
    return deleteByIndexSync(r'tz', [tz]);
  }

  Future<List<User?>> getAllByTz(List<String> tzValues) {
    final values = tzValues.map((e) => [e]).toList();
    return getAllByIndex(r'tz', values);
  }

  List<User?> getAllByTzSync(List<String> tzValues) {
    final values = tzValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'tz', values);
  }

  Future<int> deleteAllByTz(List<String> tzValues) {
    final values = tzValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'tz', values);
  }

  int deleteAllByTzSync(List<String> tzValues) {
    final values = tzValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'tz', values);
  }

  Future<Id> putByTz(User object) {
    return putByIndex(r'tz', object);
  }

  Id putByTzSync(User object, {bool saveLinks = true}) {
    return putByIndexSync(r'tz', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTz(List<User> objects) {
    return putAllByIndex(r'tz', objects);
  }

  List<Id> putAllByTzSync(List<User> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'tz', objects, saveLinks: saveLinks);
  }
}

extension UserQueryWhereSort on QueryBuilder<User, User, QWhere> {
  QueryBuilder<User, User, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserQueryWhere on QueryBuilder<User, User, QWhereClause> {
  QueryBuilder<User, User, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<User, User, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<User, User, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<User, User, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<User, User, QAfterWhereClause> idBetween(
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

  QueryBuilder<User, User, QAfterWhereClause> tzEqualTo(String tz) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tz',
        value: [tz],
      ));
    });
  }

  QueryBuilder<User, User, QAfterWhereClause> tzNotEqualTo(String tz) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tz',
              lower: [],
              upper: [tz],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tz',
              lower: [tz],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tz',
              lower: [tz],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tz',
              lower: [],
              upper: [tz],
              includeUpper: false,
            ));
      }
    });
  }
}

extension UserQueryFilter on QueryBuilder<User, User, QFilterCondition> {
  QueryBuilder<User, User, QAfterFilterCondition> coursesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'UserCourse',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> coursesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'UserCourse',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> coursesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'UserCourse',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> coursesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'UserCourse',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> coursesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'UserCourse',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> coursesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'UserCourse',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> idBetween(
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

  QueryBuilder<User, User, QAfterFilterCondition> knowledgeIdsElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'knowledgeIds',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      knowledgeIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'knowledgeIds',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> knowledgeIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'knowledgeIds',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> knowledgeIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'knowledgeIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> knowledgeIdsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'knowledgeIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> knowledgeIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'knowledgeIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> knowledgeIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'knowledgeIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> knowledgeIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'knowledgeIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> knowledgeIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'knowledgeIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> knowledgeIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'knowledgeIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> lessonCompletedElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lessonCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      lessonCompletedElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lessonCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      lessonCompletedElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lessonCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> lessonCompletedElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lessonCompleted',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> lessonCompletedLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lessonCompleted',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> lessonCompletedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lessonCompleted',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> lessonCompletedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lessonCompleted',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> lessonCompletedLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lessonCompleted',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      lessonCompletedLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lessonCompleted',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> lessonCompletedLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lessonCompleted',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> pathIdsElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pathIds',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> pathIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pathIds',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> pathIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pathIds',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> pathIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pathIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> pathIdsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pathIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> pathIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pathIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> pathIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pathIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> pathIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pathIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> pathIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pathIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> pathIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pathIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> percentagesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'percentages',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> percentagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'percentages',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> percentagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'percentages',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> percentagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'percentages',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> percentagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'percentages',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> percentagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'percentages',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      questionCompletedElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      questionCompletedElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      questionCompletedElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      questionCompletedElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionCompleted',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      questionCompletedLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionCompleted',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> questionCompletedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionCompleted',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      questionCompletedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionCompleted',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      questionCompletedLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionCompleted',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      questionCompletedLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionCompleted',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      questionCompletedLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionCompleted',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      subjectCompletedElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subjectCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      subjectCompletedElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subjectCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      subjectCompletedElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subjectCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      subjectCompletedElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subjectCompleted',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> subjectCompletedLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subjectCompleted',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> subjectCompletedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subjectCompleted',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> subjectCompletedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subjectCompleted',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      subjectCompletedLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subjectCompleted',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      subjectCompletedLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subjectCompleted',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> subjectCompletedLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subjectCompleted',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> tzEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> tzGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> tzLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> tzBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tz',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> tzStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> tzEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> tzContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tz',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> tzMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tz',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> tzIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tz',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> tzIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tz',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userTypeContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userType',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userType',
        value: '',
      ));
    });
  }
}

extension UserQueryObject on QueryBuilder<User, User, QFilterCondition> {
  QueryBuilder<User, User, QAfterFilterCondition> coursesElement(
      FilterQuery<UserCourse> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'UserCourse');
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> percentagesElement(
      FilterQuery<UserGrade> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'percentages');
    });
  }
}

extension UserQueryLinks on QueryBuilder<User, User, QFilterCondition> {}

extension UserQuerySortBy on QueryBuilder<User, User, QSortBy> {
  QueryBuilder<User, User, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByTz() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tz', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByTzDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tz', Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByUserType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userType', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByUserTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userType', Sort.desc);
    });
  }
}

extension UserQuerySortThenBy on QueryBuilder<User, User, QSortThenBy> {
  QueryBuilder<User, User, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByTz() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tz', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByTzDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tz', Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByUserType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userType', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByUserTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userType', Sort.desc);
    });
  }
}

extension UserQueryWhereDistinct on QueryBuilder<User, User, QDistinct> {
  QueryBuilder<User, User, QDistinct> distinctByKnowledgeIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'knowledgeIds');
    });
  }

  QueryBuilder<User, User, QDistinct> distinctByLessonCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lessonCompleted');
    });
  }

  QueryBuilder<User, User, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QDistinct> distinctByPathIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pathIds');
    });
  }

  QueryBuilder<User, User, QDistinct> distinctByQuestionCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questionCompleted');
    });
  }

  QueryBuilder<User, User, QDistinct> distinctBySubjectCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subjectCompleted');
    });
  }

  QueryBuilder<User, User, QDistinct> distinctByTz(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tz', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QDistinct> distinctByUserType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userType', caseSensitive: caseSensitive);
    });
  }
}

extension UserQueryProperty on QueryBuilder<User, User, QQueryProperty> {
  QueryBuilder<User, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<User, List<UserCourse>, QQueryOperations> coursesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'UserCourse');
    });
  }

  QueryBuilder<User, List<int>, QQueryOperations> knowledgeIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'knowledgeIds');
    });
  }

  QueryBuilder<User, List<int>, QQueryOperations> lessonCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lessonCompleted');
    });
  }

  QueryBuilder<User, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<User, List<int>, QQueryOperations> pathIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pathIds');
    });
  }

  QueryBuilder<User, List<UserGrade>, QQueryOperations> percentagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'percentages');
    });
  }

  QueryBuilder<User, List<int>, QQueryOperations> questionCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionCompleted');
    });
  }

  QueryBuilder<User, List<int>, QQueryOperations> subjectCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subjectCompleted');
    });
  }

  QueryBuilder<User, String, QQueryOperations> tzProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tz');
    });
  }

  QueryBuilder<User, String, QQueryOperations> userTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userType');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const UserCourseSchema = Schema(
  name: r'UserCourse',
  id: -2901352725449561584,
  properties: {
    r'courseId': PropertySchema(
      id: 0,
      name: r'courseId',
      type: IsarType.long,
    ),
    r'diplomaPath': PropertySchema(
      id: 1,
      name: r'diplomaPath',
      type: IsarType.string,
    ),
    r'isQuestionnaire': PropertySchema(
      id: 2,
      name: r'isQuestionnaire',
      type: IsarType.bool,
    ),
    r'is_single_course': PropertySchema(
      id: 3,
      name: r'is_single_course',
      type: IsarType.bool,
    ),
    r'lessonStopId': PropertySchema(
      id: 4,
      name: r'lessonStopId',
      type: IsarType.long,
    ),
    r'progress_percent': PropertySchema(
      id: 5,
      name: r'progress_percent',
      type: IsarType.long,
    ),
    r'questionnaireStopId': PropertySchema(
      id: 6,
      name: r'questionnaireStopId',
      type: IsarType.long,
    ),
    r'status': PropertySchema(
      id: 7,
      name: r'status',
      type: IsarType.byte,
      enumMap: _UserCoursestatusEnumValueMap,
    ),
    r'subjectStopId': PropertySchema(
      id: 8,
      name: r'subjectStopId',
      type: IsarType.long,
    )
  },
  estimateSize: _userCourseEstimateSize,
  serialize: _userCourseSerialize,
  deserialize: _userCourseDeserialize,
  deserializeProp: _userCourseDeserializeProp,
);

int _userCourseEstimateSize(
  UserCourse object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.diplomaPath.length * 3;
  return bytesCount;
}

void _userCourseSerialize(
  UserCourse object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.courseId);
  writer.writeString(offsets[1], object.diplomaPath);
  writer.writeBool(offsets[2], object.isQuestionnaire);
  writer.writeBool(offsets[3], object.isSingleCourse);
  writer.writeLong(offsets[4], object.lessonStopId);
  writer.writeLong(offsets[5], object.progressPercent);
  writer.writeLong(offsets[6], object.questionnaireStopId);
  writer.writeByte(offsets[7], object.status.index);
  writer.writeLong(offsets[8], object.subjectStopId);
}

UserCourse _userCourseDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserCourse(
    courseId: reader.readLongOrNull(offsets[0]) ?? 0,
    diplomaPath: reader.readStringOrNull(offsets[1]) ?? '',
    isSingleCourse: reader.readBoolOrNull(offsets[3]) ?? false,
    progressPercent: reader.readLongOrNull(offsets[5]) ?? 0,
    status: _UserCoursestatusValueEnumMap[reader.readByteOrNull(offsets[7])] ??
        Status.start,
  );
  object.isQuestionnaire = reader.readBool(offsets[2]);
  object.lessonStopId = reader.readLong(offsets[4]);
  object.questionnaireStopId = reader.readLong(offsets[6]);
  object.subjectStopId = reader.readLong(offsets[8]);
  return object;
}

P _userCourseDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (_UserCoursestatusValueEnumMap[reader.readByteOrNull(offset)] ??
          Status.start) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UserCoursestatusEnumValueMap = {
  'start': 0,
  'middle': 1,
  'finish': 2,
  'synchronized': 3,
};
const _UserCoursestatusValueEnumMap = {
  0: Status.start,
  1: Status.middle,
  2: Status.finish,
  3: Status.synchronized,
};

extension UserCourseQueryFilter
    on QueryBuilder<UserCourse, UserCourse, QFilterCondition> {
  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition> courseIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'courseId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      courseIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'courseId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition> courseIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'courseId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition> courseIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'courseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      diplomaPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diplomaPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      diplomaPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diplomaPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      diplomaPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diplomaPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      diplomaPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diplomaPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      diplomaPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'diplomaPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      diplomaPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'diplomaPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      diplomaPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'diplomaPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      diplomaPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'diplomaPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      diplomaPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diplomaPath',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      diplomaPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'diplomaPath',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      isQuestionnaireEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isQuestionnaire',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      isSingleCourseEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'is_single_course',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      lessonStopIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lessonStopId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      lessonStopIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lessonStopId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      lessonStopIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lessonStopId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      lessonStopIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lessonStopId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      progressPercentEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progress_percent',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      progressPercentGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'progress_percent',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      progressPercentLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'progress_percent',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      progressPercentBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'progress_percent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      questionnaireStopIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionnaireStopId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      questionnaireStopIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionnaireStopId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      questionnaireStopIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionnaireStopId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      questionnaireStopIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionnaireStopId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition> statusEqualTo(
      Status value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition> statusGreaterThan(
    Status value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition> statusLessThan(
    Status value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition> statusBetween(
    Status lower,
    Status upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      subjectStopIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subjectStopId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      subjectStopIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subjectStopId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      subjectStopIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subjectStopId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCourse, UserCourse, QAfterFilterCondition>
      subjectStopIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subjectStopId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserCourseQueryObject
    on QueryBuilder<UserCourse, UserCourse, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const UserGradeSchema = Schema(
  name: r'UserGrade',
  id: 6206172405607541662,
  properties: {
    r'percentage': PropertySchema(
      id: 0,
      name: r'percentage',
      type: IsarType.long,
    ),
    r'quizId': PropertySchema(
      id: 1,
      name: r'quizId',
      type: IsarType.long,
    ),
    r'score': PropertySchema(
      id: 2,
      name: r'score',
      type: IsarType.long,
    )
  },
  estimateSize: _userGradeEstimateSize,
  serialize: _userGradeSerialize,
  deserialize: _userGradeDeserialize,
  deserializeProp: _userGradeDeserializeProp,
);

int _userGradeEstimateSize(
  UserGrade object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _userGradeSerialize(
  UserGrade object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.percentage);
  writer.writeLong(offsets[1], object.quizId);
  writer.writeLong(offsets[2], object.score);
}

UserGrade _userGradeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserGrade(
    percentage: reader.readLongOrNull(offsets[0]) ?? 0,
    quizId: reader.readLongOrNull(offsets[1]) ?? 0,
    score: reader.readLongOrNull(offsets[2]) ?? 0,
  );
  return object;
}

P _userGradeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension UserGradeQueryFilter
    on QueryBuilder<UserGrade, UserGrade, QFilterCondition> {
  QueryBuilder<UserGrade, UserGrade, QAfterFilterCondition> percentageEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'percentage',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGrade, UserGrade, QAfterFilterCondition>
      percentageGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'percentage',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGrade, UserGrade, QAfterFilterCondition> percentageLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'percentage',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGrade, UserGrade, QAfterFilterCondition> percentageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'percentage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserGrade, UserGrade, QAfterFilterCondition> quizIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quizId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGrade, UserGrade, QAfterFilterCondition> quizIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quizId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGrade, UserGrade, QAfterFilterCondition> quizIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quizId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGrade, UserGrade, QAfterFilterCondition> quizIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quizId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserGrade, UserGrade, QAfterFilterCondition> scoreEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGrade, UserGrade, QAfterFilterCondition> scoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGrade, UserGrade, QAfterFilterCondition> scoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGrade, UserGrade, QAfterFilterCondition> scoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'score',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserGradeQueryObject
    on QueryBuilder<UserGrade, UserGrade, QFilterCondition> {}
