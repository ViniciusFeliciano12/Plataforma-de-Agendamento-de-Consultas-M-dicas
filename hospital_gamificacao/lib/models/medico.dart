import 'package:hospital_gamificacao/models/consulta.dart';

class Medico {
  int id;
  String name;
  String especialidade;
  String registroProfissional;
  List<Consulta>? horariosDisponiveis;

  Medico({
    required this.id,
    required this.name,
    required this.especialidade,
    required this.registroProfissional,
    required this.horariosDisponiveis,
  });

  factory Medico.fromJson(Map<String, dynamic> json) {
    return Medico(
      id: json['id'],
      name: json['name'],
      especialidade: json['especialidade'],
      registroProfissional: json['registroProfissional'],
      horariosDisponiveis: List<Consulta>.from(json['horariosDisponiveis']),
    );
  }
}
