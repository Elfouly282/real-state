import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/constant/custom_app_bar.dart';
import 'package:real_state/core/constant/search_text_filed.dart';
import 'package:real_state/core/di.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/core/utils/app_styles.dart';
import 'package:real_state/features/home/prsentations/cubit/home_cubit.dart';
import 'package:real_state/features/home/prsentations/cubit/home_state.dart';
import 'package:real_state/features/home/prsentations/views/category_chip.dart';
import 'package:real_state/features/home/prsentations/views/nearest_property_card.dart';
import 'package:real_state/features/home/prsentations/views/property_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

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
          } else if (state is HomeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HomeSuccess) {
            final homeData = state.home;
            return Scaffold(
              backgroundColor: Color(0xffFAF9F6),

              body: SafeArea(
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
                            size: 34,
                            color: Color(0xff1597A8),
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "location",

                                style: getRegularStyle(
                                  fontSize: 14,
                                  color: AppColors.black.withOpacity(.52),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "Beverly Hills, California",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: getRegularStyle(
                                  fontSize: 14,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 56.w,
                              height: 56.h,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              child: Icon(
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
                              child: Icon(
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
                              child: Icon(Icons.tune, color: AppColors.black),
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
                              fontSize: 20,
                              color: AppColors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "View All",
                              style: getRegularStyle(
                                fontSize: 12,
                                color: Color(0xff1597A8),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15.h),

                      SizedBox(
                        height: 259.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          separatorBuilder: (_, __) => SizedBox(width: 15.w),
                          itemBuilder: (context, index) {
                            return PropertyCard(
                              onTap: () {},
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
                              fontSize: 20,
                              color: AppColors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "View All",
                              style: getRegularStyle(
                                fontSize: 12,
                                color: Color(0xff1597A8),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15.h),

                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        separatorBuilder: (_, __) => SizedBox(height: 15.h),
                        itemBuilder: (context, index) {
                          return NearestPropertyCard(
                            onTap: () {},
                            prop: homeData.recommended[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
