class Intro {
  final String title;
  final String image;
  final String text;

  Intro({
    required this.title,
    required this.image,
    required this.text,
  });
}

List<Intro> contents = [
  Intro(
    title: 'Selamat Datang di Aplikasi Pengiriman Paket',
    image: 'assets/img1.png',
    text: 'Kirim paket Anda dengan mudah dan cepat menggunakan aplikasi kami.',
  ),
  Intro(
    title: 'Lacak Pengiriman Anda Secara Real-Time',
    image: 'assets/img2.png',
    text:
        'Dapatkan informasi terkini tentang status pengiriman Anda di setiap langkah perjalanan.',
  ),
  Intro(
    title: 'Pilih Layanan Pengiriman Terbaik',
    image: 'assets/img3.png',
    text:
        'Kami menyediakan berbagai opsi layanan pengiriman dengan tarif yang bersaing.',
  ),
];
