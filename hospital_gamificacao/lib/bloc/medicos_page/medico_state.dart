import 'package:hospital_gamificacao/models/medico.dart';

abstract class MedicoState {}

class MedicoInitialState extends MedicoState {
  MedicoInitialState() : super();
}

class MedicoSuccessState extends MedicoState {
  List<Medico> medico;
  MedicoSuccessState({required this.medico}) : super();
}

class MedicoErrorState extends MedicoState {
  MedicoErrorState() : super();
}
