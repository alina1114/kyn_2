import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyn_2/core/common/error_text.dart';
import 'package:kyn_2/core/common/loader.dart';
import 'package:kyn_2/features/whatshot/community/controller/community_controller.dart';
import 'package:kyn_2/features/whatshot/community/screens/community_screens.dart';

class SearchCommunityDelegate extends SearchDelegate {
  final WidgetRef ref;

  SearchCommunityDelegate(this.ref);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          // Refresh suggestions when query is cleared
          showSuggestions(context);
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement a view for showing results based on the query if needed
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final queryProvider = searchCommunityProvider(query);
        final queryResult = ref.watch(queryProvider);

        return queryResult.when(
            data: (communities) {
              if (communities.isEmpty) {
                return const Center(child: Text('No communities found.'));
              }
              return ListView.builder(
                itemCount: communities.length,
                itemBuilder: (BuildContext context, int index) {
                  final community = communities[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider(community.avatar),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text('r/${community.name}'),
                    onTap: () => Navigator.of(context).push(
                      CommunityScreen.route(community.name),
                    ),
                  );
                },
              );
            },
            error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
            loading: () => Loader(
                  color: Colors.red,
                ));
      },
    );
  }
}
