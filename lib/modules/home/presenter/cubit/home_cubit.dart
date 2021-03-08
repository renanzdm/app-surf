import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:surf_app/modules/home/domain/errors/get_user_info_errors.dart';
import 'package:surf_app/modules/home/presenter/usecases/i_home_usercase.dart';

part 'home_state.dart';

@Injectable()
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._homeUC,
  ) : super(HomeInitial());

  final IHomeUseCase _homeUC;

  Future<void> getUserInfo() async {
    emit(HomeLoadingState());
    var res = await _homeUC.getUserInfromations();
    res.fold(
        (l) => emit(HomeErrorState(error: l)), (r) => emit(HomeLoadedState()));
  }
}
