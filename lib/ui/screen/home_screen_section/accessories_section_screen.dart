import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pets/ui/screen/home_screen_section/adoption_screen.dart';
import 'package:pets/ui/widget/categories_item.dart';
import 'package:pets/ui/widget/custom_input_field.dart';
import 'package:pets/ui/widget/custom_item.dart';

class Accessories extends StatelessWidget {
  const Accessories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomInputField(),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 15,
                children: [
                  CategoriesItem(
                    imagePath: 'assets/images/cat.png',
                    onTap: () {},
                  ),
                  CategoriesItem(
                    imagePath: 'assets/images/dogs.png',
                    onTap: () {},
                  ),
                  CategoriesItem(
                    imagePath: 'assets/images/fish.png',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 1 / 1.5,
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                padding: EdgeInsets.symmetric(vertical: 10),
                children: List<Widget>.generate(
                  10,
                  (index) => CustomItem(
                    image: 'assets/images/plate.png',
                    title: 'Furever  Stainless',
                    subtitleOne: 'Steelfeeder (700ML)',
                    subtitleTwo: '2500',
                    onTap: () {},
                  ),
                ),
              ),
              // Wrap(
              //   spacing: 10,
              //   children: List<Widget>.generate(
              //     10,
              //     (index) => CustomItem(
              //       image: 'assets/images/plate.png',
              //       title: 'Furever  Stainless',
              //       subtitleOne: 'Steelfeeder (700ML)',
              //       subtitleTwo: '2500',
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
