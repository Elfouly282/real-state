import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/features/home.dart';
import 'package:real_state/features/property_details/data/data_sourse/property_details_remote_data_Sourse.dart';
import 'package:real_state/features/property_details/data/repository/property_repository_impl.dart';
import 'package:real_state/features/property_details/domain/use_case/get_property_details_usecase.dart';
import 'package:real_state/features/property_details/presentation/cubit/property_details_cubit.dart';
import 'package:real_state/features/property_details/presentation/pages/property_details_page.dart';
import 'package:real_state/features/property_details/presentation/pages/property_images.dart';
import 'package:real_state/features/property_for_you/data/data_sourse/similer_property_remote_data_sourse.dart';
import 'package:real_state/features/property_for_you/data/repository/similer_property_repository_impl.dart';
import 'package:real_state/features/property_for_you/domain/use_case/similer_property_Use_case.dart';
import 'package:real_state/features/property_for_you/presentation/cubit/similer_property_cubit.dart';
import 'package:real_state/features/user_reviews/data/data_sourse/reviews_remote_data_sourse.dart';
import 'package:real_state/features/user_reviews/data/repository/reviews_repository_impl.dart';
import 'package:real_state/features/user_reviews/domain/use_case/reviews_use_case.dart';
import 'package:real_state/features/user_reviews/presentation/cubit/user_reviews_cubit.dart';

class AppRoute {
  static const home = '/';
  static const propertyDetails = '/propertydetails';
  static const imagesPage = '/imagepage';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoute.imagesPage:
        final images = settings.arguments as List<String>;
        return MaterialPageRoute(
          builder: (_) => PropertyImages(images: images),
        );
      case AppRoute.propertyDetails:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) {
                  return PropertyDetailsCubit(
                    getProperty: GetPropertyDetailsUsecase(
                      repo: PropertyRepositoryImpl(
                        dataSourse: PropertyDetailsRemoteDataSourse(),
                      ),
                    ),
                  )..getPropertyDetails(id);
                },
              ),
              BlocProvider(
                create: (context) {
                  return UserReviewsCubit(
                    getReviews: ReviewsUseCase(
                      repo: ReviewsRepositoryImpl(
                        remoteDataSourse: ReviewsRemoteDataSourse(),
                      ),
                    ),
                  )..getAllReviwes(id);
                },
              ),
              BlocProvider(
                create: (context) {
                  return SimilerPropertyCubit(
                    getsimilerProperty: similerPropertyUserCase(
                      repo: SimilerPropertyRepositoryImpl(
                        remoteDataSourse: SimilerPropertyRemoteDataSourse(),
                      ),
                    ),
                  )..getSimilerProperty(id);
                },
              ),
            ],
            child: const PropertyDetailsPage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("No Route Found"))),
        );
    }
  }
}
