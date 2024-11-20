import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyn_2/core/common/error_text.dart';
import 'package:kyn_2/core/common/loader.dart';
import 'package:kyn_2/features/auth/controller/auth_controller.dart';
import 'package:kyn_2/features/whatshot/community/controller/community_controller.dart';
import 'package:kyn_2/features/whatshot/community/screens/mod_tools_screen.dart';
import 'package:kyn_2/features/whatshot/post/widget/post_card.dart';
import 'package:kyn_2/models/community_model.dart';

class CommunityScreen extends ConsumerWidget {
  static Route<dynamic> route(String name) => MaterialPageRoute(
        builder: (context) => CommunityScreen(name: name),
      );

  final String name;
  const CommunityScreen({super.key, required this.name});

  void joinCommunity(WidgetRef ref, Community community, BuildContext context) {
    ref
        .read(communityControllerProvider.notifier)
        .joinCommunity(community, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;

    return Scaffold(
      body: ref.watch(getCommunityByNameProvider(name)).when(
          data: (community) => NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 150,
                      floating: true,
                      snap: true,
                      flexibleSpace: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              community.banner,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Align(
                              alignment: Alignment.topLeft,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(community.avatar),
                                radius: 35,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'r/${community.name}',
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (!isGuest)
                                  community.mods.contains(user.uid)
                                      ? OutlinedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                ModToolsScreen.route(
                                                    community.name));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25),
                                          ),
                                          child: const Text('Mod Tools'),
                                        )
                                      : OutlinedButton(
                                          onPressed: () => joinCommunity(
                                              ref, community, context),
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25),
                                          ),
                                          child: Text(community.members
                                                  .contains(user.uid)
                                              ? 'Joined'
                                              : 'Join'),
                                        ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Text(
                                '${community.members.length} members',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: ref.watch(getCommunityPostsProvider(name)).when(
                    data: (data) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final post = data[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              child: PostCard(post: post),
                            );
                          },
                        ),
                      );
                    },
                    error: (error, stackTrace) {
                      return ErrorText(error: error.toString());
                    },
                    loading: () => Loader(
                          color: Colors.red,
                        )),
              ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => Loader(
                color: Colors.red,
              )),
    );
  }
}
