import 'package:hospital_gamificacao/models/paciente.dart';

abstract class PacienteState {}

class PacienteInitialState extends PacienteState {
  PacienteInitialState() : super();
}

class PacienteSuccessState extends PacienteState {
  List<Paciente> paciente;
  PacienteSuccessState({required this.paciente}) : super();
}

class PacienteErrorState extends PacienteState {
  PacienteErrorState() : super();
}
