import 'package:hospital_gamificacao/models/consulta.dart';

class Paciente {
  int id;
  String nome;
  String sobrenome;
  List<Consulta>? consultas;

  Paciente({
    required this.id,
    required this.nome,
    required this.sobrenome,
    this.consultas,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      id: json['id'] as int,
      nome: json['name'] as String,
      sobrenome: json['sobrenome'] as String,
      consultas: json['consultas'] as List<Consulta>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nome,
      'sobrenome': sobrenome,
      'consultas': consultas,
    };
  }
}
