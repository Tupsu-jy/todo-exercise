import 'package:flutter/material.dart';
import 'package:frontend/widgets/notepad/desktop_notepads_view.dart';
import '../widgets/notepad/notepad_list.dart';
import '../providers/company_provider.dart';
import 'package:provider/provider.dart';

class NotepadsScreen extends StatelessWidget {
  const NotepadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if we're on a desktop-sized screen (wider than 600dp)
    final bool isDesktop = MediaQuery.of(context).size.width > 600;

    return Consumer<CompanyProvider>(
      builder: (context, companyProvider, child) {
        // Show loading indicator while companyId is null
        if (companyProvider.companyId == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // Desktop view - show all todo lists in a grid
        if (isDesktop) {
          return DesktopNotepadsView(companyId: companyProvider.companyId!);
        }

        // Mobile view - show list of notepads
        return NotepadList(companyId: companyProvider.companyId!);
      },
    );
  }
}
