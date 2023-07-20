// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLessonCollection on Isar {
  IsarCollection<Lesson> get lessons => this.collection();
}

const LessonSchema = CollectionSchema(
  name: r'Lesson',
  id: 6343151657775798464,
  properties: {
    r'isCompletedCurrentUser': PropertySchema(
      id: 0,
      name: r'isCompletedCurrentUser',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'time': PropertySchema(
      id: 2,
      name: r'time',
      type: IsarType.string,
    ),
    r'vimoe': PropertySchema(
      id: 3,
      name: r'vimoe',
      type: IsarType.string,
    )
  },
  estimateSize: _lessonEstimateSize,
  serialize: _lessonSerialize,
  deserialize: _lessonDeserialize,
  deserializeProp: _lessonDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'questionnaire': LinkSchema(
      id: 5260463454641152466,
      name: r'questionnaire',
      target: r'Quiz',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _lessonGetId,
  getLinks: _lessonGetLinks,
  attach: _lessonAttach,
  version: '3.1.0+1',
);

int _lessonEstimateSize(
  Lesson object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.time.length * 3;
  {
    final value = object.vimeo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _lessonSerialize(
  Lesson object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isCompletedCurrentUser);
  writer.writeString(offsets[1], object.name);
  writer.writeString(offsets[2], object.time);
  writer.writeString(offsets[3], object.vimeo);
}

Lesson _lessonDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Lesson(
    id: id,
    name: reader.readStringOrNull(offsets[1]) ?? '',
    time: reader.readStringOrNull(offsets[2]) ?? '',
    vimeo: reader.readStringOrNull(offsets[3]),
  );
  object.isCompletedCurrentUser = reader.readBool(offsets[0]);
  return object;
}

P _lessonDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _lessonGetId(Lesson object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _lessonGetLinks(Lesson object) {
  return [object.questionnaire];
}

void _lessonAttach(IsarCollection<dynamic> col, Id id, Lesson object) {
  object.id = id;
  object.questionnaire
      .attach(col, col.isar.collection<Quiz>(), r'questionnaire', id);
}

extension LessonQueryWhereSort on QueryBuilder<Lesson, Lesson, QWhere> {
  QueryBuilder<Lesson, Lesson, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LessonQueryWhere on QueryBuilder<Lesson, Lesson, QWhereClause> {
  QueryBuilder<Lesson, Lesson, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Lesson, Lesson, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterWhereClause> idBetween(
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

extension LessonQueryFilter on QueryBuilder<Lesson, Lesson, QFilterCondition> {
  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition>
      isCompletedCurrentUserEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompletedCurrentUser',
        value: value,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> timeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> timeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> timeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> timeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'time',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> timeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> timeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> timeContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> timeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'time',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> timeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'time',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> timeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'time',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> vimeoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vimoe',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> vimeoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vimoe',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> vimeoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vimoe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> vimeoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vimoe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> vimeoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vimoe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> vimeoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vimoe',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> vimeoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vimoe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> vimeoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vimoe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> vimeoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vimoe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> vimeoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vimoe',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> vimeoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vimoe',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> vimeoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vimoe',
        value: '',
      ));
    });
  }
}

extension LessonQueryObject on QueryBuilder<Lesson, Lesson, QFilterCondition> {}

extension LessonQueryLinks on QueryBuilder<Lesson, Lesson, QFilterCondition> {
  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> questionnaire(
      FilterQuery<Quiz> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'questionnaire');
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition>
      questionnaireLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questionnaire', length, true, length, true);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition> questionnaireIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questionnaire', 0, true, 0, true);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition>
      questionnaireIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questionnaire', 0, false, 999999, true);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition>
      questionnaireLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questionnaire', 0, true, length, include);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition>
      questionnaireLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questionnaire', length, include, 999999, true);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterFilterCondition>
      questionnaireLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'questionnaire', lower, includeLower, upper, includeUpper);
    });
  }
}

extension LessonQuerySortBy on QueryBuilder<Lesson, Lesson, QSortBy> {
  QueryBuilder<Lesson, Lesson, QAfterSortBy> sortByIsCompletedCurrentUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompletedCurrentUser', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy>
      sortByIsCompletedCurrentUserDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompletedCurrentUser', Sort.desc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> sortByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> sortByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> sortByVimeo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vimoe', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> sortByVimeoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vimoe', Sort.desc);
    });
  }
}

extension LessonQuerySortThenBy on QueryBuilder<Lesson, Lesson, QSortThenBy> {
  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByIsCompletedCurrentUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompletedCurrentUser', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy>
      thenByIsCompletedCurrentUserDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompletedCurrentUser', Sort.desc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByVimeo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vimoe', Sort.asc);
    });
  }

  QueryBuilder<Lesson, Lesson, QAfterSortBy> thenByVimeoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vimoe', Sort.desc);
    });
  }
}

extension LessonQueryWhereDistinct on QueryBuilder<Lesson, Lesson, QDistinct> {
  QueryBuilder<Lesson, Lesson, QDistinct> distinctByIsCompletedCurrentUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompletedCurrentUser');
    });
  }

  QueryBuilder<Lesson, Lesson, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lesson, Lesson, QDistinct> distinctByTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'time', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lesson, Lesson, QDistinct> distinctByVimeo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vimoe', caseSensitive: caseSensitive);
    });
  }
}

extension LessonQueryProperty on QueryBuilder<Lesson, Lesson, QQueryProperty> {
  QueryBuilder<Lesson, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Lesson, bool, QQueryOperations>
      isCompletedCurrentUserProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompletedCurrentUser');
    });
  }

  QueryBuilder<Lesson, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Lesson, String, QQueryOperations> timeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'time');
    });
  }

  QueryBuilder<Lesson, String?, QQueryOperations> vimeoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vimoe');
    });
  }
}
