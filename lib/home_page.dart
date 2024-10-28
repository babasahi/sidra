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
  final MapController controller = MapController(
      initPosition: GeoPoint(latitude: 16.656446, longitude: -9.609621));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<List<Sidr>>(
                future: sidrs(),
                initialData: const [],
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.connectionState == ConnectionState.active) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    if (snapshot.hasData && snapshot.data != null) {
                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Trees Found',
                          ),
                        );
                      } else {
                        return OSMFlutter(
                          controller: controller,
                          osmOption: const OSMOption(
                            userTrackingOption: UserTrackingOption(
                              enableTracking: false,
                              unFollowUser: false,
                            ),
                            zoomOption: ZoomOption(
                              initZoom: 8,
                              minZoomLevel: 3,
                              maxZoomLevel: 19,
                              stepZoom: 1.0,
                            ),
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                        ),
                      );
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
