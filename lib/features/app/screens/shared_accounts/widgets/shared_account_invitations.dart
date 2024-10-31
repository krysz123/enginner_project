import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/models/shared_account_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class SharedAccountInvitations extends StatelessWidget {
  const SharedAccountInvitations({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Zaproszenia',
            style: TextAppTheme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<List<SharedAccountModel>>(
              stream: UserRepository.instance.streamSharedAccountInvitations(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Błąd: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.blinds_closed,
                          color: AppColors.textSecondaryColor,
                          size: 50,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Nie masz jeszcze żadnych zaproszeń',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                }

                final allInvitations = snapshot.data!;

                return ListView.builder(
                  itemCount: allInvitations.length,
                  itemBuilder: (context, index) {
                    final singleInvitation = allInvitations[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        onLongPress: () {},
                        child: Card(
                          color: AppColors.secondary,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Column(
                              children: [
                                Text(
                                  'Otrzymałeś zaproszenie do ${singleInvitation.title} od ${singleInvitation.owner}',
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                          text: 'Akceptuj',
                                          height: 40,
                                          width: 1,
                                          redirection: () => UserRepository
                                              .instance
                                              .acceptInviteToSharedAccount(
                                                  AuthenticationRepository
                                                      .instance.authUser!.uid,
                                                  singleInvitation.id),
                                          colorGradient1:
                                              AppColors.greenColorGradient,
                                          colorGradient2: AppColors.blueButton),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: CustomButton(
                                          text: 'Odrzuć',
                                          height: 40,
                                          width: 1,
                                          redirection: () => UserRepository
                                              .instance
                                              .rejectInviteToSharedAccount(
                                                  AuthenticationRepository
                                                      .instance.authUser!.uid,
                                                  singleInvitation.id),
                                          colorGradient1:
                                              AppColors.redColorGradient,
                                          colorGradient2: AppColors.blueButton),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
