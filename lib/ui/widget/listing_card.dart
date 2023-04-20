import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pets/ui/screen/listings/add_edit_listing_screen.dart';
import 'package:pets/ui/screen/listings/pet_images_screen.dart';
import 'package:pets/ui/widget/custom_card.dart';
import 'package:pets/util/custom_file_picker.dart';

class ListingCard extends StatefulWidget {
  final bool isOnListing;
  final Function() onTap;
  const ListingCard({
    super.key,
    required this.onTap,
    this.isOnListing = false,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      IconButton(
                        splashRadius: 1,
                        onPressed: () async {
                          PlatformFile? file = await pickFile();
                          if (file != null) {}
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
                              builder: (context) => const PetImagesScreen(
                                images: [],
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AddEditListingScreen(),
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
                        onPressed: () {},
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
                ? Text(
                    'Pending',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
