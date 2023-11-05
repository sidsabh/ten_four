import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapComponent extends StatefulWidget {
  final Function(LatLng) onUserLocationChanged; // Callback function

  const GoogleMapComponent({Key? key, required this.onUserLocationChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => GoogleMapState();
}

class GoogleMapState extends State<GoogleMapComponent> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<LatLng> getUserLocation() async {
    Position position = await _determinePosition();
    double lat = position.latitude;
    double long = position.longitude;

    LatLng location = LatLng(lat, long);

    widget.onUserLocationChanged(location);

    return location;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserLocation(),
      builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
        if (snapshot.hasData) {
          return GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: snapshot.data!,
              zoom: 11.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            rotateGesturesEnabled: true,
            compassEnabled: true,
            indoorViewEnabled: true,
            buildingsEnabled: true,
            trafficEnabled: true,
            mapToolbarEnabled: true,
            circles: {
              Circle(
                circleId: const CircleId('userLocation'),
                center: snapshot.data!,
                radius: 1000,
                fillColor: Colors.blue.withOpacity(0.1),
                strokeColor: Colors.blue,
                strokeWidth: 1,
              ),
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
