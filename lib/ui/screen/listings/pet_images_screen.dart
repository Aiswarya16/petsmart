import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pets/ui/widget/custom_progress_indicator.dart';

class PetImagesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> images;
  const PetImagesScreen({
    super.key,
    required this.images,
  });

  @override
  State<PetImagesScreen> createState() => _PetImagesScreenState();
}

class _PetImagesScreenState extends State<PetImagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Images',
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            // widget.images.isNotEmpty
            //     ?
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: List<Widget>.generate(
                    10,
                    (index) => Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://images.unsplash.com/photo-1676641244234-855100cee031?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.width - 40,
                                width: MediaQuery.of(context).size.width - 40,
                                progressIndicatorBuilder:
                                    (context, url, progress) => const Center(
                                  child: CustomProgressIndicator(),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                  top: 10,
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.delete_forever_outlined,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // : const Text(
            //     'No images found',
            //   ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
