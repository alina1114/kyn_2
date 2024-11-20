import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyn_2/features/whatshot/feed/feed_screen.dart';
import 'package:kyn_2/features/whatshot/home/delegates/search_community_delegate.dart';

class WhatshotHomeScreen extends ConsumerWidget {
  const WhatshotHomeScreen({
    super.key,
  });

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'What\'s Hot',
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchCommunityDelegate(ref));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: const FeedScreen(),
    );
  }
}
