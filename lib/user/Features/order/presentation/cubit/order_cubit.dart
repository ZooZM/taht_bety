import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dartz/dartz.dart';
import 'package:taht_bety/core/errors/failures.dart';
import 'package:taht_bety/user/Features/order/data/models/order_model/order_model.dart';
import 'package:taht_bety/user/Features/order/data/repo/order_repo.dart';
import 'package:taht_bety/user/Features/order/presentation/cubit/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.orderRepo) : super(OrderInitial());
  final OrderRepo orderRepo;

  Future<void> fetchOrders() async {
    emit(OrderLoading());
    final Either<Failure, List<OrderModel>> result =
        await orderRepo.fetchUserOrders();
    print("result: $result");

    result.fold(
      (failure) => emit(OrderError(failure.failurMsg)),
      (orders) => emit(OrderLoaded(orders)),
    );
  }
}
