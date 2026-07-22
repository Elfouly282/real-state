import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/features/property_details/presentation/cubit/property_details_cubit.dart';
import 'package:real_state/features/property_details/presentation/widgets/property_details_loading.dart';
import 'package:real_state/features/property_details/presentation/widgets/property_details_wiget.dart';

class PropertyDetailsPage extends StatelessWidget {
  const PropertyDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyDetailsCubit, PropertyDetailsState>(
      builder: ((context, state) {
        if (state is PropertyDetailsLoadding) {
          return PropertyDetailsLoadingWidget();
        }
        if (state is PropertyDetailsLoadded) {
          final property = state.property;
          return PropertyDetailsWiget(property: property, isFav: state.isFav);
        }
        if (state is propertyDetailsError) {
          return Scaffold(
            body: Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }
        return const Scaffold(body: Center(child: Text("Waiting...")));
      }),
    );
  }
}
