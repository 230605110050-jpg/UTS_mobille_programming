import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  final String authorId;
  final List<Map<String, dynamic>> comics;
  final Function(Map<String, dynamic>) onCreateComic;
  final Function(String, Map<String, dynamic>) onUpdateComic;
  final Function(String) onDeleteComic;

  const DashboardPage({
    super.key,
    required this.authorId,
    required this.comics,
    required this.onCreateComic,
    required this.onUpdateComic,
    required this.onDeleteComic,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Form controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController coverController = TextEditingController();
  final TextEditingController genreController = TextEditingController();

  String status = 'ongoing';
  List<String> genres = [];
  Map<String, dynamic>? selectedComic;

  bool showCreateDialog = false;
  bool showEditDialog = false;
  bool showDeleteDialog = false;

  void resetForm() {
    titleController.clear();
    descriptionController.clear();
    coverController.clear();
    genreController.clear();
    genres = [];
    status = 'ongoing';
  }

  @override
  Widget build(BuildContext context) {
    final authorComics = widget.comics
        .where((comic) => comic['authorId'] == widget.authorId)
        .toList();

    final totalViews = authorComics.fold<int>(
      0,
      (sum, c) => sum + (c['totalViews'] is int ? c['totalViews'] as int : 0),
    );

    final avgRating = authorComics.isNotEmpty
        ? (authorComics.fold<double>(
                    0.0, (sum, c) => sum + (c['rating'] ?? 0.0)) /
                authorComics.length)
            .toStringAsFixed(1)
        : '0';

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
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dashboard Author",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      Text(
                        "Kelola komik dan pantau performa Anda",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () => setState(() => showCreateDialog = true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text("Buat Komik Baru"),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Statistik
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.5),
                children: [
                  _buildStatCard(
                      "Total Komik", authorComics.length.toString(), Icons.menu_book, Colors.green),
                  _buildStatCard("Total Views",
                      "${(totalViews / 1000).toStringAsFixed(1)}k", Icons.visibility, Colors.teal),
                  _buildStatCard(
                      "Rating Rata-rata", avgRating, Icons.star, Colors.amber),
                  _buildStatCard(
                      "Total Pembaca", "1.2k", Icons.people, Colors.purple),
                ],
              ),
              const SizedBox(height: 24),

              // Daftar Komik
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0xFFCCF0E3)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Daftar Komik Anda",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (authorComics.isEmpty)
                        Column(
                          children: [
                            const Icon(Icons.menu_book,
                                size: 60, color: Colors.teal),
                            const SizedBox(height: 8),
                            const Text("Belum ada komik"),
                            const Text("Mulai membuat komik pertama Anda"),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: () =>
                                  setState(() => showCreateDialog = true),
                              icon: const Icon(Icons.add),
                              label: const Text("Buat Komik Baru"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal),
                            ),
                          ],
                        )
                      else
                        Column(
                          children: authorComics.map((comic) {
                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  comic['coverImage'] ??
                                      'https://via.placeholder.com/80',
                                  height: 80,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(comic['title']),
                              subtitle: Text(
                                "Genre: ${comic['genre']?.join(', ')} • ${comic['status']}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedComic = comic;
                                        titleController.text = comic['title'];
                                        descriptionController.text =
                                            comic['description'];
                                        coverController.text =
                                            comic['coverImage'];
                                        genres = List<String>.from(
                                            comic['genre'] ?? []);
                                        status = comic['status'];
                                        showEditDialog = true;
                                      });
                                    },
                                    icon: const Icon(Icons.edit,
                                        color: Colors.teal),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedComic = comic;
                                        showDeleteDialog = true;
                                      });
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ),

              // ---------- Dialogs ----------
              if (showCreateDialog) _buildComicDialog(context, isEdit: false),
              if (showEditDialog) _buildComicDialog(context, isEdit: true),
              if (showDeleteDialog) _buildDeleteDialog(context),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Widget Helper ----------
  Widget _buildStatCard(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        // ignore: deprecated_member_use
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            // ignore: deprecated_member_use
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComicDialog(BuildContext context, {required bool isEdit}) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              isEdit ? "Edit Komik" : "Buat Komik Baru",
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Judul Komik",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Deskripsi",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: coverController,
              decoration: const InputDecoration(
                labelText: "URL Cover Image",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: genreController,
              decoration: InputDecoration(
                labelText: "Tambah Genre",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (genreController.text.isNotEmpty &&
                        !genres.contains(genreController.text)) {
                      setState(() {
                        genres.add(genreController.text);
                        genreController.clear();
                      });
                    }
                  },
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: genres
                  .map((g) => Chip(
                        label: Text(g),
                        onDeleted: () => setState(() => genres.remove(g)),
                        deleteIconColor: Colors.redAccent,
                      ))
                  .toList(),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: status,
              items: const [
                DropdownMenuItem(value: 'ongoing', child: Text('Berlanjut')),
                DropdownMenuItem(value: 'completed', child: Text('Selesai')),
                DropdownMenuItem(value: 'hiatus', child: Text('Hiatus')),
              ],
              onChanged: (v) => setState(() => status = v!),
              decoration: const InputDecoration(
                labelText: "Status",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      if (isEdit) {
                        showEditDialog = false;
                      } else {
                        showCreateDialog = false;
                      }
                      resetForm();
                    });
                  },
                  child: const Text("Batal"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (isEdit && selectedComic != null) {
                      widget.onUpdateComic(selectedComic!['id'], {
                        'title': titleController.text,
                        'description': descriptionController.text,
                        'coverImage': coverController.text,
                        'genre': genres,
                        'status': status,
                      });
                      setState(() => showEditDialog = false);
                    } else {
                      widget.onCreateComic({
                        'title': titleController.text,
                        'description': descriptionController.text,
                        'coverImage': coverController.text,
                        'genre': genres,
                        'status': status,
                        'authorId': widget.authorId,
                        'rating': 0,
                        'totalViews': 0,
                        'chapters': [],
                        'createdAt': DateTime.now().toString(),
                      });
                      setState(() => showCreateDialog = false);
                    }
                    resetForm();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: Text(isEdit ? "Simpan" : "Buat"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteDialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Hapus Komik"),
      content: Text(
          'Apakah Anda yakin ingin menghapus komik "${selectedComic?['title']}"?'),
      actions: [
        TextButton(
          onPressed: () => setState(() => showDeleteDialog = false),
          child: const Text("Batal"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            if (selectedComic != null) {
              widget.onDeleteComic(selectedComic!['id']);
              setState(() {
                showDeleteDialog = false;
                selectedComic = null;
              });
            }
          },
          child: const Text("Hapus"),
        ),
      ],
    );
  }
}
