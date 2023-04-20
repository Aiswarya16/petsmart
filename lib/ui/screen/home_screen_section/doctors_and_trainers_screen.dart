import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pets/ui/widget/doctor_card.dart';
import 'package:pets/ui/widget/trainer_card.dart';

class DoctorsAndTrainersScreen extends StatefulWidget {
  const DoctorsAndTrainersScreen({super.key});

  @override
  State<DoctorsAndTrainersScreen> createState() =>
      _DoctorsAndTrainersScreenState();
}

class _DoctorsAndTrainersScreenState extends State<DoctorsAndTrainersScreen> {
  String? groupValue = 'doctor';
  @override
  Widget build(BuildContext context) {
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
                'doctor': Text(
                  'Doctors',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                'trainer': Text(
                  'Trainers',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              },
              onValueChanged: (value) {
                groupValue = value;
                setState(() {});
              },
            ),
            const Divider(
              color: Colors.black54,
              height: 20,
            ),
            groupValue == 'doctor'
                ? Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: List<Widget>.generate(
                          10,
                          (index) => const DoctorCard(),
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: List<Widget>.generate(
                          10,
                          (index) => const TrainerCard(),
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
