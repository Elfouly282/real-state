import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/core/utils/app_styles.dart';
import 'package:real_state/features/property_details/domain/entities/property_entity.dart';
import 'package:real_state/features/property_details/presentation/widgets/agent_info_wiget.dart';
import 'package:real_state/features/property_details/presentation/widgets/map_reviewr_widget.dart';
import 'package:real_state/features/property_details/presentation/widgets/property_info_widget.dart';
import 'package:real_state/features/property_details/presentation/widgets/user_reviews_widget.dart';
import 'package:real_state/features/property_for_you/presentation/page/similer_property_page.dart';
import 'package:real_state/features/user_reviews/presentation/cubit/user_reviews_cubit.dart';
import 'package:real_state/features/user_reviews/presentation/page/user_review_page.dart';

class PropertyDetailsWiget extends StatelessWidget {
  final PropertyEntity property;
  final bool isFav;
  const PropertyDetailsWiget({
    super.key,
    required this.property,
    required this.isFav,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: CircleAvatar(
                backgroundColor: Colors.black38,
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                  backgroundColor: Colors.black38,
                  child: Icon(Icons.forward_outlined, color: Colors.white),
                ),
              ),
            ],
            title: Text(
              'Property Details',
              style: getMediumStyle(fontSize: 20, color: Colors.white),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(property.images.first.url, fit: BoxFit.cover),

                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.title,
                          style: getHighStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.002,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 20,
                            ),

                            Text(
                              property.address.length > 20
                                  ? '${property.address.substring(0, 20)}...'
                                  : property.address,
                              style: getLightStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.005,
                            ),
                            Text('|', style: TextStyle(color: Colors.white)),
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.005,
                            ),
                            Icon(
                              Icons.navigation_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              property.distanceKm.toString(),
                              style: getLightStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.005,
                            ),
                            Text('|', style: TextStyle(color: Colors.white)),
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.005,
                            ),
                            Icon(
                              Icons.star_rate_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              property.rating.toString(),
                              style: getLightStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PropertyInfoWidget(property: property, isFav: isFav),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text(
                    'Lissting Agent',
                    style: getHighStyle(fontSize: 20, color: Colors.black),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  AgentInfoWiget(property: property),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    'Location Address',
                    style: getHighStyle(fontSize: 20, color: Colors.black),
                  ),
                  MapPreviewWidget(property: property),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Row(
                    children: [
                      Text(
                        'User Reviews',
                        style: getHighStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<UserReviewsCubit>(),
                                child: const UserReviewPage(),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'see all',
                          style: getMediumStyle(
                            fontSize: 16,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      Text('${property.rating.toString()}'),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                  UserReviewsWidget(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    'You Must Also Like',
                    style: getHighStyle(fontSize: 20, color: Colors.black),
                  ),
                  SimilerPropertyPage(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/imagepage',
                      arguments: property.images.map((e) => e.url).toList(),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    side: BorderSide.none,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Explore in 360°',
                    style: getMediumStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  label: Text(
                    'Book a Call',
                    style: getMediumStyle(color: Colors.white, fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
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
