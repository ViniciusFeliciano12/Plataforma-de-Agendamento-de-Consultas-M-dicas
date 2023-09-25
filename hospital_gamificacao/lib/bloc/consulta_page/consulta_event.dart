import 'package:hospital_gamificacao/models/consulta.dart';

abstract class ConsultaEvent {}

class LoadConsultaEvent extends ConsultaEvent {
  LoadConsultaEvent();
}

class SaveConsultaEvent extends ConsultaEvent {
  Consulta consulta;
  List<Consulta> consultas;

  SaveConsultaEvent({required this.consulta, required this.consultas});
}

class RemoveConsultaEvent extends ConsultaEvent {
  int consultaID;
  List<Consulta> consultas;
  RemoveConsultaEvent({required this.consultaID, required this.consultas});
}

class EditConsultaEvent extends ConsultaEvent {
  Consulta consulta;
  List<Consulta> consultas;

  EditConsultaEvent({required this.consulta, required this.consultas});
}
