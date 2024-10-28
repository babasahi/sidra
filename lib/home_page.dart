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
  late MapController mapController;
  List<Sidr> sidrLocations = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    mapController = MapController(
      initPosition: GeoPoint(
        latitude: 16.65718,
        longitude: -9.6102389,
      ),
    );

    // Fetch data and add markers
    loadSidrLocations();
  }

  Future<void> addMarkers() async {
    // Add markers for each point
    try {
      print('adding markers');

      for (var p in sidrLocations.map((e) => e.geoPoint)) {
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

  Future<void> loadSidrLocations() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      // Fetch Sidr locations from backend
      sidrLocations = await sidrs();

      // Add markers after fetching data
      await addMarkers();
    } catch (e) {
      setState(() {
        error = 'Failed to load Sidr locations: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                child: const Row(
                  children: [
                    Text(
                      'خريطة تفاعلية لشجر السدر في موريتانيا',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: OSMFlutter(
                  controller: mapController,
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
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: const Center(
                  child: Text(
                    'Built with ❤️ by Babasahi',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
