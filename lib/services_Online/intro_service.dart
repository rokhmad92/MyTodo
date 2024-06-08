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
    title: 'Atur Tugas dengan Mudah',
    image: 'assets/img1.png',
    text: 'Organisasi yang efisien dengan daftar tugas yang teratur.',
  ),
  Intro(
    title: 'Pantau Kemajuan Anda',
    image: 'assets/img2.png',
    text: 'Lihat status tugas Anda secara real-time dan tetap terinformasi.',
  ),
  Intro(
    title: 'Jadwalkan Pekerjaan dengan Lebih Baik',
    image: 'assets/img3.png',
    text: 'Tingkatkan produktifitas anda.',
  ),
];
