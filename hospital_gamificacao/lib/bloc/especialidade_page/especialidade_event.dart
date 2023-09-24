import 'package:hospital_gamificacao/models/especialidade.dart';

abstract class EspecialidadeEvent {}

class LoadEspecialidadeEvent extends EspecialidadeEvent {
  LoadEspecialidadeEvent();
}

class SaveEspecialidadeEvent extends EspecialidadeEvent {
  Especialidade especialidade;
  List<Especialidade> especialidades;

  SaveEspecialidadeEvent(
      {required this.especialidade, required this.especialidades});
}

class RemoveEspecialidadeEvent extends EspecialidadeEvent {
  int especialidadeID;
  List<Especialidade> especialidades;
  RemoveEspecialidadeEvent(
      {required this.especialidadeID, required this.especialidades});
}

class EditEspecialidadeEvent extends EspecialidadeEvent {
  Especialidade especialidade;
  List<Especialidade> especialidades;

  EditEspecialidadeEvent(
      {required this.especialidade, required this.especialidades});
}
