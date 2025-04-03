import 'package:flutter/material.dart';
import '../widgets/notepad_list.dart';
import '../providers/company_provider.dart';
import 'package:provider/provider.dart';

class NotepadsScreen extends StatelessWidget {
  const NotepadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(
      builder: (context, companyProvider, child) {
        // Show loading indicator while companyId is null
        if (companyProvider.companyId == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return NotepadList(companyId: companyProvider.companyId!);
      },
    );
  }
}
