import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/blocs/manage_listings/manage_listings_bloc.dart';
import 'package:pets/ui/screen/pet_details_screen.dart';
import 'package:pets/ui/widget/custom_progress_indicator.dart';
import 'package:pets/ui/widget/listing_card.dart';

import '../../widget/custom_alert_dialog.dart';

class OrdersScreen extends StatefulWidget {
  final ManageListingsBloc manageListingsBloc;
  const OrdersScreen({
    super.key,
    required this.manageListingsBloc,
  });

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String groupValue = 'ordered';

  void getOrders() {
    widget.manageListingsBloc.add(GetMyOrderListingsEvent(status: groupValue));
  }

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageListingsBloc, ManageListingsState>(
      listener: (context, state) {
        if (state is ManageListingsFailureState) {
          showDialog(
            context: context,
            builder: (context) => CustomAlertDialog(
              title: 'Failed',
              message: state.message,
              primaryButtonLabel: 'Ok',
              primaryOnPressed: () {
                widget.manageListingsBloc.add(GetAllListingsEvent());
                Navigator.pop(context);
              },
            ),
          );
        }
      },
      builder: (context, state) {
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
                    vertical: 10,
                  ),
                  children: {
                    'ordered': Text(
                      'Ordered',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    'complete': Text(
                      'Completed',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  },
                  onValueChanged: (value) {
                    groupValue = value ?? 'ordered';
                    setState(() {});
                    getOrders();
                  },
                ),
                const Divider(
                  color: Colors.black54,
                  height: 20,
                ),
                Expanded(
                  child: state is MyOrdersListingsSuccessState
                      ? state.listings.isNotEmpty
                          ? SingleChildScrollView(
                              child: GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                childAspectRatio: 1 / 1.65,
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                children: List<Widget>.generate(
                                  state.listings.length,
                                  (index) => ListingCard(
                                    listingDetails: state.listings[index],
                                    manageListingsBloc:
                                        widget.manageListingsBloc,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PetDetailsScreen(
                                            listDetails: state.listings[index],
                                            manageListingsBloc:
                                                widget.manageListingsBloc,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          : const Center(
                              child: Text('No orders'),
                            )
                      : const Center(
                          child: CustomProgressIndicator(),
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
