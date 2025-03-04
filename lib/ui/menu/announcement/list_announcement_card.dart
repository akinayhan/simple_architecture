import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ListAnnouncementCard {
  static Widget buildAnnouncementCard({
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: ExpansionTile(
        title: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.orange,
            child: Icon(
              Ionicons.megaphone_outline,
              color: Colors.white,
            ),
          ),
          title: Text(title),
          onTap: onTap,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}