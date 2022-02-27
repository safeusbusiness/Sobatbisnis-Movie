import 'package:geolocator/geolocator.dart';

class LocationService {

  static Future<Position?> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('GetPosition: Location services are disabled.');
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('GetPosition: Location permissions are denied');
        return null;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      print('GetPosition: Location permissions are permanently denied, we cannot request permissions.');
      return null;
    } 

    return await Geolocator.getCurrentPosition();
  }

}