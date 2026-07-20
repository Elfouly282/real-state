import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/core/utils/app_styles.dart';
import 'package:real_state/features/property_details/domain/entities/property_entity.dart';
import 'package:real_state/features/property_details/presentation/cubit/property_details_cubit.dart';

class PropertyInfoWidget extends StatelessWidget {
  final PropertyEntity property;
  final bool isFav;
  const PropertyInfoWidget({
    super.key,
    required this.property,
    required this.isFav,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${property.price} EGP',
                style: getHighStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.35),
              IconButton(
                onPressed: () {
                  context.read<PropertyDetailsCubit>().makeFav(property.id);
                },
                icon: Icon(
                  isFav ? Icons.star : Icons.star_border_outlined,
                  color: Colors.amber,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Icon(Icons.bed_outlined, color: Colors.grey, size: 15),
              SizedBox(width: MediaQuery.of(context).size.height * 0.005),

              Text(
                property.bedrooms.toString(),
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
                property.bathrooms.toString(),
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
                property.bedrooms.toString(),
                style: getLightStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                'Kitchen',
                style: getLightStyle(fontSize: 14, color: Colors.grey),
              ),

              Text(
                property.kitchens.toString(),
                style: getLightStyle(fontSize: 12, color: Colors.white),
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
          Text(
            'Description',
            style: getHighStyle(fontSize: 20, color: Colors.black),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
          Text(
            property.description,
            style: getMediumStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
