import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:pets/ui/widget/custom_action_button.dart';
import 'package:pets/ui/widget/custom_icon_button.dart';
import 'package:url_launcher/url_launcher.dart';

class PetDetailsScreen extends StatefulWidget {
  const PetDetailsScreen({
    super.key,
  });

  @override
  State<PetDetailsScreen> createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.pink,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              isFavorite = !isFavorite;
              setState(() {});
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 20,
            ),
            FlutterCarousel.builder(
              itemCount: 4,
              itemBuilder: (context, itemIndex, pageViewIndex) => ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      'https://images.unsplash.com/photo-1676641244234-855100cee031?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                ),
              ),
              options: CarouselOptions(
                height: 300,
                enlargeCenterPage: true,
                showIndicator: true,
                slideIndicator: const CircularSlideIndicator(
                  currentIndicatorColor: Colors.pink,
                  indicatorBackgroundColor: Colors.white70,
                  indicatorRadius: 4,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dog',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Dobermann for sale',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(
                    height: 2.5,
                  ),
                  Text(
                    'Male',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[800],
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '₹20000',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.red[800],
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                  const SizedBox(
                    height: 2.5,
                  ),
                  Text(
                    '₹15000',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis a felis non ante porta suscipit. Mauris aliquam, lorem at tincidunt efficitur, nulla purus vehicula dolor, ultricies fermentum nibh enim et ligula. Sed ac viverra mi. Curabitur nec leo sodales, euismod mauris a, dignissim urna. Nunc accumsan purus ex, et eleifend ligula consectetur vel. Praesent scelerisque commodo ligula vitae rutrum. Aliquam pretium tortor et nunc dictum, ac lobortis tellus tempus. Mauris congue nunc sed massa iaculis ultrices vitae nec ipsum.',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  const Divider(
                    height: 30,
                    color: Colors.black54,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Posted by',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                          const SizedBox(
                            height: 2.5,
                          ),
                          Text(
                            'Peter',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Posted on',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                          const SizedBox(
                            height: 2.5,
                          ),
                          Text(
                            '19/04/2023',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'address line1, address line 2, some place',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(
                    height: 2.5,
                  ),
                  Text(
                    'some city',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(
                    height: 2.5,
                  ),
                  Text(
                    'some district',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(
                    height: 2.5,
                  ),
                  Text(
                    'Pin 670321',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomActionButton(
                    iconData: Icons.map_outlined,
                    onPressed: () {},
                    label: 'Location',
                    color: Colors.purple,
                  ),
                  const Divider(
                    height: 30,
                    color: Colors.black54,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomIconButton(
                          iconData: Icons.call_rounded,
                          onPressed: () async {
                            Uri uri = Uri.parse('tel:9876543210');
                            await launchUrl(
                              uri,
                            );
                          },
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 3,
                        child: CustomActionButton(
                          iconData: Icons.pets_outlined,
                          onPressed: () {},
                          label: 'Adopt',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
