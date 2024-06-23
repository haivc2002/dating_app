// double haversine(double lat1, double lon1, double lat2, double lon2) {
//   const R = 6371; // Radius of the Earth in kilometers
//   final dLat = _toRadians(lat2 - lat1);
//   final dLon = _toRadians(lon2 - lon1);
//   final a = sin(dLat / 2) * sin(dLat / 2) +
//       cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
//           sin(dLon / 2) * sin(dLon / 2);
//   final c = 2 * atan2(sqrt(a), sqrt(1 - a));
//   final distance = R * c; // Distance in kilometers
//   return distance;
// }
//
// double _toRadians(double degree) {
//   return degree * pi / 180;
// }
//
// void main() {
//   double lon1 = 105.7306142;
//   double lat1 = 21.0476867;
//   double lon2 = 105.7321215;
//   double lat2 = 21.0494033;
//
//   double distance = haversine(lat1, lon1, lat2, lon2);
//   print('Distance: ${distance.toStringAsFixed(2)} km');
// }