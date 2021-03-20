import 'package:surf_app/modules/home/infra/models/places_model.dart';

abstract class IGetPlacesDataSource {
  Future<List<PlacesModel>> getPlaces(String address);


}