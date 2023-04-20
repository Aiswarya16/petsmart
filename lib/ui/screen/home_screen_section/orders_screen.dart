import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pets/ui/screen/pet_details_screen.dart';
import 'package:pets/ui/widget/listing_card.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int? groupValue = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            CupertinoSlidingSegmentedControl(
              backgroundColor: Colors.pink[50]!,
              thumbColor: Colors.pink[50]!,
              groupValue: groupValue,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              children: {
                0: Material(
                  borderRadius: BorderRadius.circular(5),
                  color: groupValue == 0 ? Colors.pink : Colors.pink[50],
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Center(
                      child: Text(
                        'Ordered',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color:
                                  groupValue == 0 ? Colors.white : Colors.pink,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                ),
                1: Material(
                  borderRadius: BorderRadius.circular(5),
                  color: groupValue == 1 ? Colors.pink : Colors.pink[50],
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Center(
                      child: Text(
                        'Picked',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color:
                                  groupValue == 1 ? Colors.white : Colors.pink,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                ),
              },
              onValueChanged: (value) {
                groupValue = value;
                setState(() {});
              },
            ),
            const Divider(
              color: Colors.black54,
              height: 20,
            ),
            groupValue == 0
                ? Expanded(
                    child: SingleChildScrollView(
                      child: GridView.count(
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
                                  builder: (context) =>
                                      const PetDetailsScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: GridView.count(
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
                                  builder: (context) =>
                                      const PetDetailsScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
