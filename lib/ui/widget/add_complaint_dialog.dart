import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/blocs/complaint/complaint_bloc.dart';
import 'package:pets/ui/widget/custom_alert_dialog.dart';
import 'package:pets/util/value_validators.dart';

class AddComplaintDialog extends StatefulWidget {
  const AddComplaintDialog({
    super.key,
  });

  @override
  State<AddComplaintDialog> createState() => _AddComplaintDialogState();
}

class _AddComplaintDialogState extends State<AddComplaintDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _complaintController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: 'Complaint',
      message: 'Send your concerns to PetsMart.',
      content: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _complaintController,
              maxLines: 3,
              validator: alphanumericWithSpecialCharsValidator,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0),
                ),
                hintText: 'Complaint',
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      primaryButtonLabel: 'Send',
      primaryOnPressed: () {
        if (_formKey.currentState!.validate()) {
          BlocProvider.of<ComplaintBloc>(context).add(
            AddComplaintEvent(
              complaint: _complaintController.text.trim(),
            ),
          );
          Navigator.pop(context);
        }
      },
      secondaryButtonLabel: 'Cancel',
    );
  }
}
