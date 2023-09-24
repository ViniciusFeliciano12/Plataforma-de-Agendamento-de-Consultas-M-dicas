import 'package:hospital_gamificacao/models/recepcionista.dart';

abstract class RecepcionistaState {}

class RecepcionistaInitialState extends RecepcionistaState {
  RecepcionistaInitialState() : super();
}

class RecepcionistaSuccessState extends RecepcionistaState {
  List<Recepcionista> recepcionista;
  RecepcionistaSuccessState({required this.recepcionista}) : super();
}

class RecepcionistaErrorState extends RecepcionistaState {
  RecepcionistaErrorState() : super();
}
