import 'package:flutter/material.dart';
import 'package:pets/ui/widget/custom_button.dart';
import 'package:pets/ui/widget/custom_input_field.dart';

class AdoptionSection extends StatefulWidget {
  const AdoptionSection({super.key});

  @override
  State<AdoptionSection> createState() => _AdoptionSectionState();
}

class _AdoptionSectionState extends State<AdoptionSection> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CustomInputField(),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Material(
              borderRadius: BorderRadiusDirectional.circular(10),
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pet Adoption",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Made easy",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: CustomButton(
                            text: "Shop Now",
                            onTap: () {},
                            buttonColor: Colors.white,
                            labelColor: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Categories',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  'View All',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Wrap(
            spacing: 15,
            children: [
              CategoriesItem(
                imagePath: 'assets/images/cat.png',
                label: 'Cats',
                onTap: () {},
              ),
              CategoriesItem(
                imagePath: 'assets/images/dogs.png',
                label: 'Dogs',
                onTap: () {},
              ),
              CategoriesItem(
                imagePath: 'assets/images/fish.png',
                label: 'Fish',
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Our picks for you',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  'View All',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
          ],
        ),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          childAspectRatio: 1 / 1.5,
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          padding: EdgeInsets.symmetric(vertical: 10),
          children: [
            PetItem(),
            PetItem(),
          ],
        ),
      ],
    );
  }
}

class PetItem extends StatelessWidget {
  const PetItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/nintendogs.png'),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Nintendogs',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '30,000',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Female 2 years',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesItem extends StatelessWidget {
  final String imagePath, label;
  final Function() onTap;
  const CategoriesItem({
    super.key,
    required this.imagePath,
    required this.label,
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
            label,
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
