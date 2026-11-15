import 'package:flutter/material.dart';

import '../../../shared/widgets/destination_placeholder.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DestinationPlaceholder(
      title: 'Settings',
      description: 'Personalize your HariniOS experience here.',
      icon: Icons.settings_rounded,
    );
  }
}
