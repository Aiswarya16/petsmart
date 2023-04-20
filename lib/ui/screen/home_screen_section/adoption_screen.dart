import 'package:flutter/material.dart';
import 'package:pets/ui/screen/pet_details_screen.dart';
import 'package:pets/ui/widget/categories_item.dart';
import 'package:pets/ui/widget/custom_button.dart';
import 'package:pets/ui/widget/custom_input_field.dart';
import 'package:pets/ui/widget/custom_item.dart';
import 'package:pets/ui/widget/custom_search.dart';
import 'package:pets/ui/widget/listing_card.dart';

class AdoptionSection extends StatefulWidget {
  const AdoptionSection({super.key});

  @override
  State<AdoptionSection> createState() => _AdoptionSectionState();
}

class _AdoptionSectionState extends State<AdoptionSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomSearch(
            onSearch: (search) {},
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Categories',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (context, index) => CategoriesItem(
                label: 'Dogs',
                onTap: () {},
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 1,
          ),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: 1 / 1.25,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.symmetric(vertical: 10),
            children: List<Widget>.generate(
              10,
              (index) => ListingCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PetDetailsScreen(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
