// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuizCollection on Isar {
  IsarCollection<Quiz> get quizs => this.collection();
}

const QuizSchema = CollectionSchema(
  name: r'Quiz',
  id: 3912563531471134748,
  properties: {
    r'grade1': PropertySchema(
      id: 0,
      name: r'grade1',
      type: IsarType.long,
    ),
    r'grade2': PropertySchema(
      id: 1,
      name: r'grade2',
      type: IsarType.long,
    ),
    r'isCompletedCurrentUser': PropertySchema(
      id: 2,
      name: r'isCompletedCurrentUser',
      type: IsarType.bool,
    ),
    r'questionList': PropertySchema(
      id: 3,
      name: r'questionList',
      type: IsarType.objectList,
      target: r'Question',
    ),
    r'quizMaterials': PropertySchema(
      id: 4,
      name: r'quizMaterials',
      type: IsarType.string,
    ),
    r'quizUrls': PropertySchema(
      id: 5,
      name: r'quizUrls',
      type: IsarType.stringList,
    ),
    r'time': PropertySchema(
      id: 6,
      name: r'time',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 7,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _quizEstimateSize,
  serialize: _quizSerialize,
  deserialize: _quizDeserialize,
  deserializeProp: _quizDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'Question': QuestionSchema,
    r'Answer': AnswerSchema,
    r'MoreData': MoreDataSchema,
    r'CustomQuizQuestionsFields': CustomQuizQuestionsFieldsSchema
  },
  getId: _quizGetId,
  getLinks: _quizGetLinks,
  attach: _quizAttach,
  version: '3.1.0+1',
);

int _quizEstimateSize(
  Quiz object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.questionList.length * 3;
  {
    final offsets = allOffsets[Question]!;
    for (var i = 0; i < object.questionList.length; i++) {
      final value = object.questionList[i];
      bytesCount += QuestionSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.quizMaterials.length * 3;
  bytesCount += 3 + object.quizUrls.length * 3;
  {
    for (var i = 0; i < object.quizUrls.length; i++) {
      final value = object.quizUrls[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.time.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _quizSerialize(
  Quiz object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.grade1);
  writer.writeLong(offsets[1], object.grade2);
  writer.writeBool(offsets[2], object.isCompletedCurrentUser);
  writer.writeObjectList<Question>(
    offsets[3],
    allOffsets,
    QuestionSchema.serialize,
    object.questionList,
  );
  writer.writeString(offsets[4], object.quizMaterials);
  writer.writeStringList(offsets[5], object.quizUrls);
  writer.writeString(offsets[6], object.time);
  writer.writeString(offsets[7], object.title);
}

Quiz _quizDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Quiz(
    grade1: reader.readLongOrNull(offsets[0]) ?? 0,
    grade2: reader.readLongOrNull(offsets[1]) ?? 0,
    id: id,
    questionList: reader.readObjectList<Question>(
          offsets[3],
          QuestionSchema.deserialize,
          allOffsets,
          Question(),
        ) ??
        const [],
    quizMaterials: reader.readStringOrNull(offsets[4]) ?? '',
    time: reader.readStringOrNull(offsets[6]) ?? '',
    title: reader.readStringOrNull(offsets[7]) ?? '',
  );
  object.isCompletedCurrentUser = reader.readBool(offsets[2]);
  object.quizUrls = reader.readStringList(offsets[5]) ?? [];
  return object;
}

P _quizDeserializeProp<P>(
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
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readObjectList<Question>(
            offset,
            QuestionSchema.deserialize,
            allOffsets,
            Question(),
          ) ??
          const []) as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _quizGetId(Quiz object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _quizGetLinks(Quiz object) {
  return [];
}

void _quizAttach(IsarCollection<dynamic> col, Id id, Quiz object) {
  object.id = id;
}

extension QuizQueryWhereSort on QueryBuilder<Quiz, Quiz, QWhere> {
  QueryBuilder<Quiz, Quiz, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension QuizQueryWhere on QueryBuilder<Quiz, Quiz, QWhereClause> {
  QueryBuilder<Quiz, Quiz, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Quiz, Quiz, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterWhereClause> idBetween(
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

extension QuizQueryFilter on QueryBuilder<Quiz, Quiz, QFilterCondition> {
  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> grade1EqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grade1',
        value: value,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> grade1GreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'grade1',
        value: value,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> grade1LessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'grade1',
        value: value,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> grade1Between(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'grade1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> grade2EqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grade2',
        value: value,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> grade2GreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'grade2',
        value: value,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> grade2LessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'grade2',
        value: value,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> grade2Between(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'grade2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> isCompletedCurrentUserEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompletedCurrentUser',
        value: value,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> questionListLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> questionListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> questionListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> questionListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> questionListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> questionListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizMaterialsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quizMaterials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizMaterialsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quizMaterials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizMaterialsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quizMaterials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizMaterialsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quizMaterials',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizMaterialsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quizMaterials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizMaterialsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quizMaterials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizMaterialsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quizMaterials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizMaterialsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quizMaterials',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizMaterialsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quizMaterials',
        value: '',
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizMaterialsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quizMaterials',
        value: '',
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizUrlsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quizUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizUrlsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quizUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizUrlsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quizUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizUrlsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quizUrls',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizUrlsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quizUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizUrlsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quizUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizUrlsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quizUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizUrlsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quizUrls',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizUrlsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quizUrls',
        value: '',
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizUrlsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quizUrls',
        value: '',
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizUrlsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'quizUrls',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizUrlsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'quizUrls',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizUrlsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'quizUrls',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizUrlsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'quizUrls',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizUrlsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'quizUrls',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> quizUrlsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'quizUrls',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> timeEqualTo(
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

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> timeGreaterThan(
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

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> timeLessThan(
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

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> timeBetween(
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

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> timeStartsWith(
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

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> timeEndsWith(
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

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> timeContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> timeMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'time',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> timeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'time',
        value: '',
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> timeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'time',
        value: '',
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> titleEqualTo(
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

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> titleGreaterThan(
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

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> titleLessThan(
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

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> titleBetween(
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

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> titleStartsWith(
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

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> titleEndsWith(
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

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> titleContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> titleMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension QuizQueryObject on QueryBuilder<Quiz, Quiz, QFilterCondition> {
  QueryBuilder<Quiz, Quiz, QAfterFilterCondition> questionListElement(
      FilterQuery<Question> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'questionList');
    });
  }
}

extension QuizQueryLinks on QueryBuilder<Quiz, Quiz, QFilterCondition> {}

extension QuizQuerySortBy on QueryBuilder<Quiz, Quiz, QSortBy> {
  QueryBuilder<Quiz, Quiz, QAfterSortBy> sortByGrade1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grade1', Sort.asc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> sortByGrade1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grade1', Sort.desc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> sortByGrade2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grade2', Sort.asc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> sortByGrade2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grade2', Sort.desc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> sortByIsCompletedCurrentUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompletedCurrentUser', Sort.asc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> sortByIsCompletedCurrentUserDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompletedCurrentUser', Sort.desc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> sortByQuizMaterials() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quizMaterials', Sort.asc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> sortByQuizMaterialsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quizMaterials', Sort.desc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> sortByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> sortByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension QuizQuerySortThenBy on QueryBuilder<Quiz, Quiz, QSortThenBy> {
  QueryBuilder<Quiz, Quiz, QAfterSortBy> thenByGrade1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grade1', Sort.asc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> thenByGrade1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grade1', Sort.desc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> thenByGrade2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grade2', Sort.asc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> thenByGrade2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grade2', Sort.desc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> thenByIsCompletedCurrentUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompletedCurrentUser', Sort.asc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> thenByIsCompletedCurrentUserDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompletedCurrentUser', Sort.desc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> thenByQuizMaterials() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quizMaterials', Sort.asc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> thenByQuizMaterialsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quizMaterials', Sort.desc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> thenByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> thenByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Quiz, Quiz, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension QuizQueryWhereDistinct on QueryBuilder<Quiz, Quiz, QDistinct> {
  QueryBuilder<Quiz, Quiz, QDistinct> distinctByGrade1() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grade1');
    });
  }

  QueryBuilder<Quiz, Quiz, QDistinct> distinctByGrade2() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grade2');
    });
  }

  QueryBuilder<Quiz, Quiz, QDistinct> distinctByIsCompletedCurrentUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompletedCurrentUser');
    });
  }

  QueryBuilder<Quiz, Quiz, QDistinct> distinctByQuizMaterials(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quizMaterials',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Quiz, Quiz, QDistinct> distinctByQuizUrls() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quizUrls');
    });
  }

  QueryBuilder<Quiz, Quiz, QDistinct> distinctByTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'time', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Quiz, Quiz, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension QuizQueryProperty on QueryBuilder<Quiz, Quiz, QQueryProperty> {
  QueryBuilder<Quiz, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Quiz, int, QQueryOperations> grade1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grade1');
    });
  }

  QueryBuilder<Quiz, int, QQueryOperations> grade2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grade2');
    });
  }

  QueryBuilder<Quiz, bool, QQueryOperations> isCompletedCurrentUserProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompletedCurrentUser');
    });
  }

  QueryBuilder<Quiz, List<Question>, QQueryOperations> questionListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionList');
    });
  }

  QueryBuilder<Quiz, String, QQueryOperations> quizMaterialsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quizMaterials');
    });
  }

  QueryBuilder<Quiz, List<String>, QQueryOperations> quizUrlsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quizUrls');
    });
  }

  QueryBuilder<Quiz, String, QQueryOperations> timeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'time');
    });
  }

  QueryBuilder<Quiz, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const QuestionSchema = Schema(
  name: r'Question',
  id: -6819722535046815095,
  properties: {
    r'ans': PropertySchema(
      id: 0,
      name: r'ans',
      type: IsarType.objectList,
      target: r'Answer',
    ),
    r'id_ques': PropertySchema(
      id: 1,
      name: r'id_ques',
      type: IsarType.long,
    ),
    r'more_data': PropertySchema(
      id: 2,
      name: r'more_data',
      type: IsarType.object,
      target: r'MoreData',
    ),
    r'options': PropertySchema(
      id: 3,
      name: r'options',
      type: IsarType.stringList,
    ),
    r'points': PropertySchema(
      id: 4,
      name: r'points',
      type: IsarType.long,
    ),
    r'question': PropertySchema(
      id: 5,
      name: r'question',
      type: IsarType.string,
    ),
    r'tip': PropertySchema(
      id: 6,
      name: r'tip',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 7,
      name: r'type',
      type: IsarType.byte,
      enumMap: _QuestiontypeEnumValueMap,
    )
  },
  estimateSize: _questionEstimateSize,
  serialize: _questionSerialize,
  deserialize: _questionDeserialize,
  deserializeProp: _questionDeserializeProp,
);

int _questionEstimateSize(
  Question object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.ans;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[Answer]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += AnswerSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.moreData;
    if (value != null) {
      bytesCount += 3 +
          MoreDataSchema.estimateSize(value, allOffsets[MoreData]!, allOffsets);
    }
  }
  {
    final list = object.options;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  bytesCount += 3 + object.question.length * 3;
  bytesCount += 3 + object.tip.length * 3;
  return bytesCount;
}

void _questionSerialize(
  Question object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<Answer>(
    offsets[0],
    allOffsets,
    AnswerSchema.serialize,
    object.ans,
  );
  writer.writeLong(offsets[1], object.idQues);
  writer.writeObject<MoreData>(
    offsets[2],
    allOffsets,
    MoreDataSchema.serialize,
    object.moreData,
  );
  writer.writeStringList(offsets[3], object.options);
  writer.writeLong(offsets[4], object.points);
  writer.writeString(offsets[5], object.question);
  writer.writeString(offsets[6], object.tip);
  writer.writeByte(offsets[7], object.type.index);
}

Question _questionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Question(
    ans: reader.readObjectList<Answer>(
      offsets[0],
      AnswerSchema.deserialize,
      allOffsets,
      Answer(),
    ),
    idQues: reader.readLongOrNull(offsets[1]) ?? -1,
    options: reader.readStringList(offsets[3]),
    points: reader.readLongOrNull(offsets[4]) ?? 0,
    question: reader.readStringOrNull(offsets[5]) ?? '',
    type: _QuestiontypeValueEnumMap[reader.readByteOrNull(offsets[7])] ??
        QType.checkbox,
  );
  object.moreData = reader.readObjectOrNull<MoreData>(
    offsets[2],
    MoreDataSchema.deserialize,
    allOffsets,
  );
  object.tip = reader.readString(offsets[6]);
  return object;
}

P _questionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<Answer>(
        offset,
        AnswerSchema.deserialize,
        allOffsets,
        Answer(),
      )) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? -1) as P;
    case 2:
      return (reader.readObjectOrNull<MoreData>(
        offset,
        MoreDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readStringList(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (_QuestiontypeValueEnumMap[reader.readByteOrNull(offset)] ??
          QType.checkbox) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _QuestiontypeEnumValueMap = {
  'radio': 0,
  'checkbox': 1,
  'fillIn': 2,
  'freeChoice': 3,
  'openQ': 4,
  'sort': 5,
  'sortMatrix': 6,
  'customEditor': 7,
};
const _QuestiontypeValueEnumMap = {
  0: QType.radio,
  1: QType.checkbox,
  2: QType.fillIn,
  3: QType.freeChoice,
  4: QType.openQ,
  5: QType.sort,
  6: QType.sortMatrix,
  7: QType.customEditor,
};

extension QuestionQueryFilter
    on QueryBuilder<Question, Question, QFilterCondition> {
  QueryBuilder<Question, Question, QAfterFilterCondition> ansIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ans',
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> ansIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ans',
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> ansLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ans',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> ansIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ans',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> ansIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ans',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> ansLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ans',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> ansLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ans',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> ansLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ans',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> idQuesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id_ques',
        value: value,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> idQuesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id_ques',
        value: value,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> idQuesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id_ques',
        value: value,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> idQuesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id_ques',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> moreDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'more_data',
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> moreDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'more_data',
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> optionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'options',
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> optionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'options',
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> optionsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'options',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition>
      optionsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'options',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition>
      optionsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'options',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> optionsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'options',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition>
      optionsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'options',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition>
      optionsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'options',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition>
      optionsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'options',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> optionsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'options',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition>
      optionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'options',
        value: '',
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition>
      optionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'options',
        value: '',
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> optionsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> optionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> optionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> optionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition>
      optionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> optionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> pointsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'points',
        value: value,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> pointsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'points',
        value: value,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> pointsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'points',
        value: value,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> pointsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'points',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> questionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> questionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> questionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> questionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'question',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> questionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> questionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> questionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> questionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'question',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> questionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: '',
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> questionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'question',
        value: '',
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> tipEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> tipGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> tipLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> tipBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tip',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> tipStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> tipEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> tipContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> tipMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tip',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> tipIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tip',
        value: '',
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> tipIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tip',
        value: '',
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> typeEqualTo(
      QType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> typeGreaterThan(
    QType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> typeLessThan(
    QType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> typeBetween(
    QType lower,
    QType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuestionQueryObject
    on QueryBuilder<Question, Question, QFilterCondition> {
  QueryBuilder<Question, Question, QAfterFilterCondition> ansElement(
      FilterQuery<Answer> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'ans');
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> moreData(
      FilterQuery<MoreData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'more_data');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const AnswerSchema = Schema(
  name: r'Answer',
  id: -5347394118497230781,
  properties: {
    r'ans': PropertySchema(
      id: 0,
      name: r'ans',
      type: IsarType.string,
    ),
    r'html': PropertySchema(
      id: 1,
      name: r'html',
      type: IsarType.bool,
    ),
    r'isCurrect': PropertySchema(
      id: 2,
      name: r'isCurrect',
      type: IsarType.bool,
    ),
    r'matrixMatch': PropertySchema(
      id: 3,
      name: r'matrixMatch',
      type: IsarType.string,
    ),
    r'points': PropertySchema(
      id: 4,
      name: r'points',
      type: IsarType.long,
    )
  },
  estimateSize: _answerEstimateSize,
  serialize: _answerSerialize,
  deserialize: _answerDeserialize,
  deserializeProp: _answerDeserializeProp,
);

int _answerEstimateSize(
  Answer object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.ans.length * 3;
  {
    final value = object.matrixMatch;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _answerSerialize(
  Answer object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ans);
  writer.writeBool(offsets[1], object.html);
  writer.writeBool(offsets[2], object.isCorrect);
  writer.writeString(offsets[3], object.matrixMatch);
  writer.writeLong(offsets[4], object.points);
}

Answer _answerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Answer(
    ans: reader.readStringOrNull(offsets[0]) ?? '',
    html: reader.readBoolOrNull(offsets[1]) ?? false,
    isCorrect: reader.readBoolOrNull(offsets[2]) ?? false,
    matrixMatch: reader.readStringOrNull(offsets[3]),
    points: reader.readLongOrNull(offsets[4]) ?? -1,
  );
  return object;
}

P _answerDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? -1) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension AnswerQueryFilter on QueryBuilder<Answer, Answer, QFilterCondition> {
  QueryBuilder<Answer, Answer, QAfterFilterCondition> ansEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ans',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> ansGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ans',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> ansLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ans',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> ansBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ans',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> ansStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ans',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> ansEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ans',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> ansContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ans',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> ansMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ans',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> ansIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ans',
        value: '',
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> ansIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ans',
        value: '',
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> htmlEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'html',
        value: value,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> isCorrectEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCurrect',
        value: value,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> matrixMatchIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'matrixMatch',
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> matrixMatchIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'matrixMatch',
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> matrixMatchEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matrixMatch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> matrixMatchGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'matrixMatch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> matrixMatchLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'matrixMatch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> matrixMatchBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'matrixMatch',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> matrixMatchStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'matrixMatch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> matrixMatchEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'matrixMatch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> matrixMatchContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'matrixMatch',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> matrixMatchMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'matrixMatch',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> matrixMatchIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matrixMatch',
        value: '',
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> matrixMatchIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'matrixMatch',
        value: '',
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> pointsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'points',
        value: value,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> pointsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'points',
        value: value,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> pointsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'points',
        value: value,
      ));
    });
  }

  QueryBuilder<Answer, Answer, QAfterFilterCondition> pointsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'points',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AnswerQueryObject on QueryBuilder<Answer, Answer, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MoreDataSchema = Schema(
  name: r'MoreData',
  id: -554138319672822089,
  properties: {
    r'background_image_option': PropertySchema(
      id: 0,
      name: r'background_image_option',
      type: IsarType.string,
    ),
    r'custom_quiz_questions_fields': PropertySchema(
      id: 1,
      name: r'custom_quiz_questions_fields',
      type: IsarType.objectList,
      target: r'CustomQuizQuestionsFields',
    ),
    r'custom_quiz_questions_height': PropertySchema(
      id: 2,
      name: r'custom_quiz_questions_height',
      type: IsarType.string,
    ),
    r'custom_quiz_questions_width': PropertySchema(
      id: 3,
      name: r'custom_quiz_questions_width',
      type: IsarType.string,
    )
  },
  estimateSize: _moreDataEstimateSize,
  serialize: _moreDataSerialize,
  deserialize: _moreDataDeserialize,
  deserializeProp: _moreDataDeserializeProp,
);

int _moreDataEstimateSize(
  MoreData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.backgroundImageOption.length * 3;
  bytesCount += 3 + object.quizFields.length * 3;
  {
    final offsets = allOffsets[CustomQuizQuestionsFields]!;
    for (var i = 0; i < object.quizFields.length; i++) {
      final value = object.quizFields[i];
      bytesCount += CustomQuizQuestionsFieldsSchema.estimateSize(
          value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.customQuizQuestionsHeight.length * 3;
  bytesCount += 3 + object.customQuizQuestionsWidth.length * 3;
  return bytesCount;
}

void _moreDataSerialize(
  MoreData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.backgroundImageOption);
  writer.writeObjectList<CustomQuizQuestionsFields>(
    offsets[1],
    allOffsets,
    CustomQuizQuestionsFieldsSchema.serialize,
    object.quizFields,
  );
  writer.writeString(offsets[2], object.customQuizQuestionsHeight);
  writer.writeString(offsets[3], object.customQuizQuestionsWidth);
}

MoreData _moreDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MoreData(
    backgroundImageOption: reader.readStringOrNull(offsets[0]) ?? '',
    quizFields: reader.readObjectList<CustomQuizQuestionsFields>(
          offsets[1],
          CustomQuizQuestionsFieldsSchema.deserialize,
          allOffsets,
          CustomQuizQuestionsFields(),
        ) ??
        const [],
    customQuizQuestionsHeight: reader.readStringOrNull(offsets[2]) ?? '',
    customQuizQuestionsWidth: reader.readStringOrNull(offsets[3]) ?? '',
  );
  return object;
}

P _moreDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readObjectList<CustomQuizQuestionsFields>(
            offset,
            CustomQuizQuestionsFieldsSchema.deserialize,
            allOffsets,
            CustomQuizQuestionsFields(),
          ) ??
          const []) as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension MoreDataQueryFilter
    on QueryBuilder<MoreData, MoreData, QFilterCondition> {
  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      backgroundImageOptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'background_image_option',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      backgroundImageOptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'background_image_option',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      backgroundImageOptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'background_image_option',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      backgroundImageOptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'background_image_option',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      backgroundImageOptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'background_image_option',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      backgroundImageOptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'background_image_option',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      backgroundImageOptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'background_image_option',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      backgroundImageOptionMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'background_image_option',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      backgroundImageOptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'background_image_option',
        value: '',
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      backgroundImageOptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'background_image_option',
        value: '',
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      quizFieldsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'custom_quiz_questions_fields',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition> quizFieldsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'custom_quiz_questions_fields',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      quizFieldsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'custom_quiz_questions_fields',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      quizFieldsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'custom_quiz_questions_fields',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      quizFieldsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'custom_quiz_questions_fields',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      quizFieldsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'custom_quiz_questions_fields',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsHeightEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'custom_quiz_questions_height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsHeightGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'custom_quiz_questions_height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsHeightLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'custom_quiz_questions_height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsHeightBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'custom_quiz_questions_height',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsHeightStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'custom_quiz_questions_height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsHeightEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'custom_quiz_questions_height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsHeightContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'custom_quiz_questions_height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsHeightMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'custom_quiz_questions_height',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsHeightIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'custom_quiz_questions_height',
        value: '',
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsHeightIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'custom_quiz_questions_height',
        value: '',
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsWidthEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'custom_quiz_questions_width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsWidthGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'custom_quiz_questions_width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsWidthLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'custom_quiz_questions_width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsWidthBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'custom_quiz_questions_width',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsWidthStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'custom_quiz_questions_width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsWidthEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'custom_quiz_questions_width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsWidthContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'custom_quiz_questions_width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsWidthMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'custom_quiz_questions_width',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsWidthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'custom_quiz_questions_width',
        value: '',
      ));
    });
  }

  QueryBuilder<MoreData, MoreData, QAfterFilterCondition>
      customQuizQuestionsWidthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'custom_quiz_questions_width',
        value: '',
      ));
    });
  }
}

extension MoreDataQueryObject
    on QueryBuilder<MoreData, MoreData, QFilterCondition> {
  QueryBuilder<MoreData, MoreData, QAfterFilterCondition> quizFieldsElement(
      FilterQuery<CustomQuizQuestionsFields> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'custom_quiz_questions_fields');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CustomQuizQuestionsFieldsSchema = Schema(
  name: r'CustomQuizQuestionsFields',
  id: 4211534481109437209,
  properties: {
    r'background': PropertySchema(
      id: 0,
      name: r'background',
      type: IsarType.string,
    ),
    r'bold': PropertySchema(
      id: 1,
      name: r'bold',
      type: IsarType.string,
    ),
    r'color': PropertySchema(
      id: 2,
      name: r'color',
      type: IsarType.string,
    ),
    r'correct_answer': PropertySchema(
      id: 3,
      name: r'correct_answer',
      type: IsarType.string,
    ),
    r'default_value': PropertySchema(
      id: 4,
      name: r'default_value',
      type: IsarType.string,
    ),
    r'direction': PropertySchema(
      id: 5,
      name: r'direction',
      type: IsarType.string,
    ),
    r'editable': PropertySchema(
      id: 6,
      name: r'editable',
      type: IsarType.string,
    ),
    r'font_size': PropertySchema(
      id: 7,
      name: r'font_size',
      type: IsarType.string,
    ),
    r'height': PropertySchema(
      id: 8,
      name: r'height',
      type: IsarType.string,
    ),
    r'max_width': PropertySchema(
      id: 9,
      name: r'max_width',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 10,
      name: r'name',
      type: IsarType.string,
    ),
    r'points': PropertySchema(
      id: 11,
      name: r'points',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 12,
      name: r'type',
      type: IsarType.string,
    ),
    r'width': PropertySchema(
      id: 13,
      name: r'width',
      type: IsarType.string,
    ),
    r'x_position': PropertySchema(
      id: 14,
      name: r'x_position',
      type: IsarType.string,
    ),
    r'y_position': PropertySchema(
      id: 15,
      name: r'y_position',
      type: IsarType.string,
    )
  },
  estimateSize: _customQuizQuestionsFieldsEstimateSize,
  serialize: _customQuizQuestionsFieldsSerialize,
  deserialize: _customQuizQuestionsFieldsDeserialize,
  deserializeProp: _customQuizQuestionsFieldsDeserializeProp,
);

int _customQuizQuestionsFieldsEstimateSize(
  CustomQuizQuestionsFields object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.background.length * 3;
  bytesCount += 3 + object.bold.length * 3;
  bytesCount += 3 + object.color.length * 3;
  bytesCount += 3 + object.correctAnswer.length * 3;
  bytesCount += 3 + object.defaultValue.length * 3;
  bytesCount += 3 + object.direction.length * 3;
  bytesCount += 3 + object.editable.length * 3;
  bytesCount += 3 + object.fontSize.length * 3;
  bytesCount += 3 + object.height.length * 3;
  bytesCount += 3 + object.maxWidth.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.points.length * 3;
  bytesCount += 3 + object.type.length * 3;
  bytesCount += 3 + object.width.length * 3;
  bytesCount += 3 + object.xPosition.length * 3;
  bytesCount += 3 + object.yPosition.length * 3;
  return bytesCount;
}

void _customQuizQuestionsFieldsSerialize(
  CustomQuizQuestionsFields object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.background);
  writer.writeString(offsets[1], object.bold);
  writer.writeString(offsets[2], object.color);
  writer.writeString(offsets[3], object.correctAnswer);
  writer.writeString(offsets[4], object.defaultValue);
  writer.writeString(offsets[5], object.direction);
  writer.writeString(offsets[6], object.editable);
  writer.writeString(offsets[7], object.fontSize);
  writer.writeString(offsets[8], object.height);
  writer.writeString(offsets[9], object.maxWidth);
  writer.writeString(offsets[10], object.name);
  writer.writeString(offsets[11], object.points);
  writer.writeString(offsets[12], object.type);
  writer.writeString(offsets[13], object.width);
  writer.writeString(offsets[14], object.xPosition);
  writer.writeString(offsets[15], object.yPosition);
}

CustomQuizQuestionsFields _customQuizQuestionsFieldsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CustomQuizQuestionsFields(
    background: reader.readStringOrNull(offsets[0]) ?? '',
    bold: reader.readStringOrNull(offsets[1]) ?? '',
    color: reader.readStringOrNull(offsets[2]) ?? '',
    correctAnswer: reader.readStringOrNull(offsets[3]) ?? '',
    defaultValue: reader.readStringOrNull(offsets[4]) ?? '',
    direction: reader.readStringOrNull(offsets[5]) ?? '',
    editable: reader.readStringOrNull(offsets[6]) ?? '',
    fontSize: reader.readStringOrNull(offsets[7]) ?? '',
    height: reader.readStringOrNull(offsets[8]) ?? '',
    maxWidth: reader.readStringOrNull(offsets[9]) ?? '',
    name: reader.readStringOrNull(offsets[10]) ?? '',
    points: reader.readStringOrNull(offsets[11]) ?? '',
    type: reader.readStringOrNull(offsets[12]) ?? '',
    width: reader.readStringOrNull(offsets[13]) ?? '',
    xPosition: reader.readStringOrNull(offsets[14]) ?? '',
    yPosition: reader.readStringOrNull(offsets[15]) ?? '',
  );
  return object;
}

P _customQuizQuestionsFieldsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 8:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 9:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 10:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 11:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 12:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 13:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 14:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 15:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CustomQuizQuestionsFieldsQueryFilter on QueryBuilder<
    CustomQuizQuestionsFields, CustomQuizQuestionsFields, QFilterCondition> {
  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> backgroundEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> backgroundGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> backgroundLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> backgroundBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'background',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> backgroundStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> backgroundEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      backgroundContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      backgroundMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'background',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> backgroundIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'background',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> backgroundIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'background',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> boldEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bold',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> boldGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bold',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> boldLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bold',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> boldBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bold',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> boldStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bold',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> boldEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bold',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      boldContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bold',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      boldMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bold',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> boldIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bold',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> boldIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bold',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> colorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> colorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> colorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> colorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> colorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> colorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      colorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      colorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'color',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> colorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> colorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> correctAnswerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'correct_answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> correctAnswerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'correct_answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> correctAnswerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'correct_answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> correctAnswerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'correct_answer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> correctAnswerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'correct_answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> correctAnswerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'correct_answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      correctAnswerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'correct_answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      correctAnswerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'correct_answer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> correctAnswerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'correct_answer',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> correctAnswerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'correct_answer',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> defaultValueEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'default_value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> defaultValueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'default_value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> defaultValueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'default_value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> defaultValueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'default_value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> defaultValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'default_value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> defaultValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'default_value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      defaultValueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'default_value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      defaultValueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'default_value',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> defaultValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'default_value',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> defaultValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'default_value',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> directionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> directionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> directionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> directionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'direction',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> directionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> directionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      directionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      directionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'direction',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> directionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'direction',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> directionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'direction',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> editableEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editable',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> editableGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'editable',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> editableLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'editable',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> editableBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'editable',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> editableStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'editable',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> editableEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'editable',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      editableContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'editable',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      editableMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'editable',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> editableIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editable',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> editableIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'editable',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> fontSizeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'font_size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> fontSizeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'font_size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> fontSizeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'font_size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> fontSizeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'font_size',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> fontSizeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'font_size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> fontSizeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'font_size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      fontSizeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'font_size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      fontSizeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'font_size',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> fontSizeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'font_size',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> fontSizeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'font_size',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> heightEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> heightGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> heightLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> heightBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'height',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> heightStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> heightEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      heightContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      heightMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'height',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> heightIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'height',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> heightIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'height',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> maxWidthEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'max_width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> maxWidthGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'max_width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> maxWidthLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'max_width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> maxWidthBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'max_width',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> maxWidthStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'max_width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> maxWidthEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'max_width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      maxWidthContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'max_width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      maxWidthMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'max_width',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> maxWidthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'max_width',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> maxWidthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'max_width',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> nameBetween(
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

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> pointsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'points',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> pointsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'points',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> pointsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'points',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> pointsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'points',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> pointsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'points',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> pointsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'points',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      pointsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'points',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      pointsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'points',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> pointsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'points',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> pointsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'points',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> widthEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> widthGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> widthLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> widthBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'width',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> widthStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> widthEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      widthContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'width',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      widthMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'width',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> widthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'width',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> widthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'width',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> xPositionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'x_position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> xPositionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'x_position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> xPositionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'x_position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> xPositionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'x_position',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> xPositionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'x_position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> xPositionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'x_position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      xPositionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'x_position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      xPositionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'x_position',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> xPositionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'x_position',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> xPositionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'x_position',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> yPositionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'y_position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> yPositionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'y_position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> yPositionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'y_position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> yPositionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'y_position',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> yPositionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'y_position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> yPositionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'y_position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      yPositionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'y_position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
          QAfterFilterCondition>
      yPositionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'y_position',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> yPositionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'y_position',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomQuizQuestionsFields, CustomQuizQuestionsFields,
      QAfterFilterCondition> yPositionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'y_position',
        value: '',
      ));
    });
  }
}

extension CustomQuizQuestionsFieldsQueryObject on QueryBuilder<
    CustomQuizQuestionsFields, CustomQuizQuestionsFields, QFilterCondition> {}
