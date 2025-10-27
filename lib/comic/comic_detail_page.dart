import 'package:flutter/material.dart';

class ComicDetailPage extends StatelessWidget {
  final Map<String, dynamic> comic;
  final VoidCallback onBack;
  final Function(String) onReadChapter;

  const ComicDetailPage({
    super.key,
    required this.comic,
    required this.onBack,
    required this.onReadChapter,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;

    switch (comic['status']) {
      case 'ongoing':
        statusColor = Colors.green;
        statusText = 'Berlanjut';
        break;
      case 'completed':
        statusColor = Colors.teal;
        statusText = 'Selesai';
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'Hiatus';
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFECFDF5), Colors.white, Color(0xFFE6FFFA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ---------- Tombol Kembali ----------
              Row(
                children: [
                  TextButton.icon(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back, color: Colors.teal),
                    label: const Text(
                      "Kembali",
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ---------- Info Komik ----------
              LayoutBuilder(
                builder: (context, constraints) {
                  return constraints.maxWidth > 600
                      ? _buildWideLayout(statusColor, statusText)
                      : _buildNarrowLayout(statusColor, statusText);
                },
              ),
              const Divider(height: 40, color: Colors.teal),

              // ---------- Daftar Chapter ----------
              Text(
                "Daftar Chapter",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              ...List.generate(comic['chapters'].length, (i) {
                final chapter = comic['chapters'][i];
                return _buildChapterCard(context, chapter);
              }),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Layout untuk tampilan lebar ----------
  Widget _buildWideLayout(Color statusColor, String statusText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cover
        Expanded(
          flex: 3,
          child: Container(
            height: 420,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4))
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                comic['coverImage'] ??
                    'https://via.placeholder.com/300x400?text=No+Image',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        // Detail
        Expanded(
          flex: 5,
          child: _buildComicDetails(statusColor, statusText),
        ),
      ],
    );
  }

  // ---------- Layout untuk tampilan sempit ----------
  Widget _buildNarrowLayout(Color statusColor, String statusText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 3 / 4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4))
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                comic['coverImage'] ??
                    'https://via.placeholder.com/300x400?text=No+Image',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildComicDetails(statusColor, statusText),
      ],
    );
  }

  // ---------- Detail Komik ----------
  Widget _buildComicDetails(Color statusColor, String statusText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            statusText,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        const SizedBox(height: 8),

        // Judul
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.green, Colors.teal],
          ).createShader(bounds),
          child: Text(
            comic['title'] ?? '',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Author
        Row(
          children: [
            const Icon(Icons.person, size: 18, color: Colors.grey),
            const SizedBox(width: 6),
            Text(comic['author'] ?? '',
                style: const TextStyle(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 16),

        // Statistik
        Wrap(
          spacing: 20,
          runSpacing: 8,
          children: [
            _buildStat(Icons.star, Colors.amber, "Rating",
                "${comic['rating'] ?? 0}/5.0"),
            _buildStat(Icons.remove_red_eye, Colors.teal, "Views",
                "${comic['totalViews'] ?? 0}"),
            _buildStat(Icons.menu_book, Colors.green, "Chapters",
                "${(comic['chapters'] ?? []).length}"),
          ],
        ),
        const SizedBox(height: 16),

        // Genre
        const Text("Genre",
            style: TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: (comic['genre'] as List<dynamic>)
              .map((g) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green.shade200),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green.shade50,
                    ),
                    child: Text(
                      g.toString(),
                      style: TextStyle(
                          fontSize: 11, color: Colors.green.shade700),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),

        // Sinopsis
        const Text("Sinopsis",
            style: TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          comic['description'] ?? '',
          style: const TextStyle(
            color: Colors.black87,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),

        // Tombol aksi
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text("Mulai Baca"),
                onPressed: () => onReadChapter(comic['chapters'][0]['id']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.bookmark_outline),
                label: const Text("Tandai"),
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.green.shade300),
                  foregroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStat(IconData icon, Color color, String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(fontSize: 11, color: Colors.grey)),
            Text(value,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }

  // ---------- Chapter Card ----------
  Widget _buildChapterCard(BuildContext context, Map<String, dynamic> chapter) {
    return InkWell(
      onTap: () => onReadChapter(chapter['id']),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.green.shade100),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.04),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green.shade200),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green.shade50,
                      ),
                      child: Text("Ch. ${chapter['number']}",
                          style: TextStyle(
                              fontSize: 11, color: Colors.green.shade700)),
                    ),
                    const SizedBox(width: 8),
                    Text(chapter['title'] ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      chapter['publishedAt'] ?? '',
                      style:
                          const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.menu_book, size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text("${(chapter['pages'] ?? []).length} halaman",
                        style: const TextStyle(
                            fontSize: 11, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            TextButton(
              onPressed: () => onReadChapter(chapter['id']),
              style: TextButton.styleFrom(foregroundColor: Colors.teal),
              child: const Text("Baca"),
            ),
          ],
        ),
      ),
    );
  }
}
