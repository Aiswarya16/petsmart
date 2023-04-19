import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pets/ui/screen/home_screen_section/doctors_and_trainers_screen.dart';
import 'package:pets/ui/screen/home_screen_section/listing_screen.dart';
import 'package:pets/ui/screen/home_screen_section/orders_screen.dart';
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
        return 'PetsMart';
      case 1:
        return 'Listing';
      case 2:
        return 'Doctors and Trainers';
      case 3:
        return 'Orders';
      case 4:
        return 'Profile';

      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          getName(),
          style: GoogleFonts.piazzolla(
            textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.exit_to_app_outlined,
                color: Colors.pink,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _controller,
          children: const [
            AdoptionSection(),
            ListingScreen(),
            DoctorsAndTrainersScreen(),
            OrdersScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
        ),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: Colors.pink,
            ),
          ),
          color: Colors.pink[50],
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavBarItem(
                  isSelected: _controller.index == 0,
                  icon: Icons.pets_outlined,
                  onTap: () {
                    _controller.animateTo(0);
                    setState(() {});
                  },
                ),
                NavBarItem(
                  isSelected: _controller.index == 1,
                  icon: Icons.list_alt_outlined,
                  onTap: () {
                    _controller.animateTo(1);
                    setState(() {});
                  },
                ),
                NavBarItem(
                  isSelected: _controller.index == 2,
                  icon: Icons.medication_liquid_outlined,
                  onTap: () {
                    _controller.animateTo(2);
                    setState(() {});
                  },
                ),
                NavBarItem(
                  isSelected: _controller.index == 3,
                  icon: Icons.sell_outlined,
                  onTap: () {
                    _controller.animateTo(3);
                    setState(() {});
                  },
                ),
                NavBarItem(
                  isSelected: _controller.index == 4,
                  icon: Icons.person_2_outlined,
                  onTap: () {
                    _controller.animateTo(4);
                    setState(() {});
                  },
                ),
              ],
            ),
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
      child:
          Icon(icon, size: 30, color: isSelected ? Colors.pink : Colors.grey),
    );
  }
}
