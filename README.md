# Perkenalan

Hi Sobatbisnis Team, saya Gerzha Hayat Prakarsha, terima kasih atas kesempatan kepada saya untuk kiranya diberikan kesempatan untuk dapat bergabung dengan Perusahaan Sobatbisnis, this is an honor for me, semoga Aplikasi yang sudah saya buat sesuai dengan keinginan Sobatbisnis Team.

Project ini saya buat dengan nama Elemovie, dan membuat gambar/logo dari Aplikasi ini menggunakan https://www.tailorbrands.com/. Bisa dijalankan di Android dan Ios.

# Dokumentasi Penginstalan dan Jalankan Program (Android)

1. Download dan Extract Source Code
2. Flutter pub get
3. Flutter run

# Dokumentasi Penginstalan dan Jalankan Program (Ios)

1. Download dan Extract Source Code
2. Flutter pub get
3. cd ios
4. pod install
5. Flutter run

# Login User dan Password di App

1. Username: sobatbisnis
2. Password: 12345

# Library

1. Getx, sebagai main dari struktur code yang saya gunakan untuk mendevelop Aplikasi ini.
2. Google Fonts, sebagai default font dari Aplikasi ini.
3. Shared Preferences, sebagai penyimpanan data yang bersifat offline kedalam Local Storage pengguna.
4. Encrypt, demi meningkatkan keamanan Aplikasi, saya gunakan Library Encrypt, untuk dapat membuat code/data yang tersimpan kedalam Local Storage pengguna, maupun menghindari dari hacking/perubahan/pencurian data secara sengaja oleh User.
5. Persistent Bottom Navigation Bar, saya gunakan di tampilan InitScreen, untuk bagian menu dibagian bawah.
6. Flutter Toast, untuk menampilkan pesan berupa dialog apabila terjadi kesalahan Aplikasi atau sukses mengunggah Informasi.
7. Dio, sebagai main connetivity terhadap pengambilan data API.
8. Connectivity, untuk mengecek/memastikan bahwa, pada saat User mengambil data API, koneksifitas User terhubung dengan Internet, library ini saya integrate dengan Dio, dibagian logic -> controller -> service -> api_service.dart.
9. Intl, saya gunakan untuk me-format timestamp kedalam bentuk date.
10. Geolocator, saya gunakan untuk mengambil titik lokasi User, untuk mengambil data Weather User.
11. Weather, untuk mengambil weather/suhu saat ini dengan integrate dengan Library Geolocator, yang ada di tampilan LoginScreen.
12. Awesome Dialog, untuk menampilkan pesan dialog.
13. Pull To Refresh, merupakan salah satu fungsi Infinite Scroll untuk menampilkan data selanjutnya.
14. Cached Network Image, untuk menampilkan gambar.
15. Photo View, untuk melihat gambar secara detail, pada saat user menekan gambar yang ada di detail movie.
16. Flutter Rating Bar, untuk menampilkan bintang/rating di list movie maupun detail movie.
17. Shimmer, untuk menampilan loading item pada saat sedang mengambil suatu data.
18. Lottie, untuk menampilkan gambar bergerak apabila data kosong.
19. Image Picker, untuk mengambil gambar di Smartphone pengguna apabila ingin mengubah foto profil.
20. Url Launcher, digunakan untuk launch ke whatsapp dan email di tampilan AboutScreen.
21. Flutter Launcher Icons, digunakan untuk generate icon Android/Ios.
22. Sqflite, sesuai dengan requirement, saya gunakan untuk menyimpan data ke sqlite.
