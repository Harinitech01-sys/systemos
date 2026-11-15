import 'package:flutter/material.dart';

import '../../../shared/widgets/destination_placeholder.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DestinationPlaceholder(
      title: 'Insights',
      description: 'Your progress and patterns will appear here.',
      icon: Icons.insights_rounded,
    );
  }
}
