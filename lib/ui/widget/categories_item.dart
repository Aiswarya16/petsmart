import 'package:flutter/material.dart';

class CategoriesItem extends StatelessWidget {
  final dynamic categoryDetails;
  final Function(int) onSelect;
  final bool isSelected;
  const CategoriesItem({
    super.key,
    this.categoryDetails,
    required this.onSelect,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                onSelect(categoryDetails['id']);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    categoryDetails['image_url'],
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  if (isSelected)
                    Container(
                      height: 80,
                      width: 80,
                      color: Colors.pink.withOpacity(.5),
                    ),
                  if (isSelected)
                    const Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          categoryDetails['category'] ?? '',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: isSelected ? Colors.pink : Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
