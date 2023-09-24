import 'package:hospital_gamificacao/models/especialidade.dart';

abstract class EspecialidadeState {}

class EspecialidadeInitialState extends EspecialidadeState {
  EspecialidadeInitialState() : super();
}

class EspecialidadeSuccessState extends EspecialidadeState {
  List<Especialidade> especialidade;
  EspecialidadeSuccessState({required this.especialidade}) : super();
}

class EspecialidadeErrorState extends EspecialidadeState {
  EspecialidadeErrorState() : super();
}
