import 'package:flutter/material.dart';
import '../widgets/comic_card.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> comics;
  final Function(String) onNavigateToDetail;
  final VoidCallback onNavigateToComics;

  const HomePage({
    super.key,
    required this.comics,
    required this.onNavigateToDetail,
    required this.onNavigateToComics,
  });

  @override
  Widget build(BuildContext context) {
    if (comics.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Belum ada komik tersedia.")),
      );
    }

    final featuredComic = comics.first;
    final trendingComics = comics.take(3).toList();
    final recentComics = comics.take(6).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF0FDF4),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ---------- HERO SECTION ----------
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF10B981), Color(0xFF0D9488)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Label Featured
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white30),
                        ),
                        child: const Text("Featured",
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        featuredComic['title'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "oleh ${featuredComic['author'] ?? ''}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        featuredComic['description'] ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        children:
                            (featuredComic['genre'] as List<dynamic>? ?? [])
                                .map((g) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        // ignore: deprecated_member_use
                                        color: Colors.white.withOpacity(0.2),
                                        border: Border.all(color: Colors.white30),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        g.toString(),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ))
                                .toList(),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => onNavigateToDetail(
                            featuredComic['id'].toString()),
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text("Baca Sekarang"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.teal.shade700,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          featuredComic['coverImage'] ??
                              'https://via.placeholder.com/300x400',
                          height: 380,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ---------- TRENDING SECTION ----------
            SliverToBoxAdapter(
              child: _buildSectionHeader(
                context,
                title: "Trending Sekarang",
                icon: Icons.trending_up,
                color: Colors.green,
                onViewAll: onNavigateToComics,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final comic = trendingComics[index];
                  return GestureDetector(
                    onTap: () => onNavigateToDetail(comic['id'].toString()),
                    child: Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                child: Image.network(
                                  comic['coverImage'] ??
                                      'https://via.placeholder.com/300x200',
                                  width: double.infinity,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade600,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "#${index + 1}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comic['title'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  comic['author'] ?? '',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    const SizedBox(width: 4),
                                    Text("${comic['rating'] ?? 0}"),
                                    const SizedBox(width: 12),
                                    const Icon(Icons.menu_book,
                                        color: Colors.teal, size: 16),
                                    const SizedBox(width: 4),
                                    Text("${(comic['chapters'] ?? []).length} Ch"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: trendingComics.length,
              ),
            ),

            // ---------- RECENT SECTION ----------
            SliverToBoxAdapter(
              child: _buildSectionHeader(
                context,
                title: "Update Terbaru",
                icon: Icons.access_time,
                color: Colors.teal,
                onViewAll: onNavigateToComics,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final comic = recentComics[index];
                    return ComicCard(
                      comic: comic,
                      onTap: () => onNavigateToDetail(comic['id'].toString()),
                    );
                  },
                  childCount: recentComics.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.62,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
              ),
            ),

            // ---------- CTA SECTION ----------
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  color: Colors.teal.shade600,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20),
                    child: Column(
                      children: [
                        const Text(
                          "Jelajahi Ribuan Komik Menarik",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Temukan cerita-cerita inspiratif dari kreator lokal Indonesia.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: onNavigateToComics,
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text("Jelajahi Komik"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.teal.shade700,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onViewAll,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color.shade700,
                ),
              ),
            ],
          ),
          TextButton.icon(
            onPressed: onViewAll,
            icon: Icon(Icons.arrow_forward, color: color),
            label: Text("Lihat Semua", style: TextStyle(color: color)),
          ),
        ],
      ),
    );
  }
}

extension on Color {
  Color? get shade700 => null;
}
