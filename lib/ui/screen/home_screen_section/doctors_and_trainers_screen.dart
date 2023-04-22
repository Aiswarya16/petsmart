import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/blocs/docs_trains/docs_trains_bloc.dart';
import 'package:pets/ui/widget/custom_progress_indicator.dart';
import 'package:pets/ui/widget/doctor_card.dart';

import '../../widget/custom_alert_dialog.dart';

class DoctorsAndTrainersScreen extends StatefulWidget {
  const DoctorsAndTrainersScreen({super.key});

  @override
  State<DoctorsAndTrainersScreen> createState() =>
      _DoctorsAndTrainersScreenState();
}

class _DoctorsAndTrainersScreenState extends State<DoctorsAndTrainersScreen> {
  String groupValue = 'doctor';
  final DocsTrainsBloc docsTrainsBloc = DocsTrainsBloc();

  @override
  void initState() {
    super.initState();
    docsTrainsBloc.add(GetAllDocsTrainsEvent(type: 'doctor'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: BlocProvider<DocsTrainsBloc>.value(
          value: docsTrainsBloc,
          child: BlocConsumer<DocsTrainsBloc, DocsTrainsState>(
            listener: (context, state) {
              if (state is DocsTrainsFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failed',
                    message: state.message,
                    primaryButtonLabel: 'Ok',
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
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
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                      'trainer': Text(
                        'Trainers',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    },
                    onValueChanged: (value) {
                      groupValue = value ?? 'doctor';
                      docsTrainsBloc
                          .add(GetAllDocsTrainsEvent(type: groupValue));

                      setState(() {});
                    },
                  ),
                  const Divider(
                    color: Colors.black54,
                    height: 20,
                  ),
                  Expanded(
                    child: state is DocsTrainsSuccessState
                        ? state.docsTrains.isNotEmpty
                            ? ListView.separated(
                                itemBuilder: (context, index) =>
                                    DoctorTrainerCard(
                                  docTrainDetails: state.docsTrains[index],
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                itemCount: state.docsTrains.length,
                              )
                            : const Center(
                                child: Text('Not found'),
                              )
                        : const Center(
                            child: CustomProgressIndicator(),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
