import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class OsmAttribution extends StatelessWidget {
  const OsmAttribution({super.key});

  @override
  Widget build(BuildContext context) {
    return const RichAttributionWidget(
      alignment: AttributionAlignment.bottomLeft,
      popupInitialDisplayDuration: Duration(seconds: 3),
      attributions: [
        TextSourceAttribution('© OpenStreetMap contributors'),
      ],
    );
  }
}
