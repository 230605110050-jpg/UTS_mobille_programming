import 'package:flutter/material.dart';

class ComicCard extends StatelessWidget {
  final Map<String, dynamic> comic;
  final VoidCallback onTap;

  const ComicCard({
    super.key,
    required this.comic,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Cover ----
            AspectRatio(
              aspectRatio: 3 / 4, // lebih proporsional dan tidak terlalu tinggi
              child: Image.network(
                comic['coverImage'] ?? 'https://via.placeholder.com/200x300',
                fit: BoxFit.cover,
              ),
            ),

            // ---- Judul & Rating ----
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comic['title'] ?? 'Tanpa Judul',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star,
                          size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        "${comic['rating'] ?? 0}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
