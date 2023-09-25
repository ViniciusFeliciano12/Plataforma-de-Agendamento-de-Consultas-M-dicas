import 'package:hospital_gamificacao/models/medico.dart';

abstract class MedicoEvent {}

class LoadMedicoEvent extends MedicoEvent {
  LoadMedicoEvent();
}

class SaveMedicoEvent extends MedicoEvent {
  Medico medico;
  List<Medico> medicos;

  SaveMedicoEvent({required this.medico, required this.medicos});
}

class RemoveMedicoEvent extends MedicoEvent {
  int medicoID;
  List<Medico> medicos;
  RemoveMedicoEvent({required this.medicoID, required this.medicos});
}

class EditMedicoEvent extends MedicoEvent {
  Medico medico;
  List<Medico> medicos;

  EditMedicoEvent({required this.medico, required this.medicos});
}
