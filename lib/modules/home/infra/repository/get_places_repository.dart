import 'package:dartz/dartz.dart';
import 'package:surf_app/modules/home/domain/errors/get_places_error.dart';
import 'package:surf_app/modules/home/domain/repositories/i_get_places_repository.dart';
import 'package:surf_app/modules/home/infra/datasources/i_get_places_datasource.dart';
import 'package:surf_app/modules/home/infra/models/places_model.dart';

class GetPlacesRepository extends IGetPlacesRepository {
  final IGetPlacesDataSource _dataSource;

  GetPlacesRepository(this._dataSource);

  @override
  Future<Either<GetPlacesError, List<PlacesModel>>> getPlaces(String address) async {
    try {
      var places = await _dataSource.getPlaces(address);
      return right(places);
    } on GetPlacesError catch (e) {
      return left(e);
    } catch (e) {
      return left(PlacesServerError(error: e.toString()));

    }
  }
}
