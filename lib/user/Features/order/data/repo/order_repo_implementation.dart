import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taht_bety/auth/data/models/curuser.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/core/errors/failures.dart';
import 'package:taht_bety/core/utils/api_service.dart';
import 'package:taht_bety/user/Features/order/data/models/order_model/order_model.dart';
import 'package:taht_bety/user/Features/order/data/repo/order_repo.dart';

class OrderRepoImpl implements OrderRepo {
  final ApiService apiService;

  OrderRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<OrderModel>>> fetchUserOrders() async {
    try {
      // Get current user details
      CurUser user = UserStorage.getUserData();

      // Make API request
      var response = await apiService.get(
          token: user.token,
          endPoint:
              'orders/my-orders'); // Assuming the endpoint requires user ID

      List<OrderModel> orders = [];

      // Parse response
      final orderData = response['data']['orders'] as List<dynamic>?;

      if (orderData != null) {
        orders = orderData.map((json) => OrderModel.fromJson(json)).toList();
      }

      return orders.isEmpty
          ? left(Serverfailure("No orders found"))
          : right(orders);
    } catch (e) {
      print(e.toString());
      if (e is DioException) {
        return left(Serverfailure.fromDioException(e));
      }
      return left(Serverfailure(e.toString()));
    }
  }
}
