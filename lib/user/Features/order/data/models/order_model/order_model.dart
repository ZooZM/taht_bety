import 'appointment.dart';
import 'provider_id.dart';
import 'user_id.dart';

class OrderModel {
  Appointment? appointment;
  String? id;
  UserId? userId;
  ProviderId? providerId;
  List<String>? postId;
  String? description;
  String? status;
  int? price;
  int? v;

  OrderModel({
    this.appointment,
    this.id,
    this.userId,
    this.providerId,
    this.postId,
    this.description,
    this.status,
    this.price,
    this.v,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        appointment: json['appointment'] == null
            ? null
            : Appointment.fromJson(json['appointment'] as Map<String, dynamic>),
        id: json['_id'] as String?,
        userId: json['userID'] == null
            ? null
            : UserId.fromJson(json['userID'] as Map<String, dynamic>),
        providerId: json['providerID'] == null
            ? null
            : ProviderId.fromJson(json['providerID'] as Map<String, dynamic>),
        postId: json['postID'] != null
            ? (json['postID'] as List<dynamic>)
                .map((e) => e.toString())
                .toList()
            : null, // Ensure all elements are Strings
        description: json['description'] as String?,
        status: json['status'] as String?,
        price: json['price'] as int?,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'appointment': appointment?.toJson(),
        '_id': id,
        'userID': userId?.toJson(),
        'providerID': providerId?.toJson(),
        'postID': postId,
        'description': description,
        'status': status,
        'price': price,
        '__v': v,
      };
}
