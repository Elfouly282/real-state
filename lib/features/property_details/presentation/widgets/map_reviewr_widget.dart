import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_state/features/property_details/domain/entities/property_entity.dart';

class MapPreviewWidget extends StatelessWidget {
  final PropertyEntity property;

  const MapPreviewWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final location = LatLng(property.lat, property.lng);

    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 220,
          width: double.infinity,
          child: FlutterMap(
            options: MapOptions(
              initialCenter: location,
              initialZoom: 16,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.none,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.real_state',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: location,
                    width: 45,
                    height: 45,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
