import 'package:dartz/dartz.dart';
import 'package:surf_app/modules/home/domain/errors/get_places_error.dart';
import 'package:surf_app/modules/home/infra/models/places_model.dart';

abstract class IGetPlacesRepository{
  Future<Either<GetPlacesError,List<PlacesModel>>> getPlaces(String address);


}