import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/widgets/shared_account_main_screen.dart';
import 'package:enginner_project/models/shared_account_model.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SharedAccountsList extends StatelessWidget {
  const SharedAccountsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Lista rachunków wspólnych',
            style: TextAppTheme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<List<SharedAccountModel>>(
              stream: UserRepository.instance.streamSharedAccounts(),
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
                          'Nie masz jeszcze żadnych wspólnych rachunków',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                }

                final allSharedAccounts = snapshot.data!;

                return ListView.builder(
                  itemCount: allSharedAccounts.length,
                  itemBuilder: (context, index) {
                    final singleSharedAccount = allSharedAccounts[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        onTap: () => Get.to(
                          () => SharedAccountMainScreen(
                            sharedAccount: singleSharedAccount,
                          ),
                        ),
                        child: Card(
                          color: AppColors.secondary,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Column(
                              children: [
                                singleSharedAccount.owner ==
                                        AuthenticationRepository
                                            .instance.authUser!.email
                                    ? const FaIcon(FontAwesomeIcons.crown)
                                    : const SizedBox(),
                                Text(
                                  singleSharedAccount.title,
                                  style: TextAppTheme.textTheme.titleLarge,
                                ),
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
