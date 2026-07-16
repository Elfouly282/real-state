part of 'agents_cubit.dart';

abstract class AgentsState {}
class AgentsInitial extends AgentsState {}
class AgentsLoading extends AgentsState {}
class AgentsActionLoading extends AgentsState {}
class AgentsSuccess extends AgentsState {
  final List<AgentEntity> list;
  AgentsSuccess(this.list);
}
class AgentsFailure extends AgentsState {
  final String message;
  AgentsFailure(this.message);
}
