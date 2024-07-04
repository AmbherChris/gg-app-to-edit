// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plants.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlantAdapter extends TypeAdapter<Plant> {
  @override
  final int typeId = 1;

  @override
  Plant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Plant(
      eng_name: fields[0] as String? ?? '',
      tag_name: fields[1] as String? ?? '',
      sci_name: fields[2] as String? ?? '',
      description: fields[3] as String? ?? '',
      image_path: fields[4] as String? ?? '',
      uses: fields[5] as String? ?? '',
      benefits: fields[6] as String? ?? '',
      process: fields[7] as String? ?? '',
    );
  }

  @override
  void write(BinaryWriter writer, Plant obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.eng_name)
      ..writeByte(1)
      ..write(obj.tag_name)
      ..writeByte(2)
      ..write(obj.sci_name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.image_path)
      ..writeByte(5)
      ..write(obj.uses)
      ..writeByte(6)
      ..write(obj.benefits)
      ..writeByte(7)
      ..write(obj.process);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
