import 'package:flutter/material.dart';
import 'package:pets/blocs/manage_listings/manage_listings_bloc.dart';
import 'package:pets/ui/screen/complaints.dart';
import 'package:pets/ui/screen/favourites_screen.dart';
import 'package:pets/ui/screen/login_screen.dart';
import 'package:pets/ui/screen/suggestions.dart';
import 'package:pets/ui/widget/change_password_dialog.dart';
import 'package:pets/ui/widget/custom_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  final ManageListingsBloc manageListingsBloc;
  const ProfileScreen({super.key, required this.manageListingsBloc});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                SettingsCard(
                  icon: Icons.report_outlined,
                  label: 'Complaints',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComplaintsScreen(),
                      ),
                    );
                  },
                ),
                SettingsCard(
                  icon: Icons.report_outlined,
                  label: 'Suggestions',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SuggestionsScreen(),
                      ),
                    );
                  },
                ),
                SettingsCard(
                  icon: Icons.favorite_border_outlined,
                  label: 'Favourites',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavouritesScreen(
                          manageListingsBloc: widget.manageListingsBloc,
                        ),
                      ),
                    );
                  },
                ),
                SettingsCard(
                  icon: Icons.lock_open_outlined,
                  label: 'Change Password',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (builder) => const ChangePasswordDialog(),
                    );
                  },
                ),
                SettingsCard(
                  icon: Icons.logout_outlined,
                  label: isLoading ? 'Logging out...' : 'Logout',
                  onTap: isLoading
                      ? () {}
                      : () async {
                          isLoading = true;
                          setState(() {});

                          await Supabase.instance.client.auth.signOut();

                          isLoading = false;
                          setState(() {});

                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => true,
                          );
                        },
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function() onTap;

  const SettingsCard({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.pink,
              size: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
