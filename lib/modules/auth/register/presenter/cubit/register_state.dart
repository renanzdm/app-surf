part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterLoadedState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final RegisterErrors error;
  RegisterErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
