import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/features/payment/domain/use_case/create_order_use_case.dart';
import 'package:real_state/features/payment/presentation/view_model/payment_states.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  final CreateOrderUseCase _createOrderUseCase;

  PaymentCubit(this._createOrderUseCase) : super(PaymentInitialState());

  Future<void> createOrder(int propertyId) async {
    emit(CreateOrderLoadingState());
    final result = await _createOrderUseCase.invoke(propertyId);
    result.fold(
      (failure) => emit(CreateOrderErrorState(failure.message)),
      (orderPaymentEntity) =>
          emit(CreateOrderSuccessState(orderPaymentEntity.paymentUrl)),
    );
  }

  void stepChanged(int stepNumber) {
    if (stepNumber < 4) {
      stepNumber = stepNumber + 1;
    }

    emit(PaymentStepChanged(stepNumber: stepNumber));
  }
}
