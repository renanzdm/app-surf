import 'package:dartz/dartz.dart';
import 'package:surf_app/modules/home/domain/entities/user_id.dart';
import 'package:surf_app/modules/home/domain/errors/get_places_error.dart';
import 'package:surf_app/modules/home/domain/errors/get_user_info_errors.dart';
import 'package:surf_app/modules/home/domain/repositories/i_get_places_repository.dart';
import 'package:surf_app/modules/home/domain/repositories/i_get_user_info_repository.dart';
import 'package:surf_app/modules/home/infra/models/places_model.dart';
import 'package:surf_app/modules/home/presenter/usecases/i_home_usercase.dart';

class HomeUseCase extends IHomeUseCase {
  final IGetUserInfosRepository _userRepository;
  final IGetPlacesRepository _placesRepository;

  HomeUseCase(this._userRepository,this._placesRepository);

  @override
  Future<Either<GetUserInfoError, UserId>> getUserInformations() async {
    var res = await _userRepository.getUserInfo();
    return res.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<GetPlacesError,List<PlacesModel>>> getLocationBeach(String address) async {
    var res = await _placesRepository.getPlaces(address);
    return res.fold((l) => left(l), (r) => right(r));

  }
}
