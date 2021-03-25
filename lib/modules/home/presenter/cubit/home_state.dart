part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeUserLoadedState extends HomeState {
  late final UserId userId;

  HomeUserLoadedState({required this.userId});

  @override
  List<Object> get props => [userId];
}

class HomeErrorState extends HomeState {
  final GetUserInfoError error;
  HomeErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
