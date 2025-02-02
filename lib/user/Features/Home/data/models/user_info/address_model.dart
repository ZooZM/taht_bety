import 'package:hive/hive.dart';

part 'address_model.g.dart';

@HiveType(typeId: 0)
class AddressModel extends HiveObject {
  @HiveField(0)
  final String address;
  @HiveField(1)
  final double latitude;

  @HiveField(2)
  final double longitude;

  AddressModel(this.address, this.latitude, this.longitude);
}
