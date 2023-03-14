import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pets/ui/screen/home_screen_section/accessories_section_screen.dart';
import 'package:pets/ui/screen/home_screen_section/doctors_and_trainers_screen.dart';
import 'package:pets/ui/screen/home_screen_section/listing_screen.dart';
import 'package:pets/ui/screen/home_screen_section/profile_screen.dart';
import 'home_screen_section/adoption_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(
      length: 5,
      vsync: this,
    );
    super.initState();
  }

  String getName() {
    switch (_controller.index) {
      case 0:
        return 'Adopt a Friend';
      case 1:
        return 'Accessories';
      case 2:
        return 'Doctors and Trainers';
      case 3:
        return 'Profile';
      case 4:
        return 'Listing';

      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          getName(),
          style: GoogleFonts.piazzolla(
            textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _controller,
          children: const [
            AdoptionSection(),
            Accessories(),
            DoctorsAndTrainersScreen(),
            ProfileScreen(),
            ListingScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Color(
              0xFF3E65BD,
            ),
          ),
        ),
        color: const Color(0xFFF8EFF0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavBarItem(
                isSelected: _controller.index == 0,
                icon: Icons.home_outlined,
                onTap: () {
                  _controller.animateTo(0);
                  setState(() {});
                },
              ),
              NavBarItem(
                isSelected: _controller.index == 1,
                icon: Icons.category_outlined,
                onTap: () {
                  _controller.animateTo(1);
                  setState(() {});
                },
              ),
              NavBarItem(
                isSelected: _controller.index == 2,
                icon: Icons.notes_outlined,
                onTap: () {
                  _controller.animateTo(2);
                  setState(() {});
                },
              ),
              NavBarItem(
                isSelected: _controller.index == 3,
                icon: Icons.account_circle_outlined,
                onTap: () {
                  _controller.animateTo(3);
                  setState(() {});
                },
              ),
              NavBarItem(
                isSelected: _controller.index == 4,
                icon: Icons.format_list_bulleted,
                onTap: () {
                  _controller.animateTo(4);
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final Function() onTap;
  const NavBarItem({
    super.key,
    required this.icon,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(
              0xFF3E65BD,
            ),
            width: 2,
          ),
          color: isSelected
              ? const Color(
                  0xFF3E65BD,
                )
              : Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 40,
          color: isSelected
              ? Colors.white
              : const Color(
                  0xFF3E65BD,
                ),
        ),
      ),
    );
  }
}
