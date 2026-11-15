import 'package:flutter/material.dart';

import '../../../shared/widgets/destination_placeholder.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DestinationPlaceholder(
      title: 'Add',
      description: 'Create and capture items here.',
      icon: Icons.add_circle_rounded,
    );
  }
}
