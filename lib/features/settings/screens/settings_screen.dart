import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyn_2/core/theme/theme.dart';
import 'package:kyn_2/features/auth/controller/auth_controller.dart';
import 'package:kyn_2/features/settings/screens/app_settings_screen.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final theme = ref.watch(themeNotifierProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.indicatorColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              logOut(ref);
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
        centerTitle: true,
        title: Center(
          child: Text(
            'Settings',
            style: GoogleFonts.roboto(
              textStyle: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                          image: CachedNetworkImageProvider(user.profilePic),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user.name,
                      style: theme.textTheme.headlineSmall,
                    ),
                    Text(
                      user.email,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              Menu(
                title: 'Edit Profile',
                description: 'Update your profile',
                textStyle: theme.textTheme.headlineSmall,
                endIcon: Icons.keyboard_arrow_right,
                onpress: () {
                  //  Navigator.of(context).push(EditProfileScreen.route(user.uid));
                },
                icon: Icons.edit,
              ),
              const SizedBox(height: 5),
              Menu(
                title: 'My Activity',
                description: 'View your Activity History',
                textStyle: theme.textTheme.headlineSmall,
                endIcon: Icons.keyboard_arrow_right,
                onpress: () {},
                icon: Icons.menu,
              ),
              const SizedBox(height: 5),
              Menu(
                title: 'App Settings',
                description: 'Adjust your App Settings',
                textStyle: theme.textTheme.headlineSmall,
                endIcon: Icons.keyboard_arrow_right,
                onpress: () {
                  Navigator.of(context).push(SettingsScreen.route());
                },
                icon: Icons.settings,
              ),
              const Divider(),
              const SizedBox(height: 5),
              Menu(
                title: 'Invite a Friend',
                description: 'Invite your friends to join',
                textStyle: theme.textTheme.headlineSmall,
                endIcon: Icons.keyboard_arrow_right,
                onpress: () {},
                icon: Icons.person_add,
              ),
              Menu(
                title: 'Suggest a change',
                description: 'Help improve the app',
                textStyle: theme.textTheme.headlineSmall,
                endIcon: Icons.keyboard_arrow_right,
                onpress: () {},
                icon: Icons.settings_suggest_outlined,
              ),
              const SizedBox(height: 5),
              Menu(
                title: 'Help',
                description: 'Get support',
                textStyle: theme.textTheme.headlineSmall,
                endIcon: Icons.keyboard_arrow_right,
                onpress: () {},
                icon: Icons.help,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    required this.title,
    required this.description,
    required this.icon,
    required this.onpress,
    required this.endIcon,
    this.textStyle,
    super.key,
  });

  final String title;
  final String description;
  final TextStyle? textStyle;

  final IconData icon;
  final VoidCallback onpress;
  final IconData endIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              icon,
              size: 28,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textStyle?.copyWith(fontSize: 18),
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
          trailing: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(endIcon, size: 28),
          ),
        ),
      ),
    );
  }
}
