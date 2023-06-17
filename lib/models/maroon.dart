class Maroon {
  int id;
  String nama;
  String message;

  Maroon({required this.id, required this.nama, required this.message});

  factory Maroon.fromJson(Map<String, dynamic> json) => Maroon(
      id: json['id'] as int,
      nama: json['nama'] as String,
      message: json['message'] as String);

  Map<String, dynamic> toJson() => {'id': id, 'nama': nama, 'message': message};
}
