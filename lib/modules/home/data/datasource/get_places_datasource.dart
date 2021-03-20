import 'package:surf_app/infrastructure/rest_client/i_rest_client.dart';
import 'package:surf_app/modules/home/domain/errors/get_places_error.dart';
import 'package:surf_app/modules/home/infra/datasources/i_get_places_datasource.dart';
import 'package:surf_app/modules/home/infra/models/places_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GetPlacesDataSource extends IGetPlacesDataSource {
  GetPlacesDataSource(this._client);

  final IRestClient _client;

  @override
  Future<List<PlacesModel>> getPlaces(String address) async {
    try {
      var urlPlaces = env['url_places'];
      var inputQuery = env['input_type_places'];
      var apiKey = env['api_key'];
      final client = _client.instance();
      var response = await client.get('$urlPlaces$address$inputQuery$apiKey');

      var listPlaces = response.data['candidates'] as List;

      return listPlaces.map((e) => PlacesModel.fromJson(e)).toList();
    } catch (e) {
      throw PlacesServerError(error: e.toString());
    }
  }
}
