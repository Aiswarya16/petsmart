import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pets/blocs/complaint/complaint_bloc.dart';
import 'package:pets/ui/widget/add_complaint_dialog.dart';
import 'package:pets/ui/widget/complaint_card.dart';
import 'package:pets/ui/widget/custom_alert_dialog.dart';
import 'package:pets/ui/widget/custom_icon_button.dart';
import 'package:pets/ui/widget/custom_progress_indicator.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  ComplaintBloc complaintBloc = ComplaintBloc();

  @override
  void initState() {
    complaintBloc.add(GetAllComplaintEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Complaints',
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => BlocProvider<ComplaintBloc>.value(
                    value: complaintBloc,
                    child: const AddComplaintDialog(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.pink,
              ),
            ),
          ),
        ],
      ),
      body: BlocProvider<ComplaintBloc>.value(
        value: complaintBloc,
        child: BlocConsumer<ComplaintBloc, ComplaintState>(
          listener: (context, state) {
            if (state is ComplaintFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failure',
                  message: state.message,
                  primaryButtonLabel: 'Ok',
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
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: state is ComplaintLoadingState
                          ? const Center(
                              child: CustomProgressIndicator(),
                            )
                          : state is ComplaintSuccessState
                              ? state.complaints.isNotEmpty
                                  ? SingleChildScrollView(
                                      child: Wrap(
                                        spacing: 20,
                                        runSpacing: 20,
                                        children: List<Widget>.generate(
                                          state.complaints.length,
                                          (index) => ComplaintCard(
                                            complaint: state.complaints[index],
                                          ),
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Text('No complaints found'),
                                    )
                              : state is ComplaintFailureState
                                  ? Center(
                                      child: CustomIconButton(
                                        iconData: Icons.refresh_outlined,
                                        iconColor: Colors.pink,
                                        onPressed: () {
                                          complaintBloc
                                              .add(GetAllComplaintEvent());
                                        },
                                      ),
                                    )
                                  : const SizedBox(),
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
