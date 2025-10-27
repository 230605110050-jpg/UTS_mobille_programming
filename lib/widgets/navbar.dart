import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final Map<String, dynamic>? currentUser;
  final String currentPage;
  final Function(String page) onNavigate;
  final VoidCallback? onLogout;

  const Navbar({
    super.key,
    required this.currentUser,
    required this.currentPage,
    required this.onNavigate,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            // ===== Logo =====
            GestureDetector(
              onTap: () => onNavigate(
                currentUser?['role'] == 'author'
                    ? 'author-dashboard'
                    : 'home',
              ),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [Colors.green, Colors.teal],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(
                      CupertinoIcons.book_fill,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // ShaderMask agar teks “KomikKu” bergradasi
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Colors.green, Colors.teal],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds),
                    child: const Text(
                      "KomikKu",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white, // akan di-mask oleh shader
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ===== Navigasi Halaman =====
            if (currentUser != null)
              Row(
                children: [
                  if (currentUser?['role'] == 'reader') ...[
                    _navButton(
                      label: 'Beranda',
                      icon: Icons.home_outlined,
                      active: currentPage == 'home',
                      onTap: () => onNavigate('home'),
                    ),
                    _navButton(
                      label: 'Daftar Komik',
                      icon: Icons.library_books_outlined,
                      active: currentPage == 'comics',
                      onTap: () => onNavigate('comics'),
                    ),
                  ],
                  if (currentUser?['role'] == 'author')
                    _navButton(
                      label: 'Dashboard',
                      icon: Icons.dashboard_outlined,
                      active: currentPage == 'author-dashboard',
                      onTap: () => onNavigate('author-dashboard'),
                    ),
                ],
              ),

            const SizedBox(width: 12),

            // ===== User Menu atau Tombol Masuk/Daftar =====
            if (currentUser != null)
              _userMenu(context)
            else
              Row(
                children: [
                  TextButton(
                    onPressed: () => onNavigate('login'),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    onPressed: () => onNavigate('register'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Daftar'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // ===== Komponen Tombol Navigasi =====
  Widget _navButton({
    required String label,
    required IconData icon,
    required bool active,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: active ? Colors.teal : Colors.grey[700],
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: active ? Colors.teal : Colors.grey[700],
                fontWeight: active ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== Menu Pengguna (Dropdown) =====
  Widget _userMenu(BuildContext context) {
    final isAuthor = currentUser?['role'] == 'author';
    return PopupMenuButton<String>(
      tooltip: 'Menu Akun',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      offset: const Offset(0, 50),
      icon: CircleAvatar(
        backgroundColor: Colors.teal.shade100,
        foregroundColor: Colors.teal.shade700,
        backgroundImage: (currentUser?['avatar'] != null &&
                currentUser!['avatar'].toString().isNotEmpty)
            ? NetworkImage(currentUser!['avatar'])
            : null,
        child: Text(
          (currentUser?['name']?.isNotEmpty ?? false)
              ? currentUser!['name'][0].toUpperCase()
              : '?',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              currentUser?['name'] ?? 'Pengguna',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(currentUser?['email'] ?? '',
                style: const TextStyle(fontSize: 12)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                isAuthor ? 'Author' : 'Pembaca',
                style: TextStyle(
                  color: Colors.teal.shade700,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ),
        const PopupMenuDivider(),
        if (isAuthor) ...[
          _popupItem(Icons.dashboard, 'Dashboard', 'author-dashboard'),
          _popupItem(Icons.person, 'Informasi Akun', 'author-settings'),
          _popupItem(Icons.edit, 'Edit Profil', 'author-settings'),
        ] else ...[
          _popupItem(Icons.person, 'Informasi Akun', 'account'),
          _popupItem(Icons.edit, 'Edit Profil', 'account'),
          const PopupMenuDivider(),
          _popupItem(Icons.favorite, 'Komik Favorit', 'account'),
          _popupItem(Icons.history, 'Riwayat Baca', 'account'),
        ],
        const PopupMenuDivider(),
        _popupItem(Icons.settings, 'Pengaturan',
            isAuthor ? 'author-settings' : 'account'),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'logout',
          onTap: onLogout,
          child: const Row(
            children: [
              Icon(Icons.logout, color: Colors.red),
              SizedBox(width: 8),
              Text(
                'Keluar',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }

  PopupMenuItem<String> _popupItem(
      IconData icon, String label, String route) {
    return PopupMenuItem<String>(
      value: route,
      onTap: () => onNavigate(route),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal, size: 18),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
