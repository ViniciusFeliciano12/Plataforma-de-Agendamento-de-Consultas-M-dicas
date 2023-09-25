import 'package:hospital_gamificacao/models/consulta.dart';
import 'package:hospital_gamificacao/models/especialidade.dart';

class Medico {
  int id;
  String name;
  Especialidade? especialidade;
  String registroProfissional;
  List<Consulta> consultasMedicas;

  Medico({
    required this.id,
    required this.name,
    this.especialidade,
    required this.registroProfissional,
    required this.consultasMedicas,
  });

  factory Medico.fromJson(Map<String, dynamic> json) {
    var especialidadeJson = json['especialidade'] as Map<String, dynamic>;
    var consultasMedicasJson = json['consultasMedicas'] as List<dynamic>;

    return Medico(
      id: json['id'] as int,
      name: json['name'] as String,
      especialidade: especialidadeJson == null
          ? null
          : Especialidade.fromJson(especialidadeJson),
      registroProfissional: json['registroProfissional'] as String,
      consultasMedicas: consultasMedicasJson
          .map((consultaJson) => Consulta.fromJson(consultaJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'especialidade': especialidade!.toJson(),
      'registroProfissional': registroProfissional,
    };
  }
}
