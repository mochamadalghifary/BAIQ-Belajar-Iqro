class UjianModel{
  List<Ujian> listUjian = List<Ujian>();
}

class Ujian {
  String santri_nama, santri_uid, penguji_nama, catatan, url, doc_id;
  bool status;
  int halaman, jilid;


  Ujian({
    this.santri_nama, this.santri_uid, this.penguji_nama, this.catatan,
    this.url, this.status, this.halaman, this.doc_id, this.jilid
  });

  factory Ujian.fromFirestore(Map<String, dynamic> data) {
    return Ujian(
        doc_id: data['doc_id'],
        santri_nama: data['santri_nama'],
        santri_uid: data['santri_uid'],
        penguji_nama: data['penguji_nama'],
        catatan: data['catatan'],
        status: data['status'],
        url: data['audio'],
        halaman: data['halaman'],
        jilid: data['jilid']
    );
  }
}