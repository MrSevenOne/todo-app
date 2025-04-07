import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  final Color color;

  Category({
    required this.name,
    required this.icon,
    required this.color,
  });
}

final List<Category> categories = [
  Category(name: 'Grocery', icon: Icons.local_grocery_store, color: Colors.lightGreenAccent),
  Category(name: 'Work', icon: Icons.work, color: Colors.redAccent),
  Category(name: 'Sport', icon: Icons.fitness_center, color: Colors.cyanAccent),
  Category(name: 'Design', icon: Icons.games, color: Colors.greenAccent),
  Category(name: 'University', icon: Icons.school, color: Colors.blueAccent),
  Category(name: 'Social', icon: Icons.campaign, color: Colors.pinkAccent),
  Category(name: 'Music', icon: Icons.music_note, color: Colors.pinkAccent),
  Category(name: 'Health', icon: Icons.health_and_safety, color: Colors.lightGreenAccent),
  Category(name: 'Movie', icon: Icons.movie, color: Colors.lightBlueAccent),
  Category(name: 'Home', icon: Icons.home, color: Colors.redAccent),
];