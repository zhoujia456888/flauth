// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'model/totp_model/totp_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
    id: const obx_int.IdUid(1, 8599485004592482975),
    name: 'TotpModel',
    lastPropertyId: const obx_int.IdUid(9, 4066727812363617999),
    flags: 0,
    properties: <obx_int.ModelProperty>[
      obx_int.ModelProperty(
        id: const obx_int.IdUid(1, 2777710503610864943),
        name: 'id',
        type: 6,
        flags: 1,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(2, 5349102337987176663),
        name: 'issuer',
        type: 9,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(3, 7489863144662593503),
        name: 'userName',
        type: 9,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(4, 5892496739034583907),
        name: 'secret',
        type: 9,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(5, 5881787188643552453),
        name: 'code',
        type: 9,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(6, 4801064722367049470),
        name: 'isShow',
        type: 1,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(7, 3337977237369376304),
        name: 'iconPath',
        type: 9,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(8, 5042624379654589406),
        name: 'countdownTime',
        type: 8,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(9, 4066727812363617999),
        name: 'initialTime',
        type: 8,
        flags: 0,
      ),
    ],
    relations: <obx_int.ModelRelation>[],
    backlinks: <obx_int.ModelBacklink>[],
  ),
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore({
  String? directory,
  int? maxDBSizeInKB,
  int? maxDataSizeInKB,
  int? fileMode,
  int? maxReaders,
  bool queriesCaseSensitiveDefault = true,
  String? macosApplicationGroup,
}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(
    getObjectBoxModel(),
    directory: directory ?? (await defaultStoreDirectory()).path,
    maxDBSizeInKB: maxDBSizeInKB,
    maxDataSizeInKB: maxDataSizeInKB,
    fileMode: fileMode,
    maxReaders: maxReaders,
    queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
    macosApplicationGroup: macosApplicationGroup,
  );
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
    entities: _entities,
    lastEntityId: const obx_int.IdUid(1, 8599485004592482975),
    lastIndexId: const obx_int.IdUid(0, 0),
    lastRelationId: const obx_int.IdUid(0, 0),
    lastSequenceId: const obx_int.IdUid(0, 0),
    retiredEntityUids: const [],
    retiredIndexUids: const [],
    retiredPropertyUids: const [],
    retiredRelationUids: const [],
    modelVersion: 5,
    modelVersionParserMinimum: 5,
    version: 1,
  );

  final bindings = <Type, obx_int.EntityDefinition>{
    TotpModel: obx_int.EntityDefinition<TotpModel>(
      model: _entities[0],
      toOneRelations: (TotpModel object) => [],
      toManyRelations: (TotpModel object) => {},
      getId: (TotpModel object) => object.id,
      setId: (TotpModel object, int id) {
        object.id = id;
      },
      objectToFB: (TotpModel object, fb.Builder fbb) {
        final issuerOffset = object.issuer == null
            ? null
            : fbb.writeString(object.issuer!);
        final userNameOffset = object.userName == null
            ? null
            : fbb.writeString(object.userName!);
        final secretOffset = object.secret == null
            ? null
            : fbb.writeString(object.secret!);
        final codeOffset = object.code == null
            ? null
            : fbb.writeString(object.code!);
        final iconPathOffset = object.iconPath == null
            ? null
            : fbb.writeString(object.iconPath!);
        fbb.startTable(10);
        fbb.addInt64(0, object.id ?? 0);
        fbb.addOffset(1, issuerOffset);
        fbb.addOffset(2, userNameOffset);
        fbb.addOffset(3, secretOffset);
        fbb.addOffset(4, codeOffset);
        fbb.addBool(5, object.isShow);
        fbb.addOffset(6, iconPathOffset);
        fbb.addFloat64(7, object.countdownTime);
        fbb.addFloat64(8, object.initialTime);
        fbb.finish(fbb.endTable());
        return object.id ?? 0;
      },
      objectFromFB: (obx.Store store, ByteData fbData) {
        final buffer = fb.BufferContext(fbData);
        final rootOffset = buffer.derefObject(0);

        final object = TotpModel()
          ..id = const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4)
          ..issuer = const fb.StringReader(
            asciiOptimization: true,
          ).vTableGetNullable(buffer, rootOffset, 6)
          ..userName = const fb.StringReader(
            asciiOptimization: true,
          ).vTableGetNullable(buffer, rootOffset, 8)
          ..secret = const fb.StringReader(
            asciiOptimization: true,
          ).vTableGetNullable(buffer, rootOffset, 10)
          ..code = const fb.StringReader(
            asciiOptimization: true,
          ).vTableGetNullable(buffer, rootOffset, 12)
          ..isShow = const fb.BoolReader().vTableGetNullable(
            buffer,
            rootOffset,
            14,
          )
          ..iconPath = const fb.StringReader(
            asciiOptimization: true,
          ).vTableGetNullable(buffer, rootOffset, 16)
          ..countdownTime = const fb.Float64Reader().vTableGetNullable(
            buffer,
            rootOffset,
            18,
          )
          ..initialTime = const fb.Float64Reader().vTableGetNullable(
            buffer,
            rootOffset,
            20,
          );

        return object;
      },
    ),
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [TotpModel] entity fields to define ObjectBox queries.
class TotpModel_ {
  /// See [TotpModel.id].
  static final id = obx.QueryIntegerProperty<TotpModel>(
    _entities[0].properties[0],
  );

  /// See [TotpModel.issuer].
  static final issuer = obx.QueryStringProperty<TotpModel>(
    _entities[0].properties[1],
  );

  /// See [TotpModel.userName].
  static final userName = obx.QueryStringProperty<TotpModel>(
    _entities[0].properties[2],
  );

  /// See [TotpModel.secret].
  static final secret = obx.QueryStringProperty<TotpModel>(
    _entities[0].properties[3],
  );

  /// See [TotpModel.code].
  static final code = obx.QueryStringProperty<TotpModel>(
    _entities[0].properties[4],
  );

  /// See [TotpModel.isShow].
  static final isShow = obx.QueryBooleanProperty<TotpModel>(
    _entities[0].properties[5],
  );

  /// See [TotpModel.iconPath].
  static final iconPath = obx.QueryStringProperty<TotpModel>(
    _entities[0].properties[6],
  );

  /// See [TotpModel.countdownTime].
  static final countdownTime = obx.QueryDoubleProperty<TotpModel>(
    _entities[0].properties[7],
  );

  /// See [TotpModel.initialTime].
  static final initialTime = obx.QueryDoubleProperty<TotpModel>(
    _entities[0].properties[8],
  );
}
