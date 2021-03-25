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
        (r) => emit(HomeUserLoadedState(userId: r)));
  }

  static const historyLength = 5;

  List<String> _searchHistory = [];
  List<String>? filteredSearchHistory;

  String? selectedTerm;

  List<String> filterSearchTerms({
    required String? filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
    // Changes in _searchHistory mean that we have to update the filteredSearchHistory
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }
}
