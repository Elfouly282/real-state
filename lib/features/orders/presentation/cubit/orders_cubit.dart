import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/orders_usecases.dart';
part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUsecase _get;

  OrdersCubit(this._get) : super(OrdersInitial());

  Future<void> load() async {
    emit(OrdersLoading());
    final res = await _get();
    res.fold((f) => emit(OrdersFailure(f.message)), (list) => emit(OrdersSuccess(list)));
  }
}
