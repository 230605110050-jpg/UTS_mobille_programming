import 'package:flutter/material.dart';
import 'auth/login_page.dart';
import 'auth/register_page.dart';
import 'comic/home_page.dart';
import 'comic/comic_list_page.dart';
import 'comic/comic_detail_page.dart';
import 'comic/read_comic_page.dart';
import 'account/account_page.dart';
import 'author/dashboard_page.dart';
import 'author/author_setting_page.dart';
import 'utils/mock_data.dart'; // mockUser, mockComics, mockAuthorUser
import 'widgets/navbar.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();


void main() {
  runApp(const KomikkuApp());
}

class KomikkuApp extends StatefulWidget {
  const KomikkuApp({super.key});

  @override
  State<KomikkuApp> createState() => _KomikkuAppState();
}

class _KomikkuAppState extends State<KomikkuApp> {
  String currentPage = 'home';
  Map<String, dynamic>? currentUser = mockUser;
  List<Map<String, dynamic>> comics = List.from(mockComics);

  String? selectedComicId;
  String? selectedChapterId;

  void navigate(String page) {
    setState(() => currentPage = page);
  }

  void navigateToDetail(String comicId) {
    setState(() {
      selectedComicId = comicId;
      currentPage = 'comic-detail';
    });
  }

  void navigateToRead(String chapterId) {
    setState(() {
      selectedChapterId = chapterId;
      currentPage = 'read-comic';
    });
  }

  void handleRegister(String name, String email, String password, String role) {
    final newUser = {
      'id': 'user-${DateTime.now().millisecondsSinceEpoch}',
      'name': name,
      'email': email,
      'role': role,
      'avatar': 'https://api.dicebear.com/7.x/avataaars/svg?seed=$name',
      'bio': role == 'reader'
          ? 'Pecinta komik lokal Indonesia'
          : 'Komikus profesional',
      'joinedAt': DateTime.now().toString(),
    };
    setState(() {
      currentUser = newUser;
      currentPage = role == 'reader' ? 'home' : 'author-dashboard';
    });
    showToast("Registrasi berhasil, selamat datang $name!");
  }

  void handleLogin(String email, String password) {
    if (email == 'pembaca@example.com') {
      setState(() {
        currentUser = mockUser;
        currentPage = 'home';
      });
      showToast("Login berhasil! Selamat datang kembali.");
    } else if (email == 'ahmad@example.com') {
      setState(() {
        currentUser = mockAuthorUser;
        currentPage = 'author-dashboard';
      });
      showToast("Login berhasil! Selamat datang kembali.");
    } else {
      showToast("Login gagal. Email atau password salah.");
    }
  }

  void handleLogout() {
    setState(() {
      currentUser = null;
      currentPage = 'login';
    });

    // Delay 1 frame agar Scaffold baru siap
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showToast("Anda telah keluar. Sampai jumpa!");
    });
  }



  void createComic(Map<String, dynamic> newComic) {
    setState(() {
      comics.add({
        ...newComic,
        'id': 'comic-${DateTime.now().millisecondsSinceEpoch}',
      });
    });
    showToast("Komik berhasil dibuat: ${newComic['title']}");
  }

  void updateComic(String comicId, Map<String, dynamic> updates) {
    setState(() {
      comics = comics.map((c) {
        return c['id'] == comicId ? {...c, ...updates} : c;
      }).toList();
    });
    showToast("Komik berhasil diperbarui.");
  }

  void deleteComic(String comicId) {
    setState(() {
      comics.removeWhere((c) => c['id'] == comicId);
    });
    showToast("Komik berhasil dihapus.");
  }

  void showToast(String message) {
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.teal,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final selectedComic = selectedComicId != null
        ? comics.firstWhere((c) => c['id'] == selectedComicId)
        : null;

    final selectedChapter = selectedComic != null && selectedChapterId != null
        ? selectedComic['chapters']
            .firstWhere((ch) => ch['id'] == selectedChapterId)
        : null;

    final showNavbar =
        !['login', 'register', 'read-comic'].contains(currentPage);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
       scaffoldMessengerKey: rootScaffoldMessengerKey,
      title: 'Komikku Flutter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: Scaffold(
        appBar: showNavbar
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Navbar(
                  currentUser: currentUser,
                  currentPage: currentPage,
                  onNavigate: navigate,
                  onLogout: handleLogout,
                ),
              )
            : null,
        body: Builder(
          builder: (context) {
            if (currentPage == 'register') {
              return RegisterPage(
                onRegister: handleRegister,
                onNavigateToLogin: () => navigate('login'),
              );
            } else if (currentPage == 'login') {
              return LoginPage(
                onLogin: handleLogin,
                onNavigateToRegister: () => navigate('register'),
              );
            } else if (currentPage == 'home' &&
                currentUser?['role'] == 'reader') {
              return HomePage(
                comics: comics,
                onNavigateToDetail: navigateToDetail,
                onNavigateToComics: () => navigate('comics'),
              );
            } else if (currentPage == 'comics' &&
                currentUser?['role'] == 'reader') {
              return ComicListPage(
                comics: comics,
                onNavigateToDetail: navigateToDetail,
              );
            } else if (currentPage == 'comic-detail' &&
                selectedComic != null) {
              return ComicDetailPage(
                comic: selectedComic,
                onBack: () => navigate('comics'),
                onReadChapter: navigateToRead,
              );
            } else if (currentPage == 'read-comic' &&
                selectedComic != null &&
                selectedChapter != null) {
              return ReadComicPage(
                comic: selectedComic,
                currentChapter: selectedChapter,
                onBack: () => navigateToDetail(selectedComic['id']),
                onChangeChapter: (chapterId) =>
                    setState(() => selectedChapterId = chapterId),
              );
            } else if (currentPage == 'account' &&
                currentUser?['role'] == 'reader') {
              return AccountPage(
                user: currentUser!,
                readingHistory: comics.take(2).toList(),
                favorites: comics.take(1).toList(),
                onNavigateToDetail: navigateToDetail,
              );
            } else if (currentPage == 'author-dashboard' &&
                currentUser?['role'] == 'author') {
              return DashboardPage(
                authorId: currentUser!['id'],
                comics: comics,
                onCreateComic: createComic,
                onUpdateComic: updateComic,
                onDeleteComic: deleteComic,
              );
            } else if (currentPage == 'author-settings' &&
                currentUser?['role'] == 'author') {
              return AuthorSettingsPage(
                user: currentUser!,
                onBack: () => navigate('author-dashboard'),
              );
            } else {
              return const Center(child: Text("Halaman tidak ditemukan"));
            }
          },
        ),
      ),
    );
  }
}
