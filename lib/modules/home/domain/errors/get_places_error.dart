abstract class GetPlacesError{}


class PlacesServerError extends GetPlacesError{
   late final String error;

   PlacesServerError({required this.error});
}

class NotFoundPlaces extends GetPlacesError{
   late final String error;

   NotFoundPlaces({required this.error});
}