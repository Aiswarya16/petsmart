import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/blocs/suggestion/suggestion_bloc.dart';
import 'package:pets/ui/widget/custom_alert_dialog.dart';
import 'package:pets/util/value_validators.dart';

class AddSuggestionDialog extends StatefulWidget {
  const AddSuggestionDialog({
    super.key,
  });

  @override
  State<AddSuggestionDialog> createState() => _AddSuggestionDialogState();
}

class _AddSuggestionDialogState extends State<AddSuggestionDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _suggestionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: 'Suggestion',
      message: 'Send your valuable opinion to improve PetsMart.',
      content: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _suggestionController,
              maxLines: 3,
              validator: alphanumericWithSpecialCharsValidator,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0),
                ),
                hintText: 'Suggestion',
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      primaryButtonLabel: 'Send',
      primaryOnPressed: () {
        if (_formKey.currentState!.validate()) {
          BlocProvider.of<SuggestionBloc>(context).add(
            AddSuggestionEvent(
              suggestion: _suggestionController.text.trim(),
            ),
          );
          Navigator.pop(context);
        }
      },
      secondaryButtonLabel: 'Cancel',
    );
  }
}
