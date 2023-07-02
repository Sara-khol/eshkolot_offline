// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionnaire.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuestionnaireCollection on Isar {
  IsarCollection<Questionnaire> get questionnaires => this.collection();
}

const QuestionnaireSchema = CollectionSchema(
  name: r'Questionnaire',
  id: 6720444494120334047,
  properties: {
    r'ans': PropertySchema(
      id: 0,
      name: r'ans',
      type: IsarType.stringList,
    ),
    r'fillInQuestion': PropertySchema(
      id: 1,
      name: r'fillInQuestion',
      type: IsarType.string,
    ),
    r'isComplete': PropertySchema(
      id: 2,
      name: r'isComplete',
      type: IsarType.bool,
    ),
    r'options': PropertySchema(
      id: 3,
      name: r'options',
      type: IsarType.stringList,
    ),
    r'question': PropertySchema(
      id: 4,
      name: r'question',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 5,
      name: r'type',
      type: IsarType.byte,
      enumMap: _QuestionnairetypeEnumValueMap,
    )
  },
  estimateSize: _questionnaireEstimateSize,
  serialize: _questionnaireSerialize,
  deserialize: _questionnaireDeserialize,
  deserializeProp: _questionnaireDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _questionnaireGetId,
  getLinks: _questionnaireGetLinks,
  attach: _questionnaireAttach,
  version: '3.1.0+1',
);

int _questionnaireEstimateSize(
  Questionnaire object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.ans;
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
  {
    final value = object.fillInQuestion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
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
  return bytesCount;
}

void _questionnaireSerialize(
  Questionnaire object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.ans);
  writer.writeString(offsets[1], object.fillInQuestion);
  writer.writeBool(offsets[2], object.isComplete);
  writer.writeStringList(offsets[3], object.options);
  writer.writeString(offsets[4], object.question);
  writer.writeByte(offsets[5], object.type.index);
}

Questionnaire _questionnaireDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Questionnaire();
  object.ans = reader.readStringList(offsets[0]);
  object.fillInQuestion = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.isComplete = reader.readBool(offsets[2]);
  object.options = reader.readStringList(offsets[3]);
  object.question = reader.readString(offsets[4]);
  object.type =
      _QuestionnairetypeValueEnumMap[reader.readByteOrNull(offsets[5])] ??
          QType.radio;
  return object;
}

P _questionnaireDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readStringList(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (_QuestionnairetypeValueEnumMap[reader.readByteOrNull(offset)] ??
          QType.radio) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _QuestionnairetypeEnumValueMap = {
  'radio': 0,
  'checkbox': 1,
  'fillIn': 2,
  'freeChoice': 3,
  'openQ': 4,
};
const _QuestionnairetypeValueEnumMap = {
  0: QType.radio,
  1: QType.checkbox,
  2: QType.fillIn,
  3: QType.freeChoice,
  4: QType.openQ,
};

Id _questionnaireGetId(Questionnaire object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _questionnaireGetLinks(Questionnaire object) {
  return [];
}

void _questionnaireAttach(
    IsarCollection<dynamic> col, Id id, Questionnaire object) {
  object.id = id;
}

extension QuestionnaireQueryWhereSort
    on QueryBuilder<Questionnaire, Questionnaire, QWhere> {
  QueryBuilder<Questionnaire, Questionnaire, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension QuestionnaireQueryWhere
    on QueryBuilder<Questionnaire, Questionnaire, QWhereClause> {
  QueryBuilder<Questionnaire, Questionnaire, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterWhereClause> idBetween(
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

extension QuestionnaireQueryFilter
    on QueryBuilder<Questionnaire, Questionnaire, QFilterCondition> {
  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ans',
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ans',
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansElementEqualTo(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansElementGreaterThan(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansElementLessThan(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansElementBetween(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansElementStartsWith(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansElementEndsWith(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ans',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ans',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ans',
        value: '',
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ans',
        value: '',
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansLengthEqualTo(int length) {
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansIsEmpty() {
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansIsNotEmpty() {
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansLengthLessThan(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansLengthGreaterThan(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      ansLengthBetween(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      fillInQuestionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fillInQuestion',
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      fillInQuestionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fillInQuestion',
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      fillInQuestionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fillInQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      fillInQuestionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fillInQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      fillInQuestionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fillInQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      fillInQuestionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fillInQuestion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      fillInQuestionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fillInQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      fillInQuestionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fillInQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      fillInQuestionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fillInQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      fillInQuestionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fillInQuestion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      fillInQuestionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fillInQuestion',
        value: '',
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      fillInQuestionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fillInQuestion',
        value: '',
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      isCompleteEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isComplete',
        value: value,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      optionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'options',
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      optionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'options',
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      optionsElementEqualTo(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      optionsElementBetween(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      optionsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'options',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      optionsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'options',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      optionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'options',
        value: '',
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      optionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'options',
        value: '',
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      optionsLengthEqualTo(int length) {
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      optionsIsEmpty() {
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      optionsIsNotEmpty() {
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      optionsLengthLessThan(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      optionsLengthBetween(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      questionEqualTo(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      questionGreaterThan(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      questionLessThan(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      questionBetween(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      questionStartsWith(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      questionEndsWith(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      questionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      questionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'question',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      questionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: '',
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      questionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'question',
        value: '',
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition> typeEqualTo(
      QType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      typeGreaterThan(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition>
      typeLessThan(
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

  QueryBuilder<Questionnaire, Questionnaire, QAfterFilterCondition> typeBetween(
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

extension QuestionnaireQueryObject
    on QueryBuilder<Questionnaire, Questionnaire, QFilterCondition> {}

extension QuestionnaireQueryLinks
    on QueryBuilder<Questionnaire, Questionnaire, QFilterCondition> {}

extension QuestionnaireQuerySortBy
    on QueryBuilder<Questionnaire, Questionnaire, QSortBy> {
  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy>
      sortByFillInQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fillInQuestion', Sort.asc);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy>
      sortByFillInQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fillInQuestion', Sort.desc);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy> sortByIsComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isComplete', Sort.asc);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy>
      sortByIsCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isComplete', Sort.desc);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy> sortByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy>
      sortByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension QuestionnaireQuerySortThenBy
    on QueryBuilder<Questionnaire, Questionnaire, QSortThenBy> {
  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy>
      thenByFillInQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fillInQuestion', Sort.asc);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy>
      thenByFillInQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fillInQuestion', Sort.desc);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy> thenByIsComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isComplete', Sort.asc);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy>
      thenByIsCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isComplete', Sort.desc);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy> thenByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy>
      thenByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension QuestionnaireQueryWhereDistinct
    on QueryBuilder<Questionnaire, Questionnaire, QDistinct> {
  QueryBuilder<Questionnaire, Questionnaire, QDistinct> distinctByAns() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ans');
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QDistinct>
      distinctByFillInQuestion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fillInQuestion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QDistinct> distinctByIsComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isComplete');
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QDistinct> distinctByOptions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'options');
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QDistinct> distinctByQuestion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'question', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Questionnaire, Questionnaire, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }
}

extension QuestionnaireQueryProperty
    on QueryBuilder<Questionnaire, Questionnaire, QQueryProperty> {
  QueryBuilder<Questionnaire, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Questionnaire, List<String>?, QQueryOperations> ansProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ans');
    });
  }

  QueryBuilder<Questionnaire, String?, QQueryOperations>
      fillInQuestionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fillInQuestion');
    });
  }

  QueryBuilder<Questionnaire, bool, QQueryOperations> isCompleteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isComplete');
    });
  }

  QueryBuilder<Questionnaire, List<String>?, QQueryOperations>
      optionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'options');
    });
  }

  QueryBuilder<Questionnaire, String, QQueryOperations> questionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'question');
    });
  }

  QueryBuilder<Questionnaire, QType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

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
    r'isCurrect': PropertySchema(
      id: 1,
      name: r'isCurrect',
      type: IsarType.bool,
    ),
    r'points': PropertySchema(
      id: 2,
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
  return bytesCount;
}

void _answerSerialize(
  Answer object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ans);
  writer.writeBool(offsets[1], object.isCorrect);
  writer.writeLong(offsets[2], object.points);
}

Answer _answerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Answer();
  object.ans = reader.readString(offsets[0]);
  object.isCorrect = reader.readBool(offsets[1]);
  object.points = reader.readLong(offsets[2]);
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
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
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

  QueryBuilder<Answer, Answer, QAfterFilterCondition> isCorrectEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCurrect',
        value: value,
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
