import 'package:flutter/material.dart';
import 'package:real_state/core/constant/custom_button.dart';
import 'package:real_state/core/funcations/app_functions.dart';
import 'package:real_state/core/save%20data/save_data.dart';
import 'package:real_state/features/auth/presentation/views/login_screen.dart';
import 'package:real_state/features/onboarding/data/data_source/onboarding_data.dart';
import 'package:real_state/features/onboarding/presentations/views/on_boarding_items.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();

  int currentPage = 0;

  void nextPage() {
    if (currentPage == OnBoardingData.pages.length - 1) {
      return;
    }

    _controller.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {}, child: const Text("Skip")),
              ),

              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: OnBoardingData.pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (_, index) {
                    return OnBoardingItem(model: OnBoardingData.pages[index]);
                  },
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: OnBoardingData.pages.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.teal,
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 4,
                      dotColor: Colors.grey.shade300,
                    ),
                  ),

                  InkWell(
                    onTap: nextPage,
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: const BoxDecoration(
                        color: Colors.teal,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              CustomButton(
                borderRadius: 15,
                color: Color(0xff1597A8),
                isLoading: false,
                width: double.infinity,
                height: 50,
                data: currentPage == OnBoardingData.pages.length - 1
                    ? "Get Started"
                    : "Continue",
                onTap: () {
                  if (currentPage == OnBoardingData.pages.length - 1) {
                    CacheHelper().saveData(key: 'OnBoarding', value: true);
                    AppFunctions.navigateToAndFinish(context, LoginScreen());
                  } else {
                    nextPage();
                  }
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
