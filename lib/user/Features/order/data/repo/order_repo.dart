import 'package:dartz/dartz.dart';
import 'package:taht_bety/core/errors/failures.dart';
import 'package:taht_bety/user/Features/order/data/models/order_model/order_model.dart';

abstract class OrderRepo {
  Future<Either<Failure, List<OrderModel>>> fetchUserOrders();
}
