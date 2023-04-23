import 'package:flutter/material.dart';
import 'package:pets/ui/widget/custom_card.dart';
import 'package:pets/ui/widget/custom_icon_button.dart';
import 'package:pets/ui/widget/label_with_text.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorTrainerCard extends StatefulWidget {
  final dynamic docTrainDetails;
  const DoctorTrainerCard({
    super.key,
    required this.docTrainDetails,
  });

  @override
  State<DoctorTrainerCard> createState() => _DoctorTrainerCardState();
}

class _DoctorTrainerCardState extends State<DoctorTrainerCard> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: LabelWithText(
                    label: 'Name',
                    text: widget.docTrainDetails['name'],
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    label: 'Phone',
                    text: widget.docTrainDetails['phone'],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: LabelWithText(
                    label: 'Address',
                    text: widget.docTrainDetails['address_line'],
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    label: 'Place',
                    text: widget.docTrainDetails['place'],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: LabelWithText(
                    label: 'District',
                    text: widget.docTrainDetails['district'],
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    label: 'State',
                    text: widget.docTrainDetails['state'],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            LabelWithText(
              label: 'Pin',
              text: widget.docTrainDetails['pin_code'],
            ),
            const Divider(
              color: Colors.black54,
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomIconButton(
                    iconData: Icons.call_outlined,
                    color: Colors.green[600]!,
                    onPressed: () {
                      launchUrl(
                        Uri.parse('tel:${widget.docTrainDetails['phone']}'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
