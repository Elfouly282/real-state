part of 'orders_cubit.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersActionLoading extends OrdersState {}

class OrdersSuccess extends OrdersState {
  final List<OrderEntity> list;
  final OrderPaginationMeta meta;
  OrdersSuccess(this.list, this.meta);
}

class OrdersFailure extends OrdersState {
  final String message;
  OrdersFailure(this.message);
}
