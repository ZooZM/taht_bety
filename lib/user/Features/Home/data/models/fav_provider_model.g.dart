// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_provider_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavProviderModelAdapter extends TypeAdapter<FavProviderModel> {
  @override
  final int typeId = 3;

  @override
  FavProviderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavProviderModel(
      id: fields[0] as String,
      name: fields[1] as String,
      providerType: fields[2] as String,
      imageUrl: fields[3] as String,
      distance: fields[4] as double,
      reviewsCount: fields[5] as int,
      avgRating: fields[6] as double,
      isOnline: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FavProviderModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.providerType)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.distance)
      ..writeByte(5)
      ..write(obj.reviewsCount)
      ..writeByte(6)
      ..write(obj.avgRating)
      ..writeByte(7)
      ..write(obj.isOnline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavProviderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
