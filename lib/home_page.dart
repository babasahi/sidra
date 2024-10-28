import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:sidra/api.dart';
import 'package:sidra/models/sidr.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  final MapController mapController = MapController(
    initPosition: GeoPoint(latitude: 16.656446, longitude: -9.609621),
  );
  final List<GeoPoint> _points = [];
  late final Future fetchSidres;

  Future<void> addMarkers() async {
    // Add markers for each point
    try {
      print('adding markers');

      for (var p in _points) {
        await mapController.addMarker(
          p,
          markerIcon: const MarkerIcon(
            icon: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: 48,
            ),
          ),
        );
        print('added marker');
      }
    } catch (e) {
      print('$e');
    }
  }

  Future<void> fetchSidrs() async {
    await sidrs().then((v) {
      _points.addAll(v.map((e) => e.geoPoint).toList());
      addMarkers();
    });
  }

  @override
  void initState() {
    fetchSidres = sidrs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: OSMFlutter(
                controller: mapController,
                onMapIsReady: (p0) => _points.isNotEmpty,
                osmOption: const OSMOption(
                  userTrackingOption: UserTrackingOption(
                    enableTracking: false,
                    unFollowUser: false,
                  ),
                  zoomOption: ZoomOption(
                    initZoom: 12,
                    minZoomLevel: 3,
                    maxZoomLevel: 19,
                    stepZoom: 1.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
