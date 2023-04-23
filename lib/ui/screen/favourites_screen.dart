import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pets/blocs/manage_listings/manage_listings_bloc.dart';
import 'package:pets/ui/screen/pet_details_screen.dart';
import 'package:pets/ui/widget/listing_card.dart';

import '../widget/custom_alert_dialog.dart';
import '../widget/custom_progress_indicator.dart';

class FavouritesScreen extends StatefulWidget {
  final ManageListingsBloc manageListingsBloc;
  const FavouritesScreen({super.key, required this.manageListingsBloc});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    super.initState();
    widget.manageListingsBloc.add(GetOthersListingsEvent(favorite: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Favourites',
          style: GoogleFonts.piazzolla(
            textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.pink,
          ),
        ),
      ),
      body: BlocProvider<ManageListingsBloc>.value(
        value: widget.manageListingsBloc,
        child: BlocConsumer<ManageListingsBloc, ManageListingsState>(
          listener: (context, state) {
            if (state is ManageListingsFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failed',
                  message: state.message,
                  primaryButtonLabel: 'Ok',
                  primaryOnPressed: () {
                    widget.manageListingsBloc
                        .add(GetOthersListingsEvent(favorite: true));
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
                      height: 20,
                    ),
                    state is FavoriteListingsSuccessState
                        ? state.listings.isNotEmpty
                            ? GridView.count(
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
                                    manageListingsBloc: ManageListingsBloc(),
                                    listingDetails: state.listings[index],
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PetDetailsScreen(
                                            manageListingsBloc:
                                                widget.manageListingsBloc,
                                            listDetails: state.listings[index],
                                          ),
                                        ),
                                      );
                                      widget.manageListingsBloc.add(
                                          GetOthersListingsEvent(
                                              favorite: true));
                                    },
                                  ),
                                ),
                              )
                            : const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(30.0),
                                  child: Text('No Listings Found'),
                                ),
                              )
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.all(30.0),
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
        ),
      ),
    );
  }
}
