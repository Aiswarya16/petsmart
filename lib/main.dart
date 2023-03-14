import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pets/ui/screen/home_screen_section/accessories_section_screen.dart';
import 'package:pets/ui/screen/home_screen_section/accessories_section_screen.dart';
import 'package:pets/ui/screen/address.dart';
import 'package:pets/ui/screen/adoption_form.dart';

import 'package:pets/ui/screen/forgotpassword_screen.dart';
import 'package:pets/ui/screen/home_screen.dart';

import 'package:pets/ui/screen/home_screen_section/adoption_screen.dart';
import 'package:pets/ui/screen/home_screen_section/profile_screen.dart';

import 'package:pets/ui/screen/login_screen.dart';
import 'package:pets/ui/screen/accessories_details_screen.dart';
import 'package:pets/ui/screen/pet_details_screen.dart';

import 'package:pets/ui/screen/resetpassword_screen.dart';
import 'package:pets/ui/screen/signup_screen.dart';
import 'package:pets/ui/screen/signup_screen.dart';

import 'package:pets/ui/screen/verify_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'User',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen());
  }
}

// git add -A
// git commit -m " commit message "
// git push
