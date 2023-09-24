class Especialidade {
  int id;
  String especialidade;
  String descricao;

  Especialidade({
    required this.id,
    required this.especialidade,
    required this.descricao,
  });

  factory Especialidade.fromJson(Map<String, dynamic> json) {
    return Especialidade(
      id: json['id'] as int,
      especialidade: json['especialidade'] as String,
      descricao: json['descricao'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'especialidade': especialidade,
      'descricao': descricao,
    };
  }
}
