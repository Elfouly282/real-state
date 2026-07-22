import 'package:flutter/material.dart';
import 'package:real_state/core/App_routes/app_route.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/core/utils/app_styles.dart';
import 'package:real_state/features/property_for_you/domain/Entites/similer_ptoperty_entity.dart';

class SimilerPropertyCard extends StatelessWidget {
  final SimilerPropertyEntity? similerPropertyEntity;
  const SimilerPropertyCard({super.key, this.similerPropertyEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoute.propertyDetails,
          arguments: similerPropertyEntity?.id ?? 1,
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: similerPropertyEntity != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        similerPropertyEntity!.image.image,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              similerPropertyEntity?.title ?? 'loading',
              style: getMediumStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primaryColor,
                  size: 15,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.002),
                Text(
                  (similerPropertyEntity?.address.length ?? 0) > 30
                      ? '${similerPropertyEntity!.address.substring(0, 30)}...'
                      : similerPropertyEntity?.address ?? 'loading',
                  style: getLightStyle(fontSize: 12, color: Colors.black),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Text('|', style: TextStyle(color: Colors.grey)),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Icon(
                  Icons.screen_share_outlined,
                  color: AppColors.primaryColor,
                  size: 15,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Text(
                  similerPropertyEntity?.distance_km.toString() ?? 'laoding',
                  style: getLightStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              children: [
                Icon(Icons.bed_outlined, color: Colors.grey, size: 15),
                SizedBox(width: MediaQuery.of(context).size.height * 0.005),

                Text(
                  similerPropertyEntity?.bedrooms.toString() ?? 'loading',
                  style: getLightStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  'Bedrooms',
                  style: getLightStyle(fontSize: 14, color: Colors.grey),
                ),

                SizedBox(width: MediaQuery.of(context).size.height * 0.005),
                Text('|', style: TextStyle(color: Colors.grey)),
                SizedBox(width: MediaQuery.of(context).size.height * 0.005),
                Icon(Icons.bathtub_sharp, color: Colors.grey, size: 20),
                SizedBox(width: MediaQuery.of(context).size.height * 0.005),
                Text(
                  similerPropertyEntity?.bathrooms.toString() ?? 'loading',
                  style: getLightStyle(fontSize: 14, color: Colors.grey),
                ),

                Text(
                  'Bathrooms',
                  style: getLightStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(width: MediaQuery.of(context).size.height * 0.005),
                Text('|', style: TextStyle(color: Colors.grey)),
                SizedBox(width: MediaQuery.of(context).size.height * 0.005),
                Icon(Icons.kitchen_rounded, color: Colors.grey, size: 20),
                SizedBox(width: MediaQuery.of(context).size.height * 0.005),

                Text(
                  similerPropertyEntity?.kitchens.toString() ?? 'loading',
                  style: getLightStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  'Kitchen',
                  style: getLightStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.living_outlined, color: Colors.grey, size: 15),
                SizedBox(width: MediaQuery.of(context).size.height * 0.005),
                Text(
                  'Living Room',
                  style: getLightStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(width: MediaQuery.of(context).size.height * 0.005),
                Text('|', style: TextStyle(color: Colors.grey)),
                SizedBox(width: MediaQuery.of(context).size.height * 0.005),
                Icon(Icons.family_restroom, color: Colors.grey, size: 20),
                SizedBox(width: MediaQuery.of(context).size.height * 0.005),
                Text(
                  'Family Room',
                  style: getLightStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              children: [
                Text(
                  (similerPropertyEntity != null)
                      ? '${similerPropertyEntity!.price} EGP/Month'
                      : 'loading',
                  style: getHighStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                Icon(Icons.star, color: Colors.amber, size: 18),
                SizedBox(width: MediaQuery.of(context).size.width * 0.002),
                Text(
                  similerPropertyEntity?.rating.toString() ?? 'loading ',
                  style: getMediumStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
