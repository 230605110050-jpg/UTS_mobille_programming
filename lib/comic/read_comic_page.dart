import 'package:flutter/material.dart';

class ReadComicPage extends StatefulWidget {
  final Map<String, dynamic> comic;
  final Map<String, dynamic> currentChapter;
  final VoidCallback onBack;
  final Function(String) onChangeChapter;

  const ReadComicPage({
    super.key,
    required this.comic,
    required this.currentChapter,
    required this.onBack,
    required this.onChangeChapter,
  });

  @override
  State<ReadComicPage> createState() => _ReadComicPageState();
}

class _ReadComicPageState extends State<ReadComicPage> {
  int currentPage = 0;
  bool showControls = true;

  @override
  Widget build(BuildContext context) {
    final chapter = widget.currentChapter;
    final pages = List<String>.from(chapter['pages'] ?? []);
    final totalPages = pages.length;
    final progress = totalPages == 0 ? 0.0 : ((currentPage + 1) / totalPages);

    final chapters = List<Map<String, dynamic>>.from(widget.comic['chapters']);
    final currentIndex = chapters.indexWhere((c) => c['id'] == chapter['id']);

    final prevChapter = currentIndex > 0 ? chapters[currentIndex - 1] : null;
    final nextChapter =
        currentIndex < chapters.length - 1 ? chapters[currentIndex + 1] : null;

    void goPrev() {
      if (currentPage > 0) {
        setState(() => currentPage--);
      } else if (prevChapter != null) {
        widget.onChangeChapter(prevChapter['id'].toString());
      }
    }

    void goNext() {
      if (currentPage < totalPages - 1) {
        setState(() => currentPage++);
      } else if (nextChapter != null) {
        widget.onChangeChapter(nextChapter['id'].toString());
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ---------- Gambar Halaman ----------
          GestureDetector(
            onTap: () => setState(() => showControls = !showControls),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Image.network(
                  pages.isNotEmpty ? pages[currentPage] : '',
                  fit: BoxFit.contain,
                  width: double.infinity,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.image_not_supported,
                    color: Colors.white38,
                    size: 80,
                  ),
                ),
              ),
            ),
          ),

          // ---------- Tombol Navigasi Kiri-Kanan ----------
          if (currentPage > 0 || prevChapter != null)
            Positioned(
              left: 16,
              top: MediaQuery.of(context).size.height / 2 - 24,
              child: FloatingActionButton.small(
                backgroundColor: Colors.black45,
                onPressed: goPrev,
                child: const Icon(Icons.chevron_left, color: Colors.white),
              ),
            ),
          if (currentPage < totalPages - 1 || nextChapter != null)
            Positioned(
              right: 16,
              top: MediaQuery.of(context).size.height / 2 - 24,
              child: FloatingActionButton.small(
                backgroundColor: Colors.black45,
                onPressed: goNext,
                child: const Icon(Icons.chevron_right, color: Colors.white),
              ),
            ),

          // ---------- Kontrol Atas ----------
          AnimatedPositioned(
            top: showControls ? 0 : -120,
            left: 0,
            right: 0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black87, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tombol Kembali
                    TextButton.icon(
                      onPressed: widget.onBack,
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      label: const Text(
                        "Kembali",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    // Info Komik
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            widget.comic['title'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Chapter ${chapter['number']}: ${chapter['title']}",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.white10,
                            color: Colors.teal,
                            minHeight: 3,
                          ),
                        ],
                      ),
                    ),

                    // Nomor Halaman
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        "${currentPage + 1}/$totalPages",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ---------- Kontrol Bawah ----------
          AnimatedPositioned(
            bottom: showControls ? 0 : -160,
            left: 0,
            right: 0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black87, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tombol Sebelumnya
                    ElevatedButton.icon(
                      onPressed: prevChapter == null
                          ? null
                          : () => widget
                              .onChangeChapter(prevChapter['id'].toString()),
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(WidgetState.disabled)) {
                            // ignore: deprecated_member_use
                            return Colors.white12.withOpacity(0.2);
                          }
                          return Colors.white12;
                        }),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                      ),
                      icon: const Icon(Icons.chevron_left),
                      label: const Text("Chapter Sebelumnya"),
                    ),

                    // Dropdown Chapter
                    Flexible(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor: Colors.grey[900],
                          isExpanded: true,
                          value: chapter['id']?.toString(),
                          items: chapters
                              .map<DropdownMenuItem<String>>((ch) {
                            final idStr = ch['id']?.toString() ?? '';
                            final number = ch['number']?.toString() ?? '?';
                            final title = ch['title'] ?? 'Tanpa Judul';
                            return DropdownMenuItem<String>(
                              value: idStr,
                              child: Text(
                                "Ch. $number: $title",
                                style: const TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (id) {
                            if (id != null) widget.onChangeChapter(id);
                          },
                        ),
                      ),
                    ),

                    // Tombol Selanjutnya
                    ElevatedButton.icon(
                      onPressed: nextChapter == null
                          ? null
                          : () => widget
                              .onChangeChapter(nextChapter['id'].toString()),
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(WidgetState.disabled)) {
                            // ignore: deprecated_member_use
                            return Colors.white12.withOpacity(0.2);
                          }
                          return Colors.white12;
                        }),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                      ),
                      label: const Text("Chapter Selanjutnya"),
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ---------- Tombol Toggle Kontrol ----------
          Positioned(
            top: 40,
            right: 16,
            child: FloatingActionButton.small(
              backgroundColor: Colors.black54,
              onPressed: () =>
                  setState(() => showControls = !showControls),
              child: Icon(
                showControls ? Icons.close : Icons.menu,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
