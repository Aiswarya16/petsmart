import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/blocs/manage_listings/manage_listings_bloc.dart';
import 'package:pets/ui/screen/listings/add_edit_listing_screen.dart';
import 'package:pets/ui/screen/pet_details_screen.dart';
import 'package:pets/ui/widget/custom_action_button.dart';
import 'package:pets/ui/widget/custom_alert_dialog.dart';
import 'package:pets/ui/widget/listing_card.dart';

import '../../widget/custom_progress_indicator.dart';

class ListingScreen extends StatefulWidget {
  final ManageListingsBloc manageListingsBloc;
  const ListingScreen({
    super.key,
    required this.manageListingsBloc,
  });

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ManageListingsBloc>(context).add(GetAllListingsEvent());
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomActionButton(
                  iconData: Icons.add,
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        title: 'Listing',
                        message: 'Enter the following details',
                        content: Flexible(
                          child: AddEditListingScreen(
                            manageListingsBloc: widget.manageListingsBloc,
                          ),
                        ),
                      ),
                    );
                  },
                  label: 'Add Listing',
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: state is ManageListingsSuccessState
                      ? state.listings.isNotEmpty
                          ? ListView.separated(
                              itemBuilder: (context, index) => ListingCard(
                                listingDetails: state.listings[index],
                                manageListingsBloc: widget.manageListingsBloc,
                                isOnListing: true,
                                onTap: () {},
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                              itemCount: state.listings.length,
                            )
                          : const Center(
                              child: Text('No Listings'),
                            )
                      : const Center(child: CustomProgressIndicator()),
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
