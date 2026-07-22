import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/orders_usecases.dart';
part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUsecase _get;
  String? _statusFilter;

  OrdersCubit(this._get) : super(OrdersInitial());

  Future<void> load({int page = 1, String? status}) async {
    _statusFilter = status;
    if (state is! OrdersSuccess) emit(OrdersLoading());
    final res = await _get(page: page, status: _statusFilter);
    res.fold(
      (f) => emit(OrdersFailure(f.message)),
      (paginated) => emit(OrdersSuccess(paginated.data, paginated.meta)),
    );
  }
}
