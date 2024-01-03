// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerHiveAdapter extends TypeAdapter<CustomerHive> {
  @override
  final int typeId = 0;

  @override
  CustomerHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerHive(
      id: fields[0] as String,
      witnessId: fields[1] as String?,
      firstname: fields[2] as String,
      lastname: fields[3] as String,
      phone: fields[4] as String,
      image: fields[5] as String,
      online: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.witnessId)
      ..writeByte(2)
      ..write(obj.firstname)
      ..writeByte(3)
      ..write(obj.lastname)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.online);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
