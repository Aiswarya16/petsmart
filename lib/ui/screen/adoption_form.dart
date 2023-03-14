import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pets/ui/widget/custom_button.dart';

class AdoptionForm extends StatefulWidget {
  const AdoptionForm({super.key});

  @override
  State<AdoptionForm> createState() => _AdoptionFormState();
}

class _AdoptionFormState extends State<AdoptionForm> {
  bool previouslyAdopted = false, isYes = false, isNo = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        title: Center(
          child: Text("Adoption Form",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Fill these form for adoption",
                  style: Theme.of(context).textTheme.titleLarge),
              SizedBox(
                height: 10,
              ),
              Material(
                child: SizedBox(
                  height: 150,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/pomerian.png",
                          height: double.infinity,
                          width: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text("Pomeranian",
                              style: Theme.of(context).textTheme.titleLarge),
                          SizedBox(
                            height: 5,
                          ),
                          Text("₹15,000",
                              style: Theme.of(context).textTheme.titleLarge),
                          SizedBox(
                            height: 65,
                          ),
                          Row(
                            children: [
                              Text("2.5 years",
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              SizedBox(
                                width: 15,
                              ),
                              Text("Female",
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              SizedBox(
                                width: 15,
                              ),
                              Text("10kg",
                                  style:
                                      Theme.of(context).textTheme.titleMedium)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                color: Colors.white,
                elevation: 5,
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: Material(
                  color: Colors.white,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("My pets",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(Icons.mail_outline),
                            SizedBox(
                              width: 5,
                            ),
                            Text("mypets@gmail.com",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(Icons.phone),
                            SizedBox(
                              width: 5,
                            ),
                            Text("+91 97856 *****",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Living address",
                  style: Theme.of(context).textTheme.titleLarge),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter address",
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                maxLines: 5,
              ),
              SizedBox(
                height: 10,
              ),
              Text("Have you previously",
                  style: Theme.of(context).textTheme.titleLarge),
              Row(
                children: [
                  Row(
                    children: [
                      Text(
                        "Yes",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Radio(
                        value: isYes,
                        groupValue: true,
                        onChanged: (value) {
                          previouslyAdopted = value!;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        "No",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Radio(
                        value: isNo,
                        groupValue: false,
                        onChanged: (value) {
                          previouslyAdopted = value!;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text("Why do you want to adopt?",
                  style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}
