import 'package:equatable/equatable.dart';

abstract class PaymentStates extends Equatable {
  final int stepNumber;

  const PaymentStates({this.stepNumber = 0});

  @override
  List<Object?> get props => [stepNumber];
}

class PaymentInitialState extends PaymentStates {}

class CreateOrderLoadingState extends PaymentStates {
  const CreateOrderLoadingState({super.stepNumber = 3});

  @override
  List<Object?> get props => [];
}

class CreateOrderSuccessState extends PaymentStates {
  final String paymentUrl;

  const CreateOrderSuccessState(this.paymentUrl, {super.stepNumber = 3});

  @override
  List<Object?> get props => [paymentUrl];
}

class CreateOrderErrorState extends PaymentStates {
  final String message;

  const CreateOrderErrorState(this.message, {super.stepNumber = 3});

  @override
  List<Object?> get props => [message];
}

class PaymentStepChanged extends PaymentStates {
  const PaymentStepChanged({required super.stepNumber});
}
