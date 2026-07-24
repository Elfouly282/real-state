import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
<<<<<<< HEAD
import 'package:real_state/core/App_routes/app_route.dart';
=======
>>>>>>> c438fbf (Update home)
import 'package:real_state/core/constant/search_text_filed.dart';
import 'package:real_state/core/di.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/core/utils/app_styles.dart';
import 'package:real_state/features/home/domain/entity/home_entity.dart';
import 'package:real_state/features/home/domain/entity/category_entity.dart';
import 'package:real_state/features/home/domain/entity/property_entity.dart';
import 'package:real_state/features/home/domain/entity/image_entity.dart';
import 'package:real_state/features/home/prsentations/cubit/home_cubit.dart';
import 'package:real_state/features/home/prsentations/cubit/home_state.dart';
import 'package:real_state/features/home/prsentations/views/category_chip.dart';
import 'package:real_state/features/home/prsentations/views/nearest_property_card.dart';
import 'package:real_state/features/home/prsentations/views/property_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _dummyHomeData = HomeEntity(
  categories: List.generate(
    5,
    (index) => CategoryEntity(id: index, name: 'Category $index'),
  ),
  bestSelling: List.generate(
    3,
    (index) => PropertyEntity(
      id: index,
      title: 'Beautiful Villa Suite $index',
      description: 'A gorgeous luxury villa located in the heart of the city.',
      price: '1,200,000',
      address: 'Beverly Hills, California',
      latitude: 34.0736,
      longitude: -118.4004,
      rate: 4.8,
      category: CategoryEntity(id: index, name: 'Category $index'),
      images: const [
        ImageEntity(id: 1, url: 'https://via.placeholder.com/150'),
      ],
      distance: 1.5,
    ),
  ),
  featured: List.generate(
    3,
    (index) => PropertyEntity(
      id: index,
      title: 'Featured Residence $index',
      description: 'A gorgeous luxury villa located in the heart of the city.',
      price: '950,000',
      address: 'Los Angeles, California',
      latitude: 34.0522,
      longitude: -118.2437,
      rate: 4.7,
      category: CategoryEntity(id: index, name: 'Category $index'),
      images: const [
        ImageEntity(id: 1, url: 'https://via.placeholder.com/150'),
      ],
      distance: 2.3,
    ),
  ),
  recommended: List.generate(
    3,
    (index) => PropertyEntity(
      id: index,
      title: 'Premium Apartment $index',
      description: 'A gorgeous luxury villa located in the heart of the city.',
      price: '800,000',
      address: 'Santa Monica, California',
      latitude: 34.0194,
      longitude: -118.4912,
      rate: 4.6,
      category: CategoryEntity(id: index, name: 'Category $index'),
      images: const [
        ImageEntity(id: 1, url: 'https://via.placeholder.com/150'),
      ],
      distance: 3.1,
    ),
  ),
);

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..getHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeError) {
            print(state.message);
            return Center(child: Text(state.message));
          }
          print(state.runtimeType);

          final isLoading = state is HomeLoading || state is HomeInitial;
          final homeData = isLoading
              ? _dummyHomeData
              : (state as HomeSuccess).home;

          return Scaffold(
            backgroundColor: const Color(0xffFAF9F6),
            body: SafeArea(
              child: Skeletonizer(
                enabled: isLoading,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 34.sp,
                            color: const Color(0xff1597A8),
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "location",
                                style: getRegularStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.black.withOpacity(.52),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "Beverly Hills, California",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: getRegularStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 56.w,
                              height: 56.h,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              child: const Icon(
                                Icons.notifications_outlined,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 56.w,
                              height: 56.h,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              child: const Icon(
                                Icons.message_outlined,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      /// Search
                      Row(
                        children: [
                          Expanded(
                            child: SearchTextField(
                              controller: searchController,
                              hintText: 'Search your home',
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context.read<HomeCubit>().getHomeData(
                                search: searchController.text,
                              );
                            },
                            child: Container(
                              width: 56.w,
                              height: 56.h,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              child: const Icon(
                                Icons.tune,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      /// Categories
                      SizedBox(
                        height: 45.h,
                        child: ListView.builder(
                          itemCount: homeData.categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryChip(
                              title: homeData.categories[index].name,
                              isSelected: selectedIndex == index,
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                                print(homeData.categories[index].id);

                                final categoryId =
                                    homeData.categories[index].id;

                                context.read<HomeCubit>().getHomeData(
                                  categoryID: categoryId,
                                );
                              },
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 28.h),

                      /// Best Offers
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Best Offers",
                            style: getBoldStyle(
                              fontSize: 20.sp,
                              color: AppColors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "View All",
                              style: getRegularStyle(
                                fontSize: 12.sp,
                                color: const Color(0xff1597A8),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15.h),

                      SizedBox(
                        height: 270.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeData.bestSelling.length,
                          separatorBuilder: (_, __) => SizedBox(width: 15.w),
                          itemBuilder: (context, index) {
                            return PropertyCard(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoute.propertyDetails,
                                  arguments: homeData.bestSelling[index].id,
                                );
                              },
                              property: homeData.bestSelling[index],
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 30.h),

                      /// Nearest You
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Nearest You",
                            style: getBoldStyle(
                              fontSize: 20.sp,
                              color: AppColors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "View All",
                              style: getRegularStyle(
                                fontSize: 12,
                                color: const Color(0xff1597A8),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15.h),

                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: homeData.recommended.length,
                        separatorBuilder: (_, __) => SizedBox(height: 15.h),
                        itemBuilder: (context, index) {
                          return NearestPropertyCard(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.propertyDetails,
                                arguments: homeData.recommended[index].id,
                              );
                            },
                            prop: homeData.recommended[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
