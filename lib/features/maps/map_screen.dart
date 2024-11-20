import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/map.png', // Replace with your image path
              fit: BoxFit.cover, // Ensures the image covers the entire screen
            ),
          ),
          // Main Content
          Column(
            children: [
              // AppBar-like Search Bar
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Find for food or restaurant...",
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              /*
              // Chips Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 10,
                  children: [
                    _buildChip("Sports", Icons.sports_basketball),
                    _buildChip("Music", Icons.music_note),
                    _buildChip("Food", Icons.fastfood),
                  ],
                ),
              ),
              */
              const Spacer(), // Push the card to the bottom
              // Bottom Card
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const ListTile(
                    leading: Icon(Icons.event, color: Colors.red),
                    title: Text(
                      "Wed, Apr 28 • 5:30 PM",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Jo Malone London's Mother's Day Presents"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, IconData icon) {
    return Chip(
      label: Text(label),
      avatar: Icon(icon, color: Colors.white, size: 16),
      backgroundColor: Colors.blue,
      labelStyle: TextStyle(color: Colors.white),
    );
  }
}
