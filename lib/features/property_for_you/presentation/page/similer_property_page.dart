import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/features/property_for_you/presentation/cubit/similer_property_cubit.dart';
import 'package:real_state/features/property_for_you/presentation/widget/similer_property_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SimilerPropertyPage extends StatelessWidget {
  const SimilerPropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilerPropertyCubit, SimilerPropertyState>(
      builder: (context, state) {
        if (state is SimilerPropertyLoading) {
          return Skeletonizer(
            enabled: true,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (_, _) => const SimilerPropertyCard(),
            ),
          );
        }
        if (state is SimilerPropertyLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.similerPropertyEntity.length,
            itemBuilder: ((context, index) {
              return SimilerPropertyCard(
                similerPropertyEntity: state.similerPropertyEntity[index],
              );
            }),
          );
        }
        if (state is SimilerPropertyError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
