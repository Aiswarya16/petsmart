import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pets/ui/widget/custom_button.dart';

class PetDetailsScreen extends StatelessWidget {
  const PetDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              child: Image.asset("assets/images/pomerian.png"),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pomeranian",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "₹15,000",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Female 2years",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: const Color(
                    0xFF3E65BD,
                  ),
                  fontSize: 18),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomDetailCard(
                  label: "2.5 Years",
                  text: "Age",
                ),
                CustomDetailCard(
                  label: "Female",
                  text: "Sex",
                ),
                CustomDetailCard(
                  label: "10kg",
                  text: "Weight",
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            RichText(
              text: TextSpan(
                text: 'About : ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                children: const <TextSpan>[
                  TextSpan(
                    text:
                        'Pomeranian are renowned for their perky, happy temperaments.They are lively and friendly.Rarely you find a snippy pomernian,but most are very sweet. ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 75,
              child: CustomButton(
                iconData: Icons.phone,
                buttonColor: Colors.blue[200],
                iconColor: Colors.blue,
                onTap: () {},
              ),
            ),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 300,
              child: CustomButton(
                text: "Adopt Now",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDetailCard extends StatelessWidget {
  final String label, text;
  const CustomDetailCard({
    super.key,
    required this.label,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
      color: const Color(
        0xFF3E65BD,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text(
              label,
              style: GoogleFonts.piazzolla(
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
              ),
            ),
            Text(
              text,
              style: GoogleFonts.piazzolla(
                textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
