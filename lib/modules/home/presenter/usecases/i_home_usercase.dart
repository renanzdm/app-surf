import 'package:dartz/dartz.dart';
import 'package:surf_app/modules/home/domain/entities/user_id.dart';
import 'package:surf_app/modules/home/domain/errors/get_places_error.dart';
import 'package:surf_app/modules/home/domain/errors/get_user_info_errors.dart';
import 'package:surf_app/modules/home/infra/models/places_model.dart';

abstract class IHomeUseCase {
  Future<Either<GetUserInfoError, UserId>> getUserInformations();
  Future<Either<GetPlacesError, List<PlacesModel>>> getLocationBeach(String address);
}
