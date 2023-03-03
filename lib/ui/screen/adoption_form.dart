import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pets/ui/widget/custom_button.dart';

class AdoptionForm extends StatelessWidget {
  const AdoptionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              child: Row(
                children: [
                  Text("ashjjksdhjkdshfhjj"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("ashjjksdhjkdshfhjj"),
                ],
              ),
              color: Colors.white,
              elevation: 5,
            ),
          ],
        ),
      ),
    );
  }
}
