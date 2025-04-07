import 'package:flutter/material.dart';
import 'package:todo_app/data/model/onboarding_model.dart';

import '../../../core/config/routes.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) => buildPage(
              image: onboardingData[index].image,
              title: onboardingData[index].title,
              subtitle: onboardingData[index].subtitle,
            ),
          ),

          /// Skip tugmasi
          Positioned(
            top: 40,
            left: 20,
            child: TextButton(
              onPressed: () =>
                  _controller.jumpToPage(onboardingData.length - 1),
              child: Text(
                'SKIP',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ),

          /// Indicatorlar va tugmalar
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                /// Indicatorlar (3 ta nuqta)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                    (index) => buildIndicator(index),
                  ),
                ),
                SizedBox(height: 20),

                /// Tugmalar
                currentPage == onboardingData.length - 1
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => _controller.previousPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease),
                            child: Text(
                              'back',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: () {
                              // Onboarding tugadi, asosiy sahifaga o'tish
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.splash,
                                (route) => false,
                              );
                            },
                            child: Text(
                              'start',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => _controller.previousPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease),
                            child: Text(
                              'back',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: () => _controller.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease),
                            child: Text(
                              'next',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Sahifa yaratish
  Widget buildPage(
      {required String image,
      required String title,
      required String subtitle}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 300),
          SizedBox(height: 20),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  /// Indicator yaratish (sahifalar o'rtasida ko'rsatish uchun)
  Widget buildIndicator(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 4,
      width: currentPage == index ? 26 : 26,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Theme.of(context).colorScheme.onPrimary
            : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
