import 'package:flutter/material.dart';

import '../widget/custom_button.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Forgot\nPassword',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'We need your registration email for reset password',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.black12,
                  hintText: 'Email address',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomButton(
                text: "Submit",
                onTap: () {},
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
