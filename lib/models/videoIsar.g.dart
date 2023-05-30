// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videoIsar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVideoIsarCollection on Isar {
  IsarCollection<VideoIsar> get videoIsars => this.collection();
}

const VideoIsarSchema = CollectionSchema(
  name: r'VideoIsar',
  id: 2185217824995906155,
  properties: {
    r'downloadLink': PropertySchema(
      id: 0,
      name: r'downloadLink',
      type: IsarType.string,
    ),
    r'expiredDate': PropertySchema(
      id: 1,
      name: r'expiredDate',
      type: IsarType.long,
    ),
    r'isDownload': PropertySchema(
      id: 2,
      name: r'isDownload',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _videoIsarEstimateSize,
  serialize: _videoIsarSerialize,
  deserialize: _videoIsarDeserialize,
  deserializeProp: _videoIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _videoIsarGetId,
  getLinks: _videoIsarGetLinks,
  attach: _videoIsarAttach,
  version: '3.1.0+1',
);

int _videoIsarEstimateSize(
  VideoIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.downloadLink.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _videoIsarSerialize(
  VideoIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.downloadLink);
  writer.writeLong(offsets[1], object.expiredDate);
  writer.writeBool(offsets[2], object.isDownload);
  writer.writeString(offsets[3], object.name);
}

VideoIsar _videoIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VideoIsar();
  object.downloadLink = reader.readString(offsets[0]);
  object.expiredDate = reader.readLong(offsets[1]);
  object.id = id;
  object.isDownload = reader.readBool(offsets[2]);
  object.name = reader.readString(offsets[3]);
  return object;
}

P _videoIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _videoIsarGetId(VideoIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _videoIsarGetLinks(VideoIsar object) {
  return [];
}

void _videoIsarAttach(IsarCollection<dynamic> col, Id id, VideoIsar object) {
  object.id = id;
}

extension VideoIsarQueryWhereSort
    on QueryBuilder<VideoIsar, VideoIsar, QWhere> {
  QueryBuilder<VideoIsar, VideoIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VideoIsarQueryWhere
    on QueryBuilder<VideoIsar, VideoIsar, QWhereClause> {
  QueryBuilder<VideoIsar, VideoIsar, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterWhereClause> idBetween(
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

extension VideoIsarQueryFilter
    on QueryBuilder<VideoIsar, VideoIsar, QFilterCondition> {
  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> downloadLinkEqualTo(
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition>
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition>
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> downloadLinkBetween(
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition>
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition>
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition>
      downloadLinkContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'downloadLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> downloadLinkMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'downloadLink',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition>
      downloadLinkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'downloadLink',
        value: '',
      ));
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition>
      downloadLinkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'downloadLink',
        value: '',
      ));
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> expiredDateEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expiredDate',
        value: value,
      ));
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition>
      expiredDateGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expiredDate',
        value: value,
      ));
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> expiredDateLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expiredDate',
        value: value,
      ));
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> expiredDateBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expiredDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> idBetween(
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> isDownloadEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDownload',
        value: value,
      ));
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> nameContains(
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension VideoIsarQueryObject
    on QueryBuilder<VideoIsar, VideoIsar, QFilterCondition> {}

extension VideoIsarQueryLinks
    on QueryBuilder<VideoIsar, VideoIsar, QFilterCondition> {}

extension VideoIsarQuerySortBy on QueryBuilder<VideoIsar, VideoIsar, QSortBy> {
  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> sortByDownloadLink() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadLink', Sort.asc);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> sortByDownloadLinkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadLink', Sort.desc);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> sortByExpiredDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiredDate', Sort.asc);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> sortByExpiredDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiredDate', Sort.desc);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> sortByIsDownload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownload', Sort.asc);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> sortByIsDownloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownload', Sort.desc);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension VideoIsarQuerySortThenBy
    on QueryBuilder<VideoIsar, VideoIsar, QSortThenBy> {
  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> thenByDownloadLink() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadLink', Sort.asc);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> thenByDownloadLinkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadLink', Sort.desc);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> thenByExpiredDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiredDate', Sort.asc);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> thenByExpiredDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiredDate', Sort.desc);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> thenByIsDownload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownload', Sort.asc);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> thenByIsDownloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownload', Sort.desc);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension VideoIsarQueryWhereDistinct
    on QueryBuilder<VideoIsar, VideoIsar, QDistinct> {
  QueryBuilder<VideoIsar, VideoIsar, QDistinct> distinctByDownloadLink(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'downloadLink', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QDistinct> distinctByExpiredDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expiredDate');
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QDistinct> distinctByIsDownload() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDownload');
    });
  }

  QueryBuilder<VideoIsar, VideoIsar, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension VideoIsarQueryProperty
    on QueryBuilder<VideoIsar, VideoIsar, QQueryProperty> {
  QueryBuilder<VideoIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<VideoIsar, String, QQueryOperations> downloadLinkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'downloadLink');
    });
  }

  QueryBuilder<VideoIsar, int, QQueryOperations> expiredDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expiredDate');
    });
  }

  QueryBuilder<VideoIsar, bool, QQueryOperations> isDownloadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDownload');
    });
  }

  QueryBuilder<VideoIsar, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
