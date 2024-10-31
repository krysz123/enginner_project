import 'package:enginner_project/common/widgets/buttons/button.dart';
import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/features/app/screens/shared_accounts/controllers/shared_account_form_controller.dart';
import 'package:enginner_project/utils/constants/colors.dart';
import 'package:enginner_project/utils/constants/validation.dart';
import 'package:enginner_project/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharedAccountForm extends StatelessWidget {
  const SharedAccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SharedAccountFormController());
    return Form(
      key: controller.sharedAccountFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: controller.title,
            hintText: 'Tytuł',
            validator: (value) => Validator.validateEmptyText('Tytuł', value),
          ),
          const SizedBox(height: 10),
          Text('Lista znajomych', style: TextAppTheme.textTheme.titleMedium),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: UserRepository.instance.streamFriendsList(),
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
                        Icons.person,
                        color: AppColors.textSecondaryColor,
                        size: 50,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Nie masz jeszcze znajomych',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              }

              final allFriends = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: allFriends.length,
                itemBuilder: (context, index) {
                  final friend = allFriends[index];

                  return Card(
                    color: AppColors.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              friend.fullname,
                              overflow: TextOverflow.ellipsis,
                              style: TextAppTheme.textTheme.titleMedium,
                            ),
                          ),
                          Obx(() {
                            final isMember = controller.checkIsKeyInMap(
                                controller.members, friend.id);
                            return InkWell(
                              splashColor: Colors.transparent,
                              onTap: () => isMember
                                  ? controller.deleteFromMembers(friend.id)
                                  : controller.addToMembers(friend.id),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      isMember
                                          ? AppColors.greenColorGradient
                                          : AppColors.redColorGradient,
                                      AppColors.blueButton
                                    ],
                                  ),
                                ),
                                child: Icon(
                                  isMember ? Icons.check : Icons.add,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Row(
            children: [
              const SizedBox(height: 100),
              Expanded(
                child: CustomButton(
                  text: 'Cofnij',
                  height: 40,
                  width: 12,
                  redirection: (() => Get.back()),
                  colorGradient1: AppColors.redColorGradient,
                  colorGradient2: AppColors.blueButton,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CustomButton(
                  text: 'Zapisz',
                  height: 40,
                  width: 12,
                  redirection: (() => controller.createNewSharedAccount()),
                  colorGradient1: AppColors.greenColorGradient,
                  colorGradient2: AppColors.blueButton,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
