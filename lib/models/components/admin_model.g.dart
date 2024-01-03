// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdminHiveAdapter extends TypeAdapter<AdminHive> {
  @override
  final int typeId = 0;

  @override
  AdminHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdminHive(
      id: fields[0] as String,
      firstname: fields[1] as String,
      lastname: fields[2] as String,
      phone: fields[3] as String,
      image: fields[4] as String,
      online: fields[6] as bool,
      status: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AdminHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstname)
      ..writeByte(2)
      ..write(obj.lastname)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.online);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
