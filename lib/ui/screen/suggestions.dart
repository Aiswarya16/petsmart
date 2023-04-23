import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pets/blocs/suggestion/suggestion_bloc.dart';
import 'package:pets/ui/widget/add_suggestion_dialog.dart';
import 'package:pets/ui/widget/custom_alert_dialog.dart';
import 'package:pets/ui/widget/custom_icon_button.dart';
import 'package:pets/ui/widget/custom_progress_indicator.dart';
import 'package:pets/ui/widget/suggestion_card.dart';

class SuggestionsScreen extends StatefulWidget {
  const SuggestionsScreen({super.key});

  @override
  State<SuggestionsScreen> createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  SuggestionBloc suggestionBloc = SuggestionBloc();

  @override
  void initState() {
    suggestionBloc.add(GetAllSuggestionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SuggestionBloc>.value(
      value: suggestionBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Suggestions',
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
                    builder: (context) => BlocProvider<SuggestionBloc>.value(
                      value: suggestionBloc,
                      child: const AddSuggestionDialog(),
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
        body: BlocConsumer<SuggestionBloc, SuggestionState>(
          listener: (context, state) {
            if (state is SuggestionFailureState) {
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
                      child: state is SuggestionLoadingState
                          ? const Center(
                              child: CustomProgressIndicator(),
                            )
                          : state is SuggestionSuccessState
                              ? state.suggestions.isNotEmpty
                                  ? SingleChildScrollView(
                                      child: Wrap(
                                        spacing: 20,
                                        runSpacing: 20,
                                        children: List<Widget>.generate(
                                          state.suggestions.length,
                                          (index) => SuggestionCard(
                                            suggestion:
                                                state.suggestions[index],
                                          ),
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Text('No Suggestions found'),
                                    )
                              : state is SuggestionFailureState
                                  ? Center(
                                      child: CustomIconButton(
                                        iconData: Icons.refresh_outlined,
                                        iconColor: Colors.pink,
                                        onPressed: () {
                                          suggestionBloc
                                              .add(GetAllSuggestionEvent());
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
