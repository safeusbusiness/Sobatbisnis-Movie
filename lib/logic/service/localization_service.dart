import 'dart:ui';
import 'package:get/get.dart';

class LocalizationService extends Translations {
  static final locale = Locale('en', 'US');
  static final fallbackLocale = Locale('en', 'US');

  static final langs = [
    'English',
    'Indonesia',
  ];

  static final locales = [
    const Locale('en', 'US'),
    const Locale('id', 'ID'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': GlobalLanguage.enUS,
        'id_ID': GlobalLanguage.idID,
      };

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale!;
  }
}

class GlobalLanguage {
  static const Map<String, String> enUS = {
    'confirm': 'Confirmation',
    'login_desc_1': 'Find best movie in this year.',
    'login_desc_2': 'Join for Free!',
    'password': 'Password',
    'register': 'Register Account',
    'login_google': 'Login with Google',
    'change_language': 'Change Language',
    'which_language_prefer': 'Which language do you prefer?',
    'save': 'Save',
    'cancel': 'Cancel',
    'required': 'Required',
    'login_failed': 'Username or Password is not found...',
    'login_success': 'Login Success',
    'registration_success': 'Registration Success',
    'registration_failed_username': 'Username is Already Used',
    'registration_failed_phone': 'Phone Number is Already Used',
    'load_more': 'Load More',
    'load_more_error': 'Failed to Load, please try again later',
    'load_more_release': 'Release to load more',
    'load_more_no_data': 'There is no data to load more',
    'see_photo': 'See Photo',
    'movie_list': 'Movie List',
    'error_text_phone_number': 'Phone Number not match',
    'error_text_email': 'Email not match',
    'find_movie': 'Find movie here...',
    'top_movie_this_year': 'Top Movie this Year',
    'suggested_movie': 'Suggested for you',
    'cannot_find': 'We cannot find',
    'change': 'Change',
    'upload': 'Upload',
    'see_picture': 'See Picture',
    'from_gallery': 'From Gallery',
    'success_save_information': 'Success Save Information',
    'input_fullname': 'Input your Full Name',
    'input_phonenumber': 'Input your Phone Number',
    'full_name': 'Full Name',
    'phone_number': 'Phone Number',
    'change_profile': 'Change Profile',
    'input_old_password': 'Input Old Password',
    'input_new_password': 'Input New Password',
    'input_renew_password': 'Re-input New Password',
    'old_password': 'Old Password',
    'new_password': 'New Password',
    'renew_password': 'Re-New Passowrd',
    'wrong_password': 'Wrong Password',
    'password_not_match': 'Password Not Match',
    'press_once_out_app': 'Press again to exit the App',
    'sign_out': 'Sign Out',
    'sign_out_desc': 'Are your sure want to Sign Out?',
    'overview': 'Overview',
    'your_favorite_movie_tv': 'Your Favorite Movie & Tv',
    'no_favorit_movie': 'There is no Favorite Movie...',
    'settings': 'Settings',
    'edit_personal_detail': 'Edit Personal Details',
    'profile': 'Profile',
    'change_password': 'Change Password',
    'language': 'Language',
    'other': 'Other',
    'about_us': 'About Us',
    'logout': 'Logout',
    'interested': "Hi, we're interested with you to come and join with us",
    'title_about_us': 'FIND MOVIE MORE EASY AND MORE ACCURATE',
    'about_developer': 'About Developer',
    'developer_contact': 'Developer Contact',
    'accepted_send_email': 'Accepted As Mobile Developer',
    'find_tv': 'Find TV Channel here...',
    'top_tv_this_year': 'Top TV This Year',
    'empty_genre': 'Empty Genre',
    'no_description': 'No Description',
    'review': 'Review',
    'write_opinion': 'Write your Opinion here...',
    'you': 'You'
  };
  static const Map<String, String> idID = {
    'confirm': 'Konfirmasi',
    'login_desc_1': 'Temukan Film terbaik ditahun ini.',
    'login_desc_2': 'Bergabunglah secara Gratis!',
    'password': 'Kata Sandi',
    'register': 'Daftar Akun',
    'login_google': 'Masuk dengan Google',
    'change_language': 'Ubah Bahasa',
    'which_language_prefer': 'Bahasa mana yang anda inginkan?',
    'save': 'Simpan',
    'cancel': 'Batalkan',
    'required': 'Wajib Diisi',
    'login_failed': 'Username atau Kata Sandi tidak ditemukan...',
    'login_success': 'Login Berhasil',
    'registration_success': 'Registrasi Berhasil',
    'registration_failed_username': 'Username telah digunakan',
    'registration_failed_phone': 'Nomor Telepon telah digunakan',
    'load_more': 'Memuat lebih Banyak',
    'load_more_error': 'Gagal memuat, mohon coba lagi',
    'load_more_release': 'Lepaskan untuk Memuat lebih banyak',
    'load_more_no_data': 'Tidak ada Data untuk dimuat',
    'see_photo': 'Lihat Foto',
    'movie_list': 'Daftar Film',
    'find_movie': 'Cari film disini...',
    'top_movie_this_year': 'Film terbaik Tahun ini',
    'suggested_movie': 'Disarankan untuk Anda',
    'cannot_find': 'Kita tidak dapat menemukan',
    'change': 'Ubah',
    'upload': 'Unggah',
    'see_picture': 'Lihat Gambar',
    'from_gallery': 'Dari Galeri',
    'success_save_information': 'Berhasil Menyimpan Informasi',
    'input_fullname': 'Masukkan Nama Lengkap',
    'input_phonenumber': 'Masukkan Nomor Telepon',
    'full_name': 'Nama Lengkap',
    'phone_number': 'Nomor Telepon',
    'change_profile': 'Ubah Profil',
    'input_old_password': 'Masukkan Kata Sandi Lama',
    'input_new_password': 'Masukkan Kata Sandi Baru',
    'input_renew_password': 'Ulangi Masukkan Kata Sandi Baru',
    'old_password': 'Kata Sandi Lama',
    'new_password': 'Kata Sandi Baru',
    'renew_password': 'Ulangi Kata Sandi Baru',
    'wrong_password': 'Kata Sandi Salah',
    'password_not_match': 'Kata Sandi Tidak Sesuai',
    'press_once_out_app': 'Tekan sekali lagi untuk keluar dari Aplikasi',
    'sign_out': 'Keluar Akun',
    'sign_out_desc': 'Apakah Anda yakin untuk Keluar Akun?',
    'overview': 'Ringkasan',
    'your_favorite_movie_tv': 'Film & Tv Favorit Anda',
    'no_favorit_movie': 'Tidak ada Favorit Film....',
    'settings': 'Pengaturan',
    'edit_personal_detail': 'Ubah Detail Informasi',
    'profile': 'Profil',
    'change_password': 'Ubah Kata Sandi',
    'language': 'Bahasa',
    'other': 'Lainnya',
    'about_us': 'Tentang Kami',
    'logout': 'Keluar Akun',
    'interested':
        "Hai, kami tertarik dengan Anda untuk datang dan bergabung bersama kami",
    'title_about_us': 'TEMUKAN FILM LEBIH MUDAH DAN LEBIH AKURAT',
    'about_developer': 'Tentang Pengembang',
    'developer_contact': 'Kontak Pengembang',
    'accepted_send_email': 'Diterima Sebagai Mobile Developer',
    'find_tv': 'Cari TV Channel disini...',
    'top_tv_this_year': 'TV Terbaik Tahun',
    'empty_genre': 'Genre Kosong',
    'no_description': 'Tidak ada Deskripsi',
    'review': 'Tinjauan',
    'write_opinion': 'Tuliskan opini kamu disini...',
    'you': 'Anda'
  };
}
