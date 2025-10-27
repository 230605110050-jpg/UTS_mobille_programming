import 'package:flutter/material.dart';
// ignore: unused_import
import '../widgets/comic_card.dart';

class ComicListPage extends StatefulWidget {
  final List<Map<String, dynamic>> comics;
  final Function(String) onNavigateToDetail;

  const ComicListPage({
    super.key,
    required this.comics,
    required this.onNavigateToDetail,
  });

  @override
  State<ComicListPage> createState() => _ComicListPageState();
}

class _ComicListPageState extends State<ComicListPage> {
  String searchQuery = '';
  String selectedGenre = 'all';
  String selectedStatus = 'all';
  String sortBy = 'popular';
  String viewMode = 'grid';

  List<String> get allGenres {
    final genres = <String>{};
    for (var comic in widget.comics) {
      if (comic['genre'] is List) {
        genres.addAll(List<String>.from(comic['genre']));
      }
    }
    return genres.toList();
  }

  List<Map<String, dynamic>> get filteredComics {
    final filtered = widget.comics.where((comic) {
      final title = comic['title']?.toString().toLowerCase() ?? '';
      final author = comic['author']?.toString().toLowerCase() ?? '';
      final matchesSearch =
          title.contains(searchQuery.toLowerCase()) ||
          author.contains(searchQuery.toLowerCase());
      final matchesGenre = selectedGenre == 'all' ||
          (comic['genre'] as List).contains(selectedGenre);
      final matchesStatus =
          selectedStatus == 'all' || comic['status'] == selectedStatus;
      return matchesSearch && matchesGenre && matchesStatus;
    }).toList();

    filtered.sort((a, b) {
      if (sortBy == 'popular') {
        return (b['totalViews'] ?? 0).compareTo(a['totalViews'] ?? 0);
      } else if (sortBy == 'rating') {
        return (b['rating'] ?? 0).compareTo(a['rating'] ?? 0);
      } else if (sortBy == 'newest') {
        final aDate = DateTime.tryParse(a['createdAt'] ?? '') ?? DateTime(2000);
        final bDate = DateTime.tryParse(b['createdAt'] ?? '') ?? DateTime(2000);
        return bDate.compareTo(aDate);
      }
      return 0;
    });

    return filtered;
  }

  void resetFilters() {
    setState(() {
      searchQuery = '';
      selectedGenre = 'all';
      selectedStatus = 'all';
    });
  }

  @override
  Widget build(BuildContext context) {
    final comics = filteredComics;
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = screenWidth < 600
        ? 2
        : (screenWidth < 900 ? 3 : (screenWidth < 1200 ? 4 : 5));

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFECFDF5), Colors.white, Color(0xFFE6FFFA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  "Daftar Komik",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [Colors.green, Colors.teal],
                      ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Temukan komik favoritmu dari ${widget.comics.length} koleksi tersedia",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),

                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.search, color: Colors.grey, size: 20),
                    hintText: "Cari komik berdasarkan judul atau author...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Color(0xFFCCF0E3), width: 1.2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.teal, width: 1.5),
                    ),
                  ),
                  onChanged: (val) => setState(() => searchQuery = val),
                ),
                const SizedBox(height: 16),

                // Dropdown Filter
                Wrap(
                  runSpacing: 8,
                  spacing: 12,
                  children: [
                    _buildDropdown(
                      value: selectedGenre,
                      items: ['all', ...allGenres],
                      label: 'Genre',
                      onChanged: (val) => setState(() => selectedGenre = val!),
                    ),
                    _buildDropdown(
                      value: selectedStatus,
                      items: const ['all', 'ongoing', 'completed', 'hiatus'],
                      label: 'Status',
                      onChanged: (val) => setState(() => selectedStatus = val!),
                    ),
                    _buildDropdown(
                      value: sortBy,
                      items: const ['popular', 'rating', 'newest'],
                      label: 'Urutkan',
                      onChanged: (val) => setState(() => sortBy = val!),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => setState(() => viewMode = 'grid'),
                          icon: Icon(Icons.grid_view,
                              color: viewMode == 'grid'
                                  ? Colors.teal
                                  : Colors.grey),
                        ),
                        IconButton(
                          onPressed: () => setState(() => viewMode = 'list'),
                          icon: Icon(Icons.list,
                              color: viewMode == 'list'
                                  ? Colors.teal
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Filter aktif
                if (selectedGenre != 'all' ||
                    selectedStatus != 'all' ||
                    searchQuery.isNotEmpty)
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      const Text("Filter aktif:",
                          style: TextStyle(color: Colors.grey)),
                      if (searchQuery.isNotEmpty)
                        _buildBadge("Pencarian: \"$searchQuery\""),
                      if (selectedGenre != 'all')
                        _buildBadge("Genre: $selectedGenre"),
                      if (selectedStatus != 'all')
                        _buildBadge("Status: $selectedStatus"),
                      TextButton(
                        onPressed: resetFilters,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.teal,
                        ),
                        child: const Text("Reset Filter"),
                      )
                    ],
                  ),
                const SizedBox(height: 12),

                Text(
                  "Menampilkan ${comics.length} komik",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),

                // List atau Grid View
                if (comics.isNotEmpty)
                  viewMode == 'grid'
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: comics.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.68,
                          ),
                          itemBuilder: (context, index) {
                            final comic = comics[index];
                            return GestureDetector(
                              onTap: () =>
                                  widget.onNavigateToDetail(comic['id']),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.vertical(
                                            top: Radius.circular(12)),
                                        child: Image.network(
                                          comic['coverImage'] ??
                                              'https://via.placeholder.com/150',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          errorBuilder: (_, __, ___) =>
                                              const Icon(Icons.broken_image),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            comic['title'] ?? '',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(Icons.star,
                                                  color: Colors.amber, size: 14),
                                              const SizedBox(width: 4),
                                              Text(
                                                (comic['rating'] ?? 0)
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: comics.length,
                          itemBuilder: (context, index) {
                            final comic = comics[index];
                            return ListTile(
                              onTap: () =>
                                  widget.onNavigateToDetail(comic['id']),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  comic['coverImage'] ??
                                      'https://via.placeholder.com/60x80',
                                  width: 50,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(comic['title']),
                              subtitle: Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.amber, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    (comic['rating'] ?? 0).toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              trailing: const Icon(Icons.chevron_right,
                                  color: Colors.teal),
                            );
                          },
                        )
                else
                  _buildEmptyState(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required String label,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFCCF0E3)),
        ),
      ),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(_capitalize(e))))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.teal.shade50,
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: Text(text, style: TextStyle(color: Colors.teal.shade700)),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          children: [
            const Icon(Icons.search, size: 64, color: Colors.teal),
            const SizedBox(height: 12),
            const Text("Tidak ada komik ditemukan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text("Coba ubah filter atau kata kunci pencarian Anda",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: resetFilters,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text("Reset Filter"),
            ),
          ],
        ),
      ),
    );
  }

  String _capitalize(String text) =>
      text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
}
