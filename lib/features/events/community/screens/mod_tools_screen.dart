import 'package:flutter/material.dart';
import 'package:kyn_2/features/events/community/screens/add_mods_screen.dart';
import 'package:kyn_2/features/events/community/screens/edit_community_screen.dart';

class ModToolsScreen extends StatelessWidget {
  static Route<dynamic> route(String name) => MaterialPageRoute(
        builder: (context) => ModToolsScreen(name: name),
      );
  final String name;

  const ModToolsScreen({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod Tools'),
      ),
      body: Column(
        children: [
          ListTile(
              leading: const Icon(Icons.add_moderator),
              title: const Text('Add Moderators'),
              onTap: () =>
                  Navigator.of(context).push(AddModsScreen.route(name))),
          ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Community'),
              onTap: () =>
                  Navigator.of(context).push(EditCommunityScreen.route(name))),
        ],
      ),
    );
  }
}
