import 'package:flutter/material.dart';

class AccessoriesSection extends StatefulWidget {
  const AccessoriesSection({super.key});

  @override
  State<AccessoriesSection> createState() => _AccessoriesSectionState();
}

class _AccessoriesSectionState extends State<AccessoriesSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('Accessories screen')],
    );
  }
}
