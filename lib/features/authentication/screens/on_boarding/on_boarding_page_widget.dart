import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.height,
    required this.color,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.lastPage,
  });

  final double height;
  final Color color;
  final String image;
  final String title;
  final String subTitle;
  final bool lastPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.sm),
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(image: AssetImage(image), height: height * 0.4),
          Center(
            child: Column(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                lastPage
                    ? SizedBox(
                        height: 30,
                        width: 100,
                        child: Container(
                          color: AppColors.blueButton,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}
