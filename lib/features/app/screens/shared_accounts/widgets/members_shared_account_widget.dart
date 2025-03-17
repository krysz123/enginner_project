import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/models/shared_account_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class MembersSharedAccountWidget extends StatelessWidget {
  const MembersSharedAccountWidget({
    super.key,
    required this.sharedAccount,
  });

  final SharedAccountModel sharedAccount;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, String>>>(
      stream: UserRepository.instance
          .streamUsersToSharedAccount(sharedAccount.id, true),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Błąd: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Nie odnaleziono znajomych');
        }

        final friends = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: friends.length,
          itemBuilder: (context, index) {
            final friend = friends[index];
            return Card(
              color: AppColors.secondary,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${friend['FirstName']} ${friend['LastName']}',
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 3,
                        style: TextAppTheme.textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
