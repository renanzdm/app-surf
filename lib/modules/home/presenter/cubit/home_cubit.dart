import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:surf_app/modules/home/domain/entities/user_id.dart';

import 'package:surf_app/modules/home/domain/errors/get_user_info_errors.dart';
import 'package:surf_app/modules/home/presenter/usecases/i_home_usercase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._homeUC,
  ) : super(HomeInitial());

  final IHomeUseCase _homeUC;

  Future<void> getUserInfo() async {
    emit(HomeLoadingState());
    var res = await _homeUC.getUserInformations();
    res.fold((l) => emit(HomeErrorState(error: l)),
        (r) => emit(HomeLoadedState(userId: r)));
  }
}
