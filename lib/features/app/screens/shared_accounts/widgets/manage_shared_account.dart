import 'package:enginner_project/models/shared_account_model.dart';
import 'package:flutter/material.dart';

class ManageSharedAccountScreen extends StatelessWidget {
  const ManageSharedAccountScreen({super.key, required this.sharedAccount});

  final SharedAccountModel sharedAccount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sharedAccount.title),
      ),
      body: const Text('Siem'),
    );
  }
}
