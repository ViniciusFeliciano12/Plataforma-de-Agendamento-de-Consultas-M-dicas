import 'package:hospital_gamificacao/models/especialidade.dart';
import 'package:hospital_gamificacao/models/paciente.dart';

abstract class PacienteEvent {}

class LoadPacienteEvent extends PacienteEvent {
  LoadPacienteEvent();
}

class SavePacienteEvent extends PacienteEvent {
  Paciente paciente;
  List<Paciente> pacientes;

  SavePacienteEvent({required this.paciente, required this.pacientes});
}

class RemovePacienteEvent extends PacienteEvent {
  int pacienteID;
  List<Paciente> pacientes;
  RemovePacienteEvent({required this.pacienteID, required this.pacientes});
}

class EditPacienteEvent extends PacienteEvent {
  Paciente paciente;
  List<Paciente> pacientes;

  EditPacienteEvent({required this.paciente, required this.pacientes});
}
