class Nilai {
  String santri_nama, santri_uid, penguji_nama, catatan, url;
  bool status;
  int halaman;


  Nilai({
    this.santri_nama, this.santri_uid, this.penguji_nama, this.catatan,
    this.url, this.status, this.halaman
  });

  factory Nilai.fromFirestore(Map<String, dynamic> data) {
    return Nilai(
      santri_nama: data['santri_nama'],
      santri_uid: data['santri_uid'],
      penguji_nama: data['penguji_nama'],
      catatan: data['catatan'],
      status: data['status'],
      url: data['url'],
      halaman: data['halaman']
    );
  }
}