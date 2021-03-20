// To parse this JSON data, do
//
//     final placesModel = placesModelFromJson(jsonString);

import 'dart:convert';

PlacesModel placesModelFromJson(String str) => PlacesModel.fromJson(json.decode(str));

String placesModelToJson(PlacesModel data) => json.encode(data.toJson());

class PlacesModel {
  PlacesModel({
   required this.formattedAddress,
   required this.geometry,
    required this.name,
  });

  String formattedAddress;
  Geometry geometry;
  String name;

  factory PlacesModel.fromJson(Map<String, dynamic> json) => PlacesModel(
    formattedAddress: json["formatted_address"],
    geometry: Geometry.fromJson(json["geometry"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "formatted_address": formattedAddress,
    "geometry": geometry.toJson(),
    "name": name,
  };
}

class Geometry {
  Geometry({
   required this.location,
    required this.viewport,
  });

  Location location;
  Viewport viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    location: Location.fromJson(json["location"]),
    viewport: Viewport.fromJson(json["viewport"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "viewport": viewport.toJson(),
  };
}

class Location {
  Location({
  required  this.lat,
   required this.lng,
  });

  double lat;
  double lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Viewport {
  Viewport({
   required this.northeast,
    required this.southwest,
  });

  Location northeast;
  Location southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
    northeast: Location.fromJson(json["northeast"]),
    southwest: Location.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast.toJson(),
    "southwest": southwest.toJson(),
  };
}
