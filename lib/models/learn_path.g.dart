// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_path.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLearnPathCollection on Isar {
  IsarCollection<LearnPath> get learnPaths => this.collection();
}

const LearnPathSchema = CollectionSchema(
  name: r'LearnPath',
  id: 7142771665580081608,
  properties: {
    r'color': PropertySchema(
      id: 0,
      name: r'color',
      type: IsarType.string,
    ),
    r'courses': PropertySchema(
      id: 1,
      name: r'courses',
      type: IsarType.longList,
    ),
    r'iconPath': PropertySchema(
      id: 2,
      name: r'iconPath',
      type: IsarType.string,
    ),
    r'isOpen': PropertySchema(
      id: 3,
      name: r'isOpen',
      type: IsarType.bool,
    ),
    r'title': PropertySchema(
      id: 4,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _learnPathEstimateSize,
  serialize: _learnPathSerialize,
  deserialize: _learnPathDeserialize,
  deserializeProp: _learnPathDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'coursesPath': LinkSchema(
      id: -7945898579022792261,
      name: r'coursesPath',
      target: r'Course',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _learnPathGetId,
  getLinks: _learnPathGetLinks,
  attach: _learnPathAttach,
  version: '3.1.0+1',
);

int _learnPathEstimateSize(
  LearnPath object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.color.length * 3;
  bytesCount += 3 + object.coursesIds.length * 8;
  {
    final value = object.iconPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _learnPathSerialize(
  LearnPath object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.color);
  writer.writeLongList(offsets[1], object.coursesIds);
  writer.writeString(offsets[2], object.iconPath);
  writer.writeBool(offsets[3], object.isOpen);
  writer.writeString(offsets[4], object.title);
}

LearnPath _learnPathDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LearnPath(
    color: reader.readStringOrNull(offsets[0]) ?? '',
    coursesIds: reader.readLongList(offsets[1]) ?? const [],
    iconPath: reader.readStringOrNull(offsets[2]),
    id: id,
    title: reader.readStringOrNull(offsets[4]) ?? '',
  );
  object.isOpen = reader.readBool(offsets[3]);
  return object;
}

P _learnPathDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readLongList(offset) ?? const []) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _learnPathGetId(LearnPath object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _learnPathGetLinks(LearnPath object) {
  return [object.coursesPath];
}

void _learnPathAttach(IsarCollection<dynamic> col, Id id, LearnPath object) {
  object.id = id;
  object.coursesPath
      .attach(col, col.isar.collection<Course>(), r'coursesPath', id);
}

extension LearnPathQueryWhereSort
    on QueryBuilder<LearnPath, LearnPath, QWhere> {
  QueryBuilder<LearnPath, LearnPath, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LearnPathQueryWhere
    on QueryBuilder<LearnPath, LearnPath, QWhereClause> {
  QueryBuilder<LearnPath, LearnPath, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<LearnPath, LearnPath, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterWhereClause> idBetween(
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

extension LearnPathQueryFilter
    on QueryBuilder<LearnPath, LearnPath, QFilterCondition> {
  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> colorEqualTo(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> colorGreaterThan(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> colorLessThan(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> colorBetween(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> colorStartsWith(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> colorEndsWith(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> colorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> colorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'color',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> colorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> colorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      coursesIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'courses',
        value: value,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      coursesIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'courses',
        value: value,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      coursesIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'courses',
        value: value,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      coursesIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'courses',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      coursesIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'courses',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      coursesIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'courses',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      coursesIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'courses',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      coursesIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'courses',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      coursesIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'courses',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      coursesIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'courses',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> iconPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'iconPath',
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      iconPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'iconPath',
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> iconPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> iconPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> iconPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> iconPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> iconPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'iconPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> iconPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'iconPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> iconPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'iconPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> iconPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'iconPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> iconPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconPath',
        value: '',
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      iconPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'iconPath',
        value: '',
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> idBetween(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> isOpenEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOpen',
        value: value,
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> titleEqualTo(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> titleGreaterThan(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> titleLessThan(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> titleBetween(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> titleStartsWith(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> titleEndsWith(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> titleContains(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> titleMatches(
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

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension LearnPathQueryObject
    on QueryBuilder<LearnPath, LearnPath, QFilterCondition> {}

extension LearnPathQueryLinks
    on QueryBuilder<LearnPath, LearnPath, QFilterCondition> {
  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition> coursesPath(
      FilterQuery<Course> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'coursesPath');
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      coursesPathLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'coursesPath', length, true, length, true);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      coursesPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'coursesPath', 0, true, 0, true);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      coursesPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'coursesPath', 0, false, 999999, true);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      coursesPathLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'coursesPath', 0, true, length, include);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      coursesPathLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'coursesPath', length, include, 999999, true);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterFilterCondition>
      coursesPathLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'coursesPath', lower, includeLower, upper, includeUpper);
    });
  }
}

extension LearnPathQuerySortBy on QueryBuilder<LearnPath, LearnPath, QSortBy> {
  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> sortByIconPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconPath', Sort.asc);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> sortByIconPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconPath', Sort.desc);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> sortByIsOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOpen', Sort.asc);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> sortByIsOpenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOpen', Sort.desc);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension LearnPathQuerySortThenBy
    on QueryBuilder<LearnPath, LearnPath, QSortThenBy> {
  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> thenByIconPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconPath', Sort.asc);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> thenByIconPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconPath', Sort.desc);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> thenByIsOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOpen', Sort.asc);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> thenByIsOpenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOpen', Sort.desc);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension LearnPathQueryWhereDistinct
    on QueryBuilder<LearnPath, LearnPath, QDistinct> {
  QueryBuilder<LearnPath, LearnPath, QDistinct> distinctByColor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QDistinct> distinctByCoursesIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'courses');
    });
  }

  QueryBuilder<LearnPath, LearnPath, QDistinct> distinctByIconPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LearnPath, LearnPath, QDistinct> distinctByIsOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOpen');
    });
  }

  QueryBuilder<LearnPath, LearnPath, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension LearnPathQueryProperty
    on QueryBuilder<LearnPath, LearnPath, QQueryProperty> {
  QueryBuilder<LearnPath, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LearnPath, String, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<LearnPath, List<int>, QQueryOperations> coursesIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'courses');
    });
  }

  QueryBuilder<LearnPath, String?, QQueryOperations> iconPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconPath');
    });
  }

  QueryBuilder<LearnPath, bool, QQueryOperations> isOpenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOpen');
    });
  }

  QueryBuilder<LearnPath, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
