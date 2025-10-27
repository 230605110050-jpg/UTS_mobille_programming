// Data User dan Author
// -------------------------------------------------------------

final Map<String, dynamic> mockUser = {
  'id': 'user-1',
  'name': 'Budi Santoso',
  'email': 'pembaca@example.com',
  'role': 'reader',
  'avatar':
      'https://api.dicebear.com/7.x/avataaars/png?seed=budi',
  'bio': 'Pecinta komik lokal Indonesia',
  'joinedAt': '2023-01-10',
};

final Map<String, dynamic> mockAuthorUser = {
  'id': 'user-2',
  'name': 'Ahmad Faiz',
  'email': 'ahmad@example.com',
  'role': 'author',
  'avatar':
      'https://api.dicebear.com/7.x/avataaars/png?seed=ahmad',
  'bio': 'Penulis dan ilustrator komik',
  'joinedAt': '2022-12-01',
};

final Map<String, dynamic> mockUser3 = {
  'id': 'user-3',
  'name': 'Citra Dewi',
  'email': 'citra@example.com',
  'role': 'reader',
  'avatar':
      'https://api.dicebear.com/7.x/avataaars/png?seed=citra',
  'bio': 'Suka komik bergenre romansa dan slice of life.',
  'joinedAt': '2023-05-20',
};

final Map<String, dynamic> mockAuthorUser2 = {
  'id': 'user-4',
  'name': 'Danu Wijaya',
  'email': 'danu.wijaya@example.com',
  'role': 'author',
  'avatar':
      'https://api.dicebear.com/7.x/avataaars/png?seed=danu',
  'bio': 'Pencipta dunia fantasi dan aksi yang intens.',
  'joinedAt': '2022-10-15',
};

final Map<String, dynamic> mockAuthorUser3 = {
  'id': 'user-5',
  'name': 'Eka Putri',
  'email': 'eka.putri@example.com',
  'role': 'author',
  'avatar':
      'https://api.dicebear.com/7.x/avataaars/png?seed=eka',
  'bio': 'Mengkhususkan diri pada komik horor dan misteri.',
  'joinedAt': '2023-02-28',
};

final List<Map<String, dynamic>> mockUsers = [
  mockUser,
  mockAuthorUser,
  mockUser3,
  mockAuthorUser2,
  mockAuthorUser3,
];


// Data Komik (20 total)
// -------------------------------------------------------------

final List<Map<String, dynamic>> mockComics = [
  // ------------------------------------------
  // KOMIK 1 - 6 (Data yang sudah ada)
  // ------------------------------------------
  {
    'id': 'comic-1',
    'title': 'Petualangan Si Kucing',
    'author': 'Ahmad Faiz',
    'authorId': 'user-2',
    'coverImage':
        'https://ik.imagekit.io/storybird/drafts/8318b70e-3d8b-4e43-a28a-5b93b6b42861/0eb20f55-d546-4bb9-8e59-e70fd3d23988.webp?tr=q-80',
    'description':
        'Komik seru tentang kucing yang berpetualang di dunia magis.',
    'genre': ['Petualangan', 'Fantasi'],
    'status': 'ongoing',
    'rating': 4.5,
    'totalViews': 12500,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Awal Petualangan',
        'publishedAt': '2023-03-01',
        'pages': List.generate(10, (index) => 'page_${index + 1}.jpg'),
      },
      {
        'id': 'ch-2',
        'number': 2,
        'title': 'Rahasia Hutan',
        'publishedAt': '2023-03-15',
        'pages': List.generate(12, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },
  {
    'id': 'comic-2',
    'title': 'Legenda Naga',
    'author': 'Ahmad Faiz',
    'authorId': 'user-2',
    'coverImage':
        'https://th.bing.com/th/id/OIP.zVnY8d6yFa8-5ZnHXd4u8wAAAA?w=115&h=180&c=7&r=0&o=7&cb=12&dpr=1.3&pid=1.7&rm=3',
    'description':
        'Kisah legenda naga yang legendaris dan penuh misteri.',
    'genre': ['Fantasi', 'Drama'],
    'status': 'completed',
    'rating': 4.8,
    'totalViews': 9800,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Asal Mula Naga',
        'publishedAt': '2022-01-10',
        'pages': List.generate(15, (index) => 'page_${index + 1}.jpg'),
      },
      {
        'id': 'ch-2',
        'number': 2,
        'title': 'Pertempuran Hebat',
        'publishedAt': '2022-01-25',
        'pages': List.generate(20, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },
  {
    'id': 'comic-3',
    'title': 'Cinta di Balik Senja',
    'author': 'Ahmad Faiz',
    'authorId': 'user-2',
    'coverImage':
        'https://th.bing.com/th/id/OIP.v725d_7fBgRpDU6hqczIiQAAAA?w=138&h=184&c=7&r=0&o=7&cb=12&dpr=1.3&pid=1.7&rm=3',
    'description':
        'Kisah romansa yang mengharukan antara dua insan di kota metropolitan.',
    'genre': ['Romansa', 'Slice of Life'],
    'status': 'completed',
    'rating': 4.6,
    'totalViews': 15000,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Pertemuan Tak Terduga',
        'publishedAt': '2023-04-01',
        'pages': List.generate(18, (index) => 'page_${index + 1}.jpg'),
      },
      {
        'id': 'ch-3',
        'number': 3,
        'title': 'Di Bawah Senja',
        'publishedAt': '2023-04-30',
        'pages': List.generate(22, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },
  {
    'id': 'comic-4',
    'title': 'Ksatria Baja',
    'author': 'Danu Wijaya',
    'authorId': 'user-4',
    'coverImage':
        'https://down-id.img.susercontent.com/file/id-11134207-7r98o-ll1lcsw3i34w30',
    'description':
        'Aksi dan pertarungan epik melawan kekuatan gelap yang mengancam dunia.',
    'genre': ['Aksi', 'Sci-Fi'],
    'status': 'ongoing',
    'rating': 4.7,
    'totalViews': 21000,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Kebangkitan Sang Pahlawan',
        'publishedAt': '2023-01-05',
        'pages': List.generate(25, (index) => 'page_${index + 1}.jpg'),
      },
      {
        'id': 'ch-3',
        'number': 3,
        'title': 'Markas Musuh',
        'publishedAt': '2023-02-05',
        'pages': List.generate(30, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },
  {
    'id': 'comic-5',
    'title': 'Hantu Sekolah Lama',
    'author': 'Eka Putri',
    'authorId': 'user-5',
    'coverImage':
        'https://i.ytimg.com/vi/L7eFp0PvHhY/maxresdefault.jpg',
    'description':
        'Misteri hantu yang menghantui sebuah sekolah tua yang terbengkalai.',
    'genre': ['Horor', 'Misteri'],
    'status': 'completed',
    'rating': 4.3,
    'totalViews': 8500,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Bisikan di Koridor',
        'publishedAt': '2023-06-01',
        'pages': List.generate(20, (index) => 'page_${index + 1}.jpg'),
      },
      {
        'id': 'ch-2',
        'number': 2,
        'title': 'Siapa Dia?',
        'publishedAt': '2023-06-15',
        'pages': List.generate(21, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },
  {
    'id': 'comic-6',
    'title': 'Robot Penyelamat',
    'author': 'Danu Wijaya',
    'authorId': 'user-4',
    'coverImage':
        'https://tse2.mm.bing.net/th/id/OIP.r1z0JMVsJKXfRSzKbdqhDAHaM9?rs=1&pid=ImgDetMain&o=7&rm=3',
    'description':
        'Di masa depan, satu-satunya harapan umat manusia ada di tangan sebuah robot tua.',
    'genre': ['Sci-Fi', 'Aksi', 'Drama'],
    'status': 'ongoing',
    'rating': 4.4,
    'totalViews': 11200,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Tersisa Sendirian',
        'publishedAt': '2023-03-10',
        'pages': List.generate(23, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },
  // ------------------------------------------
  // KOMIK 7 - 20 (Tambahan)
  // ------------------------------------------
  {
    'id': 'comic-7',
    'title': 'Kopi dan Cerita Pagi',
    'author': 'Ahmad Faiz',
    'authorId': 'user-2',
    'coverImage':
        'https://thvnext.bing.com/th/id/OIP.SWhp6-EiitfZ9EbMKTr4LQHaD4?w=319&h=180&c=7&r=0&o=7&cb=12&pid=1.7&rm=3',
    'description':
        'Kumpulan cerita ringan sehari-hari dengan sentuhan komedi dan filosofis.',
    'genre': ['Slice of Life', 'Komedi'],
    'status': 'ongoing',
    'rating': 4.2,
    'totalViews': 9500,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Pahit Manis Secangkir Kopi',
        'publishedAt': '2024-01-01',
        'pages': List.generate(15, (index) => 'page_${index + 1}.jpg'),
      },
      {
        'id': 'ch-2',
        'number': 2,
        'title': 'Obrolan di Teras',
        'publishedAt': '2024-01-15',
        'pages': List.generate(14, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },
  {
    'id': 'comic-8',
    'title': 'Pedang Tujuh Bintang',
    'author': 'Danu Wijaya',
    'authorId': 'user-4',
    'coverImage':
        'https://tse2.mm.bing.net/th/id/OIP.aG0tiWDtq0lVGYRu9qX3sQHaHa?w=626&h=626&rs=1&pid=ImgDetMain&o=7&rm=3',
    'description':
        'Perjalanan seorang pendekar muda mencari tujuh pedang legendaris untuk menyelamatkan kerajaan.',
    'genre': ['Fantasi', 'Aksi', 'Petualangan'],
    'status': 'completed',
    'rating': 4.9,
    'totalViews': 35000,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Awal Mula Misi',
        'publishedAt': '2022-11-20',
        'pages': List.generate(30, (index) => 'page_${index + 1}.jpg'),
      },
      {
        'id': 'ch-2',
        'number': 2,
        'title': 'Pertemuan Sang Guru',
        'publishedAt': '2022-12-05',
        'pages': List.generate(35, (index) => 'page_${index + 1}.jpg'),
      },
      {
        'id': 'ch-3',
        'number': 3,
        'title': 'Perang Akhir',
        'publishedAt': '2023-03-20',
        'pages': List.generate(40, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },
  {
    'id': 'comic-9',
    'title': 'Darah di Rumah Kosong',
    'author': 'Eka Putri',
    'authorId': 'user-5',
    'coverImage':
        'https://tse1.mm.bing.net/th/id/OIP.9YFirhn0FIu47n-jBpjgMQHaE8?w=1504&h=1003&rs=1&pid=ImgDetMain&o=7&rm=3',
    'description':
        'Kisah sekelompok remaja yang terjebak di sebuah rumah angker dengan sejarah kelam.',
    'genre': ['Horor', 'Gore', 'Thriller'],
    'status': 'ongoing',
    'rating': 4.1,
    'totalViews': 7500,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Pintu Terlarang',
        'publishedAt': '2024-02-14',
        'pages': List.generate(18, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },
  {
    'id': 'comic-10',
    'title': 'Pahlawan di Balik Layar',
    'author': 'Ahmad Faiz',
    'authorId': 'user-2',
    'coverImage':
        'https://tse2.mm.bing.net/th/id/OIP.RB-sR7Qsy3MUEH3ZNrtg5AHaFb?rs=1&pid=ImgDetMain&o=7&rm=3',
    'description':
        'Kisah sejarah fiksi tentang perjuangan pahlawan tak dikenal di era kemerdekaan.',
    'genre': ['Sejarah', 'Drama', 'Perang'],
    'status': 'completed',
    'rating': 4.7,
    'totalViews': 18000,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Janji Senja',
        'publishedAt': '2023-05-10',
        'pages': List.generate(25, (index) => 'page_${index + 1}.jpg'),
      },
      {
        'id': 'ch-5',
        'number': 5,
        'title': 'Merah Putih Berkibar',
        'publishedAt': '2023-08-17',
        'pages': List.generate(32, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },
  {
    'id': 'comic-11',
    'title': 'Virus X: Ancaman Global',
    'author': 'Danu Wijaya',
    'authorId': 'user-4',
    'coverImage':
        'https://th.bing.com/th/id/R.be4916753b1fcbbb763f70da1eaf82f4?rik=zBe4BOD8X5ifEA&riu=http%3a%2f%2fimages.comiccollectorlive.com%2fcovers%2f5f4%2f5f4727a9-23a9-4082-bad2-7dd6169145a7.jpg&ehk=VvZQWQZL4C7IuVF9HMyICmQ7idzI6SrJuq9S75UiqLE%3d&risl=&pid=ImgRaw&r=0',
    'description':
        'Sebuah virus misterius menyebar dan mengubah manusia menjadi makhluk ganas. Perjuangan untuk bertahan hidup dimulai.',
    'genre': ['Sci-Fi', 'Thriller', 'Survival'],
    'status': 'ongoing',
    'rating': 4.5,
    'totalViews': 25000,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Hari Pertama Infeksi',
        'publishedAt': '2024-03-01',
        'pages': List.generate(28, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },

  {
    'id': 'comic-13',
    'title': 'Jodoh Mendadak',
    'author': 'Ahmad Faiz',
    'authorId': 'user-2',
    'coverImage':
        'https://tse3.mm.bing.net/th/id/OIP.jbcfFLX-0UAUN54kMTHFRQHaJ4?rs=1&pid=ImgDetMain&o=7&rm=3',
    'description':
        'Dua orang yang tidak saling mengenal dipaksa menikah karena perjodohan konyol orang tua mereka.',
    'genre': ['Romansa', 'Komedi', 'Slice of Life'],
    'status': 'ongoing',
    'rating': 4.3,
    'totalViews': 14000,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Akad yang Canggung',
        'publishedAt': '2024-04-10',
        'pages': List.generate(16, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },
  {
    'id': 'comic-14',
    'title': 'Pulau Terakhir',
    'author': 'Danu Wijaya',
    'authorId': 'user-4',
    'coverImage':
        'https://gamedaim.com/wp-content/uploads/2021/05/Tsurumi-Island.jpg',
    'description':
        'Setelah kapal karam, sekelompok penyintas harus berjuang melawan alam liar di pulau tak berpenghuni.',
    'genre': ['Petualangan', 'Survival', 'Thriller'],
    'status': 'completed',
    'rating': 4.8,
    'totalViews': 30000,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Terdampar',
        'publishedAt': '2022-10-01',
        'pages': List.generate(28, (index) => 'page_${index + 1}.jpg'),
      },
      {
        'id': 'ch-10',
        'number': 10,
        'title': 'Jalan Pulang',
        'publishedAt': '2023-01-15',
        'pages': List.generate(35, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },
  {
    'id': 'comic-15',
    'title': 'Gerbang Dunia Lain',
    'author': 'Eka Putri',
    'authorId': 'user-5',
    'coverImage':
        'https://tse4.mm.bing.net/th/id/OIP.Eoog9flYLenUZXQKWBnsfwHaEJ?w=626&h=351&rs=1&pid=ImgDetMain&o=7&rm=3',
    'description':
        'Seorang siswi menemukan sebuah gerbang misterius yang membawanya ke dimensi yang dihuni makhluk supernatural.',
    'genre': ['Supernatural', 'Fantasi', 'Misteri'],
    'status': 'ongoing',
    'rating': 4.4,
    'totalViews': 9000,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Di Balik Cermin',
        'publishedAt': '2024-05-01',
        'pages': List.generate(19, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },
  {
    'id': 'comic-16',
    'title': 'Juara Tak Terkalahkan',
    'author': 'Ahmad Faiz',
    'authorId': 'user-2',
    'coverImage':
        'https://tse1.mm.bing.net/th/id/OIP.pZ9Y_ClWKGLGZPSuNYEepwHaHa?w=996&h=996&rs=1&pid=ImgDetMain&o=7&rm=3',
    'description':
        'Perjalanan seorang atlet beladiri dari nol hingga menjadi juara nasional.',
    'genre': ['Aksi', 'Olahraga', 'Drama'],
    'status': 'completed',
    'rating': 4.7,
    'totalViews': 22000,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Latihan Keras',
        'publishedAt': '2023-02-01',
        'pages': List.generate(20, (index) => 'page_${index + 1}.jpg'),
      },
      {
        'id': 'ch-8',
        'number': 8,
        'title': 'Final Penentuan',
        'publishedAt': '2023-07-01',
        'pages': List.generate(25, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },
  {
    'id': 'comic-17',
    'title': 'Robot Titan G-5',
    'author': 'Danu Wijaya',
    'authorId': 'user-4',
    'coverImage':
        'https://tse1.mm.bing.net/th/id/OIP.GO27rb5bf2gQsM_H3ewdowHaHa?w=2000&h=2000&rs=1&pid=ImgDetMain&o=7&rm=3',
    'description':
        'Pilot muda mengendalikan robot raksasa (Mecha) terakhir untuk melindungi bumi dari serangan alien intergalaksi.',
    'genre': ['Mecha', 'Sci-Fi', 'Aksi'],
    'status': 'ongoing',
    'rating': 4.6,
    'totalViews': 17000,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Aktivasi Titan',
        'publishedAt': '2024-01-20',
        'pages': List.generate(22, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },
  {
    'id': 'comic-18',
    'title': 'Topeng Diri',
    'author': 'Eka Putri',
    'authorId': 'user-5',
    'coverImage':
        'https://tse2.mm.bing.net/th/id/OIP.-l8HyWy61lffon0HT87BTQHaLH?rs=1&pid=ImgDetMain&o=7&rm=3',
    'description':
        'Sebuah komik psikologi yang menggali sisi gelap manusia dan penyakit mental.',
    'genre': ['Thriller', 'Psikologi', 'Drama'],
    'status': 'completed',
    'rating': 4.2,
    'totalViews': 11000,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Di Balik Senyum',
        'publishedAt': '2023-09-01',
        'pages': List.generate(20, (index) => 'page_${index + 1}.jpg'),
      },
      {
        'id': 'ch-4',
        'number': 4,
        'title': 'Wajah Asli',
        'publishedAt': '2023-12-01',
        'pages': List.generate(28, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  },
  {
    'id': 'comic-19',
    'title': 'Petualangan Si Bintang Kecil',
    'author': 'Ahmad Faiz',
    'authorId': 'user-2',
    'coverImage':
        'https://i.ytimg.com/vi/VslnLI-Yjpo/maxresdefault.jpg',
    'description':
        'Komik edukasi yang membantu anak-anak belajar warna dan bentuk melalui kisah yang ceria.',
    'genre': ['Anak', 'Edukasi'],
    'status': 'ongoing',
    'rating': 4.9,
    'totalViews': 5000,
    'chapters': [
      {
        'id': 'ch-1',
        'number': 1,
        'title': 'Mengenal Warna Merah',
        'publishedAt': '2024-06-01',
        'pages': List.generate(10, (index) => 'page_${index + 1}.jpg'),
      },
    ],
  }];