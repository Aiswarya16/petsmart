import 'package:flutter/material.dart';
import 'package:pets/ui/widget/custom_card.dart';

class ListingCard extends StatelessWidget {
  const ListingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://images.unsplash.com/photo-1676641244234-855100cee031?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Dobermann for sale',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(
              height: 2.5,
            ),
            Text(
              'Male',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.grey[800],
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '₹20000',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.red[800],
                    decoration: TextDecoration.lineThrough,
                  ),
            ),
            const SizedBox(
              height: 2.5,
            ),
            Text(
              '₹15000',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
