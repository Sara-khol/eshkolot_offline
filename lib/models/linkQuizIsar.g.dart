// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linkQuizIsar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLinkQuizIsarCollection on Isar {
  IsarCollection<LinkQuizIsar> get linkQuizIsars => this.collection();
}

const LinkQuizIsarSchema = CollectionSchema(
  name: r'LinkQuizIsar',
  id: 3259590703471979577,
  properties: {
    r'courseId': PropertySchema(
      id: 0,
      name: r'courseId',
      type: IsarType.long,
    ),
    r'downloadLink': PropertySchema(
      id: 1,
      name: r'downloadLink',
      type: IsarType.string,
    ),
    r'isBlock': PropertySchema(
      id: 2,
      name: r'isBlock',
      type: IsarType.bool,
    ),
    r'isDownload': PropertySchema(
      id: 3,
      name: r'isDownload',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'quizId': PropertySchema(
      id: 5,
      name: r'quizId',
      type: IsarType.long,
    )
  },
  estimateSize: _linkQuizIsarEstimateSize,
  serialize: _linkQuizIsarSerialize,
  deserialize: _linkQuizIsarDeserialize,
  deserializeProp: _linkQuizIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _linkQuizIsarGetId,
  getLinks: _linkQuizIsarGetLinks,
  attach: _linkQuizIsarAttach,
  version: '3.1.0+1',
);

int _linkQuizIsarEstimateSize(
  LinkQuizIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.downloadLink.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _linkQuizIsarSerialize(
  LinkQuizIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.courseId);
  writer.writeString(offsets[1], object.downloadLink);
  writer.writeBool(offsets[2], object.isBlock);
  writer.writeBool(offsets[3], object.isDownload);
  writer.writeString(offsets[4], object.name);
  writer.writeLong(offsets[5], object.quizId);
}

LinkQuizIsar _linkQuizIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LinkQuizIsar();
  object.courseId = reader.readLong(offsets[0]);
  object.downloadLink = reader.readString(offsets[1]);
  object.id = id;
  object.isBlock = reader.readBool(offsets[2]);
  object.isDownload = reader.readBool(offsets[3]);
  object.name = reader.readString(offsets[4]);
  object.quizId = reader.readLong(offsets[5]);
  return object;
}

P _linkQuizIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _linkQuizIsarGetId(LinkQuizIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _linkQuizIsarGetLinks(LinkQuizIsar object) {
  return [];
}

void _linkQuizIsarAttach(
    IsarCollection<dynamic> col, Id id, LinkQuizIsar object) {
  object.id = id;
}

extension LinkQuizIsarQueryWhereSort
    on QueryBuilder<LinkQuizIsar, LinkQuizIsar, QWhere> {
  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LinkQuizIsarQueryWhere
    on QueryBuilder<LinkQuizIsar, LinkQuizIsar, QWhereClause> {
  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterWhereClause> idBetween(
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

extension LinkQuizIsarQueryFilter
    on QueryBuilder<LinkQuizIsar, LinkQuizIsar, QFilterCondition> {
  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      courseIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'courseId',
        value: value,
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
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

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      courseIdLessThan(
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

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      courseIdBetween(
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

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      downloadLinkEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'downloadLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      downloadLinkGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'downloadLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      downloadLinkLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'downloadLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      downloadLinkBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'downloadLink',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      downloadLinkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'downloadLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      downloadLinkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'downloadLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      downloadLinkContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'downloadLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      downloadLinkMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'downloadLink',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      downloadLinkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'downloadLink',
        value: '',
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      downloadLinkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'downloadLink',
        value: '',
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition> idBetween(
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

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      isBlockEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isBlock',
        value: value,
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      isDownloadEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDownload',
        value: value,
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      nameGreaterThan(
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

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      nameStartsWith(
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

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition> quizIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quizId',
        value: value,
      ));
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      quizIdGreaterThan(
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

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition>
      quizIdLessThan(
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

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterFilterCondition> quizIdBetween(
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
}

extension LinkQuizIsarQueryObject
    on QueryBuilder<LinkQuizIsar, LinkQuizIsar, QFilterCondition> {}

extension LinkQuizIsarQueryLinks
    on QueryBuilder<LinkQuizIsar, LinkQuizIsar, QFilterCondition> {}

extension LinkQuizIsarQuerySortBy
    on QueryBuilder<LinkQuizIsar, LinkQuizIsar, QSortBy> {
  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> sortByCourseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseId', Sort.asc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> sortByCourseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseId', Sort.desc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> sortByDownloadLink() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadLink', Sort.asc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy>
      sortByDownloadLinkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadLink', Sort.desc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> sortByIsBlock() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlock', Sort.asc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> sortByIsBlockDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlock', Sort.desc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> sortByIsDownload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownload', Sort.asc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy>
      sortByIsDownloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownload', Sort.desc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> sortByQuizId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quizId', Sort.asc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> sortByQuizIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quizId', Sort.desc);
    });
  }
}

extension LinkQuizIsarQuerySortThenBy
    on QueryBuilder<LinkQuizIsar, LinkQuizIsar, QSortThenBy> {
  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> thenByCourseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseId', Sort.asc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> thenByCourseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseId', Sort.desc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> thenByDownloadLink() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadLink', Sort.asc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy>
      thenByDownloadLinkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadLink', Sort.desc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> thenByIsBlock() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlock', Sort.asc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> thenByIsBlockDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlock', Sort.desc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> thenByIsDownload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownload', Sort.asc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy>
      thenByIsDownloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownload', Sort.desc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> thenByQuizId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quizId', Sort.asc);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QAfterSortBy> thenByQuizIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quizId', Sort.desc);
    });
  }
}

extension LinkQuizIsarQueryWhereDistinct
    on QueryBuilder<LinkQuizIsar, LinkQuizIsar, QDistinct> {
  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QDistinct> distinctByCourseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'courseId');
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QDistinct> distinctByDownloadLink(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'downloadLink', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QDistinct> distinctByIsBlock() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isBlock');
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QDistinct> distinctByIsDownload() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDownload');
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LinkQuizIsar, LinkQuizIsar, QDistinct> distinctByQuizId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quizId');
    });
  }
}

extension LinkQuizIsarQueryProperty
    on QueryBuilder<LinkQuizIsar, LinkQuizIsar, QQueryProperty> {
  QueryBuilder<LinkQuizIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LinkQuizIsar, int, QQueryOperations> courseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'courseId');
    });
  }

  QueryBuilder<LinkQuizIsar, String, QQueryOperations> downloadLinkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'downloadLink');
    });
  }

  QueryBuilder<LinkQuizIsar, bool, QQueryOperations> isBlockProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isBlock');
    });
  }

  QueryBuilder<LinkQuizIsar, bool, QQueryOperations> isDownloadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDownload');
    });
  }

  QueryBuilder<LinkQuizIsar, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<LinkQuizIsar, int, QQueryOperations> quizIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quizId');
    });
  }
}
