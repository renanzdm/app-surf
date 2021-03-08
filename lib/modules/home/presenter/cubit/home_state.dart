part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {}

class HomeErrorState extends HomeState {
  final GetUserInfoError error;
  HomeErrorState({this.error});
  @override
  List<Object> get props => [error];
}
