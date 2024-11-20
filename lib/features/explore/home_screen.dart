import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyn_2/core/constants/constants.dart';
import 'package:kyn_2/features/events/community/controller/community_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KYN',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Notification Icon (No badge)
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // Add your notification action here
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap content in SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      border: InputBorder.none, // No outline
                      focusedBorder:
                          InputBorder.none, // No outline when focused
                      enabledBorder:
                          InputBorder.none, // No outline when enabled
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.tune),
                      ),
                    ),
                  ),
                ),

                // Category Pills
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategoryPill(
                        icon: Icons.sports,
                        label: 'Sports',
                        color: Colors.red[100]!,
                      ),
                      CategoryPill(
                        icon: Icons.music_note,
                        label: 'Music',
                        color: Colors.orange[100]!,
                      ),
                      CategoryPill(
                        icon: Icons.fastfood,
                        label: 'Food',
                        color: Colors.green[100]!,
                      ),
                    ],
                  ),
                ),

                // Upcoming Events Section
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upcoming Events',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'See All',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),

                // Event Cards
                SizedBox(
                  height: 270,
                  child: ref.watch(getAllPosts).when(
                        data: (posts) {
                          // We only want to show the latest 2 posts for the horizontal list
                          final latestPosts = posts.take(5).toList();

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: latestPosts.length,
                            itemBuilder: (BuildContext context, int index) {
                              final post = latestPosts[index];

                              return EventCard(
                                date:
                                    '10 JUNE', // Assuming 'date' exists in your post
                                title: post.title,
                                location: 'Unknown Location',
                                attendees: 7,
                                color: Colors.pink[50]!,
                                imageUrl: post.link ?? Constants.bannerDefault,
                              );
                            },
                          );
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, stackTrace) => Center(
                          child: Text('Error: $error'),
                        ),
                      ),
                ),

                // Invite Friends Section
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Invite your friends',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Get \$20 for ticket',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'INVITE',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          width: 16), // Spacing between content and image
                      Image.asset(
                        'assets/images/invite.png', // Replace with your PNG's path
                        height: 100, // Increase the size of the image
                        width: 180,
                        fit: BoxFit.fill, // Ensure proportional scaling
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const CategoryPill({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String date;
  final String title;
  final String location;
  final int attendees;
  final Color color;
  final String imageUrl;

  const EventCard({
    super.key,
    required this.date,
    required this.title,
    required this.location,
    required this.attendees,
    required this.color,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior:
            Clip.none, // To allow the icons to go outside the Stack's boundary
        children: [
          // Image Section
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),

          // Overlay content (Date and Bookmark) on top of the image
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                    0.7), // Added transparency to make it stand out
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                date,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 8,
            right: 8,
            child: const Icon(Icons.bookmark_border, color: Colors.white),
          ),

          // Details section below the image
          Positioned(
            top: 150,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Event location
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Attendees
                Row(
                  children: [
                    const SizedBox(
                      width: 60,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.blue,
                          ),
                          Positioned(
                            left: 18,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.red,
                            ),
                          ),
                          Positioned(
                            left: 36,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '+$attendees Going',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
