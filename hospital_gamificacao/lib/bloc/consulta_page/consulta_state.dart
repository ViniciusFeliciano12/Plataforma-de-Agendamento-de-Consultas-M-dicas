import 'package:hospital_gamificacao/models/consulta.dart';

abstract class ConsultaState {}

class ConsultaInitialState extends ConsultaState {
  ConsultaInitialState() : super();
}

class ConsultaSuccessState extends ConsultaState {
  List<Consulta> consulta;
  ConsultaSuccessState({required this.consulta}) : super();
}

class ConsultaErrorState extends ConsultaState {
  ConsultaErrorState() : super();
}
