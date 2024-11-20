import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyn_2/core/common/error_text.dart';
import 'package:kyn_2/core/common/loader.dart';
import 'package:kyn_2/features/whatshot/community/controller/community_controller.dart';
import 'package:kyn_2/features/whatshot/community/screens/community_screens.dart';
import 'package:kyn_2/features/whatshot/community/screens/create_community_screen.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: const Text('Create a community'),
              leading: const Icon(Icons.add),
              onTap: () {
                Navigator.of(context).push(CreateCommunityScreen.route());
              },
            ),
            ref.watch(userCommunitiesProvider).when(
                data: (communities) => Expanded(
                      child: ListView.builder(
                        itemCount: communities.length,
                        itemBuilder: (BuildContext context, int index) {
                          final community = communities[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                community.avatar,
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            title: Text('r/${community.name}'),
                            onTap: () {
                              Navigator.of(context)
                                  .push(CommunityScreen.route(community.name));
                            },
                          );
                        },
                      ),
                    ),
                error: (error, stackTrace) => ErrorText(
                      error: error.toString(),
                    ),
                loading: () => Loader(
                      color: Colors.red,
                    )),
          ],
        ),
      ),
    );
  }
}
