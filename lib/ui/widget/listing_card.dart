import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pets/blocs/manage_listings/manage_listings_bloc.dart';
import 'package:pets/ui/screen/listings/pet_images_screen.dart';
import 'package:pets/ui/widget/custom_card.dart';
import 'package:pets/ui/widget/label_with_text.dart';
import 'package:pets/util/custom_file_picker.dart';

import '../screen/listings/add_edit_listing_screen.dart';
import 'custom_alert_dialog.dart';

class ListingCard extends StatefulWidget {
  final ManageListingsBloc manageListingsBloc;
  final dynamic listingDetails;
  final bool isOnListing;
  final Function() onTap;
  const ListingCard({
    super.key,
    required this.onTap,
    this.isOnListing = false,
    required this.manageListingsBloc,
    required this.listingDetails,
  });

  @override
  State<ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<ListingCard> {
  PlatformFile? selectedFile;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onPressed: widget.isOnListing ? null : widget.onTap,
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
                  widget.listingDetails['images'][0]['image_url'],
                  fit: BoxFit.cover,
                  width: (MediaQuery.of(context).size.width - 100) / 2,
                  height: (MediaQuery.of(context).size.width - 100) / 2,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.listingDetails['title'],
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(
              height: 2.5,
            ),
            Text(
              widget.listingDetails['gender'],
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.grey[800],
                  ),
            ),
            const SizedBox(
              height: 2.5,
            ),
            Text(
              widget.listingDetails['age'],
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.grey[800],
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '₹${widget.listingDetails['price'].toString()}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.red[800],
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                      const SizedBox(
                        height: 2.5,
                      ),
                      Text(
                        '₹${widget.listingDetails['discounted_price'].toString()}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            widget.isOnListing && widget.listingDetails['status'] == 'pending'
                ? const Divider(
                    color: Colors.white,
                    thickness: 1,
                    height: 20,
                  )
                : const SizedBox(),
            widget.isOnListing && widget.listingDetails['status'] == 'pending'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        splashRadius: 1,
                        onPressed: () async {
                          PlatformFile? file = await pickFile();
                          if (file != null) {
                            widget.manageListingsBloc.add(
                              UploadImageListingsEvent(
                                listingId: widget.listingDetails['id'],
                                image: file,
                              ),
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.purple,
                          size: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        splashRadius: 1,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PetImagesScreen(
                                images: widget.listingDetails['images'],
                                manageListingsBloc: widget.manageListingsBloc,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.image_outlined,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        splashRadius: 1,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => CustomAlertDialog(
                              title: 'Listing',
                              message: 'Enter the following details',
                              content: Flexible(
                                child: AddEditListingScreen(
                                  manageListingsBloc: widget.manageListingsBloc,
                                  listingDetails: widget.listingDetails,
                                ),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: Colors.orange,
                          size: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        splashRadius: 1,
                        onPressed: () {
                          widget.manageListingsBloc.add(DeleteListingsEvent(
                              listingId: widget.listingDetails['id']));
                        },
                        icon: const Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.red,
                          size: 25,
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            widget.isOnListing
                ? const Divider(
                    color: Colors.white,
                    thickness: 1,
                    height: 20,
                  )
                : const SizedBox(),
            widget.isOnListing
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.listingDetails['status']
                            .toString()
                            .toUpperCase(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  )
                : const SizedBox(),
            widget.isOnListing && widget.listingDetails['status'] != 'pending'
                ? const Divider(
                    color: Colors.white,
                    thickness: 1,
                    height: 20,
                  )
                : const SizedBox(),
            widget.isOnListing && widget.listingDetails['status'] != 'pending'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelWithText(
                        label: 'Bought By',
                        text: widget.listingDetails['bought_user']['name'],
                      ),
                      LabelWithText(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        label: 'Phone Number',
                        text: widget.listingDetails['bought_user']['phone'],
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
