import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/blocs/categories/categories_bloc.dart';
import 'package:pets/ui/screen/pet_details_screen.dart';
import 'package:pets/ui/widget/categories_item.dart';
import 'package:pets/ui/widget/custom_progress_indicator.dart';
import 'package:pets/ui/widget/custom_search.dart';
import 'package:pets/ui/widget/listing_card.dart';

import '../../widget/custom_alert_dialog.dart';

class AdoptionSection extends StatefulWidget {
  const AdoptionSection({super.key});

  @override
  State<AdoptionSection> createState() => _AdoptionSectionState();
}

class _AdoptionSectionState extends State<AdoptionSection> {
  final CategoriesBloc categoriesBloc = CategoriesBloc();
  int selectedCategoryId = 0;
  String? query;

  @override
  void initState() {
    super.initState();
    categoriesBloc.add(GetAllCategoriesEvent());
  }

  void getProducts() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoriesBloc>.value(
      value: categoriesBloc,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomSearch(
              onSearch: (search) {
                query = search;
                getProducts();
              },
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
            BlocConsumer<CategoriesBloc, CategoriesState>(
              listener: (context, state) {
                if (state is CategoriesFailureState) {
                  showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      title: 'Failed',
                      message: state.message,
                      primaryButtonLabel: 'Ok',
                    ),
                  );
                }
              },
              builder: (context, state) {
                return SizedBox(
                  height: 100,
                  child: state is CategoriesSuccessState
                      ? state.categories.isNotEmpty
                          ? ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: [
                                AllCategory(
                                  isSelected: selectedCategoryId == 0,
                                  onPressed: () {
                                    selectedCategoryId = 0;
                                    setState(() {});
                                    getProducts();
                                  },
                                ),
                                const SizedBox(width: 10),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.categories.length,
                                  itemBuilder: (context, index) =>
                                      CategoriesItem(
                                    isSelected: selectedCategoryId ==
                                        state.categories[index]['id'],
                                    categoryDetails: state.categories[index],
                                    onSelect: (id) {
                                      selectedCategoryId = id;
                                      setState(() {});
                                      getProducts();
                                    },
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 10),
                                ),
                              ],
                            )
                          : const Text('Nothing')
                      : const Center(
                          child: CustomProgressIndicator(),
                        ),
                );
              },
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
              childAspectRatio: 1 / 1.35,
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
      ),
    );
  }
}

class AllCategory extends StatelessWidget {
  final Function() onPressed;
  final bool isSelected;
  const AllCategory({
    super.key,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? Colors.pink : Colors.pink[50],
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onPressed,
            child: SizedBox(
              height: 80,
              width: 80,
              child: Center(
                child: Icon(
                  Icons.pets,
                  color: isSelected ? Colors.pink[50] : Colors.pink,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          'All',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: isSelected ? Colors.pink : Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
