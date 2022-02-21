import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
part 'model.g.dart';

// This is where we define our tables:
const SqfEntityTable tableSkeds = SqfEntityTable(
    tableName: 'skeds',
    primaryKeyName: 'id',
    useSoftDeleting: false,
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    fields: [
      SqfEntityField('operator_name', DbType.text),
      SqfEntityField('client_name', DbType.text),
      SqfEntityField('work_type', DbType.integer),
      SqfEntityField('data_type', DbType.integer),
      SqfEntityField('created_at', DbType.datetime,
          defaultValue: 'DateTime.now()'),
      SqfEntityField('is_sended', DbType.bool, defaultValue: false),
      SqfEntityField('signature', DbType.blob, defaultValue: null),
    ]);

const SqfEntityTable tableSkedRows = SqfEntityTable(
    tableName: 'sked_rows',
    primaryKeyName: 'id',
    useSoftDeleting: false,
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    fields: [
      SqfEntityField('operator_name', DbType.text),
      SqfEntityField('sort', DbType.integer),
      SqfEntityField('sked_id', DbType.integer),
      SqfEntityFieldRelationship(
          parentTable: tableSkeds,
          relationType: RelationType.ONE_TO_MANY,
          deleteRule: DeleteRule.CASCADE,
          defaultValue: 0),
      SqfEntityField('data', DbType.text),
      SqfEntityField('created_at', DbType.datetime),
    ]);

const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);
// This is where we define our database:
@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
  modelName: 'MyAppDatabaseModel',
  databaseName: 'myapp-db.db',
  sequences: [seqIdentity],
  databaseTables: [tableSkeds, tableSkedRows],
);
