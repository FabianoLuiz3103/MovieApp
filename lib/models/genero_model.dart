class Genero{
  int id;
  String nome;

  Genero({required this.id, required this.nome});

  factory Genero.fromJson(Map<String, dynamic> json) => Genero(
    id: json['id'],
    nome: json['name']
  );
}