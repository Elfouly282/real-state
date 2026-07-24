import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/di.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/features/payment/domain/entity/property_summary_entity.dart';
import 'package:real_state/features/payment/presentation/view/payment_view.dart';
import 'package:real_state/features/payment/presentation/view_model/payment_cubit.dart';

class AppUser extends StatelessWidget {
  const AppUser({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Real State Admin',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryColor,
            ),
            useMaterial3: true,
            fontFamily: 'Quest',
          ),
          home: child,
        );
      },
      child: BlocProvider(
        create: (context) => getIt<PaymentCubit>(),
        child: PaymentView(
          propertySummary: PropertySummaryEntity(
            id: 107,
            title: 'Sunnyslade House',
            address: 'Beverly Hills, CA',
            imageUrl:
                'https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?w=200',
            price: '120000',
            rate: 4.9,
            description:
                'Free cancellation within 48 hours. If canceled before June 1, you will receive a partial refund. Read the Full Accommodation Policy for more details.',
            reviews: '10',
            appointmentDate: '12 Sept 2025 - 09.00',
          ),
          name: "mahmoud",
          phone: "01273086169",
          email: 'mahmoud@gmail.com',
        ),
      ),
    );
  }
}

//     void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
//     return ScreenUtilInit(
//       designSize: const Size(360, 690),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       // Use builder only if you need to use library outside ScreenUtilInit context
//       builder: (_ , child) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'First Method',
//           // You can use the library anywhere in the app even in theme
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//             textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
//           ),
//           home: child,
//         );
//       },
//       child: const HomePage(title: 'First Method'),
//     );
//   }
// }
