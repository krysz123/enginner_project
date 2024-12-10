import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class InvitationInfo extends StatelessWidget {
  final Stream<int> friendsCountStream;

  const InvitationInfo({super.key, required this.friendsCountStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: friendsCountStream,
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
            child: Text(
              '${snapshot.data!}',
            ),
          );
        }
      },
    );
  }
}
