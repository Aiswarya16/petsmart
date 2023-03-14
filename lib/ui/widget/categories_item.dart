import 'package:flutter/material.dart';

class CategoriesItem extends StatelessWidget {
  final String imagePath;
  final String? label;
  final Function() onTap;
  const CategoriesItem({
    super.key,
    required this.imagePath,
    this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imagePath,
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            label ?? '',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
