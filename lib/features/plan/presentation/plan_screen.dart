import 'package:flutter/material.dart';

import '../../../shared/widgets/destination_placeholder.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DestinationPlaceholder(
      title: 'Plan',
      description: 'Your daily and weekly plans will live here.',
      icon: Icons.calendar_month_rounded,
    );
  }
}
