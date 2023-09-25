class Consulta {
  int id;
  DateTime dataEHora;
  String tipoConsulta;
  String observacoes;
  int medicoId;
  int pacienteId;

  Consulta({
    required this.id,
    required this.dataEHora,
    required this.tipoConsulta,
    required this.observacoes,
    required this.medicoId,
    required this.pacienteId,
  });

  factory Consulta.fromJson(Map<String, dynamic> json) {
    return Consulta(
      id: json['id'] as int,
      dataEHora: DateTime.parse(json['dataEHora'] as String),
      tipoConsulta: json['tipoConsulta'] as String,
      observacoes: json['observacoes'] as String,
      medicoId: json['medicoId'] as int,
      pacienteId: json['pacienteId'] as int,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dataEHora': dataEHora.toIso8601String(),
      'tipoConsulta': tipoConsulta,
      'observacoes': observacoes,
      'medicoId': medicoId,
      'pacienteId': pacienteId
    };
  }
}
