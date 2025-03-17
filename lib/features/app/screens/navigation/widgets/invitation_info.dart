import 'package:enginner_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  final Stream<int> stream;

  const InfoWidget({super.key, required this.stream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == 0) {
          return const SizedBox();
        } else {
          return Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              color: AppColors.deleteExpenseColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text('${snapshot.data!}'),
          );
        }
      },
    );
  }
}
