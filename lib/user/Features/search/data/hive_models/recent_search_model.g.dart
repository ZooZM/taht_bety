// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_search_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentSearchModelAdapter extends TypeAdapter<RecentSearchModel> {
  @override
  final int typeId = 1;

  @override
  RecentSearchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentSearchModel(
      id: fields[0] as int,
      name: fields[1] as String,
      timestamp: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RecentSearchModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentSearchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
