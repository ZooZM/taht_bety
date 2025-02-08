// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curuser.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurUserAdapter extends TypeAdapter<CurUser> {
  @override
  final int typeId = 0;

  @override
  CurUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurUser(
      token: fields[0] as String,
      userId: fields[1] as String,
      lat: fields[2] as String,
      long: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurUser obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.lat)
      ..writeByte(3)
      ..write(obj.long);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
