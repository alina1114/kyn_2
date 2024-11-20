
/*
class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  // Counter for debugging
  int queryCallCount = 0;

  @override
  Widget build(BuildContext context) {
    return ref.watch(userCommunitiesProvider).when(
      data: (communities) {
        // Debugging statement to check the communities data

        final List<String> communityNames =
            communities.map((e) => e.name).toList();

        final Query<Post> query = FirebaseFirestore.instance
            .collection('posts')
            .where('communityName', whereIn: communityNames)
            .orderBy('createdAt', descending: true)
            .limit(3)
            .withConverter(
              fromFirestore: (snapshot, _) {
                // Increment query call count and debug statement
                queryCallCount++;
                //print('Query Call Count: $queryCallCount');
                //print('Document Data: ${snapshot.data()}');
                return Post.fromMap(snapshot.data()!);
              },
              toFirestore: (post, _) => post.toMap(),
            );

        return Column(
          children: [
            const WriteSomethingWidget(), // The widget to write something new
            Expanded(
              child: FirestoreListView<Post>(
                pageSize: 10,
                query: query,
                itemBuilder:
                    (BuildContext context, DocumentSnapshot<Post> snapshot) {
                  final post = snapshot.data();
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    child: PostCard(post: post!),
                  );
                },
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) {
        // Debugging statement to check error details
        print('Error: ${error.toString()}');
        return ErrorText(
          error: error.toString(),
        );
      },
      loading: () {
        // Debugging statement to check loading state
        print('Loading...');
        return Loader(
          color: Colors.red,
        );
      },
    );
  }
}
*/
