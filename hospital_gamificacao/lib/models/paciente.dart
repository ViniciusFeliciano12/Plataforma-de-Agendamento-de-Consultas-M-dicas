import 'package:hospital_gamificacao/models/consulta.dart';

class Paciente {
  int id;
  String name;
  String sobrenome;
  List<Consulta> consultasMedicas;

  Paciente({
    required this.id,
    required this.name,
    required this.sobrenome,
    required this.consultasMedicas,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) {
    var consultasMedicasJson = json['consultasMedicas'] as List<dynamic>;

    return Paciente(
      id: json['id'] as int,
      name: json['name'] as String,
      sobrenome: json['sobrenome'] as String,
      consultasMedicas: consultasMedicasJson
          .map((consultaJson) => Consulta.fromJson(consultaJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sobrenome': sobrenome,
    };
  }
}
