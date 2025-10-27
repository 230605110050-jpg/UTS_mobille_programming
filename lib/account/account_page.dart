import 'package:flutter/material.dart';
import '../widgets/comic_card.dart';

class AccountPage extends StatefulWidget {
  final Map<String, dynamic> user;
  final List<Map<String, dynamic>> readingHistory;
  final List<Map<String, dynamic>> favorites;
  final Function(String) onNavigateToDetail;

  const AccountPage({
    super.key,
    required this.user,
    required this.readingHistory,
    required this.favorites,
    required this.onNavigateToDetail,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  bool editMode = false;
  bool notifications = true;
  bool emailUpdates = true;
  bool autoPlay = false;
  late TabController _tabController;

  late TextEditingController nameController;
  late TextEditingController bioController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    nameController = TextEditingController(text: widget.user['name']);
    bioController = TextEditingController(text: widget.user['bio'] ?? '');
  }

  @override
  void dispose() {
    _tabController.dispose();
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final reading = widget.readingHistory;
    final favorites = widget.favorites;

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
              // -------- Profil Header --------
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Color(0xFFCCF0E3))),
                clipBehavior: Clip.antiAlias,
                elevation: 4,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.green, Colors.teal]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            backgroundImage: user['avatar'] != null
                                ? NetworkImage(user['avatar'])
                                : null,
                            child: user['avatar'] == null
                                ? Text(
                                    user['name'][0],
                                    style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user['name'],
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(user['email'],
                                    style:
                                        const TextStyle(color: Colors.grey)),
                                const SizedBox(height: 4),
                                Text("Bergabung ${user['joinedAt']}",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                                const SizedBox(height: 8),
                                if (user['bio'] != null)
                                  Text(user['bio'],
                                      style:
                                          const TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                          if (!editMode)
                            OutlinedButton.icon(
                              onPressed: () =>
                                  setState(() => editMode = true),
                              icon: const Icon(Icons.settings),
                              label: const Text("Edit Profil"),
                            )
                          else
                            Row(
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      editMode = false;
                                      nameController.text = user['name'];
                                      bioController.text = user['bio'] ?? '';
                                    });
                                  },
                                  child: const Text("Batal"),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () =>
                                      setState(() => editMode = false),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal),
                                  child: const Text("Simpan"),
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

             // -------- Statistik --------
              LayoutBuilder(
                builder: (context, constraints) {
                  double gridWidth = constraints.maxWidth;
                  double childAspectRatio;

                  // Responsif: menyesuaikan lebar layar
                  if (gridWidth < 400) {
                    childAspectRatio = 2.0;
                  } else if (gridWidth < 600) {
                    childAspectRatio = 2.5;
                  } else {
                    childAspectRatio = 3.0;
                  }

                  final items = [
                    {
                      "title": "Sedang Dibaca",
                      "value": reading.length,
                      "color": Colors.green,
                      "icon": Icons.menu_book
                    },
                    {
                      "title": "Favorit",
                      "value": favorites.length,
                      "color": Colors.teal,
                      "icon": Icons.favorite
                    },
                    {
                      "title": "Total Chapter",
                      "value": 24,
                      "color": Colors.amber,
                      "icon": Icons.bar_chart
                    },
                  ];

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: childAspectRatio,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _buildStat(
                        item["title"] as String,
                        item["value"] as int,
                        item["color"] as Color,
                        item["icon"] as IconData,
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 24),



              // -------- Tabs (Sudah diperbaiki) --------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Container(
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Colors.teal.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.teal,
                    indicatorSize: TabBarIndicatorSize.tab, // ✅ indikator penuh
                    indicator: BoxDecoration(
                      color: Colors.teal,
                      borderRadius:
                          BorderRadius.circular(12), // ✅ rounded rectangle
                    ),
                    labelStyle:
                        const TextStyle(fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(icon: Icon(Icons.menu_book), text: "Sedang Dibaca"),
                      Tab(icon: Icon(Icons.favorite), text: "Favorit"),
                      Tab(icon: Icon(Icons.history), text: "Riwayat"),
                      Tab(icon: Icon(Icons.settings), text: "Pengaturan"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // -------- Isi Tabs --------
              SizedBox(
                height: 1000,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildReadingTab(reading),
                    _buildReadingTab(favorites),
                    _buildHistoryTab(reading),
                    _buildSettingsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ----- Widget Helper -----
    Widget _buildStat(String label, int value, Color color, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        // ignore: deprecated_member_use
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Center(
        child: FittedBox( // 🔹 Kunci utama anti overflow
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$value",
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildReadingTab(List<Map<String, dynamic>> comics) {
    if (comics.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.menu_book, size: 50, color: Colors.teal),
            const SizedBox(height: 8),
            const Text("Belum ada komik"),
            const Text("Mulai membaca komik favorit Anda"),
            const SizedBox(height: 12),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () {},
              child: const Text("Jelajahi Komik"),
            )
          ],
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: comics.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisExtent: 430, crossAxisSpacing: 8),
      itemBuilder: (context, index) {
        final comic = comics[index];
        return ComicCard(
          comic: comic,
          onTap: () => widget.onNavigateToDetail(comic['id']),
        );
      },
    );
  }

  Widget _buildHistoryTab(List<Map<String, dynamic>> comics) {
    return ListView.builder(
      itemCount: comics.length,
      itemBuilder: (context, index) {
        final comic = comics[index];
        return ListTile(
          onTap: () => widget.onNavigateToDetail(comic['id']),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              comic['coverImage'] ??
                  'https://via.placeholder.com/80x100',
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(comic['title'] ?? ''),
          subtitle: const Text("Dibaca 2 jam yang lalu",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
        );
      },
    );
  }

  Widget _buildSettingsTab() {
    return ListView(
      children: [
        _buildSection(
          icon: Icons.person,
          title: "Informasi Profil",
          children: [
            TextField(
              controller: nameController,
              enabled: editMode,
              decoration: const InputDecoration(
                  labelText: "Nama Lengkap",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: bioController,
              enabled: editMode,
              decoration: const InputDecoration(
                  labelText: "Bio", border: OutlineInputBorder()),
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            editMode
                ? Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            editMode = false;
                          });
                        },
                        child: const Text("Batal"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() => editMode = false);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal),
                        child: const Text("Simpan"),
                      ),
                    ],
                  )
                : OutlinedButton.icon(
                    onPressed: () => setState(() => editMode = true),
                    icon: const Icon(Icons.settings),
                    label: const Text("Edit Profil"),
                  )
          ],
        ),
        _buildSwitch("Notifikasi Push", notifications,
            (v) => setState(() => notifications = v)),
        _buildSwitch("Email Updates", emailUpdates,
            (v) => setState(() => emailUpdates = v)),
        _buildSwitch("Auto-Play Chapter", autoPlay,
            (v) => setState(() => autoPlay = v)),
        _buildSection(
          icon: Icons.security,
          title: "Privasi & Keamanan",
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.lock_outline),
              label: const Text("Ubah Password"),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.shield_outlined),
              label: const Text("Privasi Akun"),
            ),
          ],
        ),
        _buildSection(
          icon: Icons.warning_amber,
          title: "Zona Berbahaya",
          color: Colors.red,
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red)),
              child: const Text("Hapus Riwayat Baca",
                  style: TextStyle(color: Colors.red)),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red)),
              child: const Text("Nonaktifkan Akun",
                  style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {},
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Hapus Akun Permanen"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    List<Widget>? children,
    Color color = Colors.teal,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        // ignore: deprecated_member_use
        side: BorderSide(color: color.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: color)),
            ]),
            const SizedBox(height: 12),
            ...?children,
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch(String label, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(label),
      value: value,
      activeThumbColor: Colors.teal,
      onChanged: onChanged,
    );
  }
}
