class Recepcionista {
  int id;
  String nome;
  String sobrenome;
  int telefone;

  Recepcionista({
    required this.id,
    required this.nome,
    required this.sobrenome,
    required this.telefone,
  });

  factory Recepcionista.fromJson(Map<String, dynamic> json) {
    return Recepcionista(
      id: json['id'] as int,
      nome: json['name'] as String,
      sobrenome: json['sobrenome'] as String,
      telefone: json['telefone'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nome,
      'sobrenome': sobrenome,
      'telefone': telefone,
    };
  }
}
