import 'package:flutter/material.dart';
import 'package:pets/ui/screen/login_screen.dart';
import 'package:pets/util/input_focus_out.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://twboseihwcgjstzwiydz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR3Ym9zZWlod2NnanN0endpeWR6Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4MTg5MjA5NiwiZXhwIjoxOTk3NDY4MDk2fQ.mwglsiZ4XQO9mNc1kAcJ1b-QPrEYWCilx3x0OCAtyJI',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        inputFocusOut(context);
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PetsMart',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          inputDecorationTheme: InputDecorationTheme(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            fillColor: Colors.pink[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.pink, width: 0.5),
            ),
          ),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}

// git add -A
// git commit -m " commit message "
// git push
