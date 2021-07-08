import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'dados_record.g.dart';

abstract class DadosRecord implements Built<DadosRecord, DadosRecordBuilder> {
  static Serializer<DadosRecord> get serializer => _$dadosRecordSerializer;

  @nullable
  double get soma1;

  @nullable
  double get soma2;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(DadosRecordBuilder builder) => builder
    ..soma1 = 0.0
    ..soma2 = 0.0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('dados');

  static Stream<DadosRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  DadosRecord._();
  factory DadosRecord([void Function(DadosRecordBuilder) updates]) =
      _$DadosRecord;

  static DadosRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createDadosRecordData({
  double soma1,
  double soma2,
}) =>
    serializers.toFirestore(
        DadosRecord.serializer,
        DadosRecord((d) => d
          ..soma1 = soma1
          ..soma2 = soma2));
