import 'dart:math';

double getDistanceBetweenTwoPoints(double x1, double x2, double y1, double y2) {
  return sqrt(pow((x1 - x2), 2) + pow((y1 - y2), 2));
}

List<double> getPolygonCenter(List<List<double>> points) {
  List<double> x = points.map((List<double> latLng) => latLng[0]).toList();
  List<double> y = points.map((List<double> latLng) => latLng[1]).toList();
  double minX = x.reduce(min);
  double maxX = x.reduce(max);
  double minY = y.reduce(min);
  double maxY = y.reduce(max);

  for (var i = 0; i < points.length; i++) {
    minX = (points[i][0] < minX || minX == null) ? points[i][0] : minX;
    maxX = (points[i][0] > maxX || maxX == null) ? points[i][0] : maxX;
    minY = (points[i][1] < minY || minY == null) ? points[i][1] : minY;
    maxY = (points[i][1] > maxY || maxY == null) ? points[i][1] : maxY;
  }
  return [(minX + maxX) / 2, (minY + maxY) / 2];
}

// TODO:
/**
 * https://stackoverflow.com/questions/639695/how-to-convert-latitude-or-longitude-to-meters
    function measure(lat1, lon1, lat2, lon2){  // generally used geo measurement function
    var R = 6378.137; // Radius of earth in KM
    var dLat = lat2 * Math.PI / 180 - lat1 * Math.PI / 180;
    var dLon = lon2 * Math.PI / 180 - lon1 * Math.PI / 180;
    var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
    Math.sin(dLon/2) * Math.sin(dLon/2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    var d = R * c;
    return d * 1000; // meters
    }
 */
dynamic measure(lat1, lon1, lat2, lon2) {
  double R = 6378.137; // Radius of earth in KM
  double dLat = lat2 * pi / 180 - lat1 * pi / 180;
  double dLon = lon2 * pi / 180 - lon1 * pi / 180;
  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1 * pi / 180) * cos(lat2 * pi / 180) * sin(dLon / 2) * sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double d = R * c;
  return d * 1000; // meters
}
