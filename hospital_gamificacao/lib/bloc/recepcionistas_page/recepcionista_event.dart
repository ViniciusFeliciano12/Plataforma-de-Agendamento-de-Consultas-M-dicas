import 'package:hospital_gamificacao/models/recepcionista.dart';

abstract class RecepcionistaEvent {}

class LoadRecepcionistaEvent extends RecepcionistaEvent {
  LoadRecepcionistaEvent();
}

class SaveRecepcionistaEvent extends RecepcionistaEvent {
  Recepcionista recepcionista;
  List<Recepcionista> recepcionistas;

  SaveRecepcionistaEvent(
      {required this.recepcionista, required this.recepcionistas});
}

class RemoveRecepcionistaEvent extends RecepcionistaEvent {
  int recepcionistaID;
  List<Recepcionista> recepcionistas;
  RemoveRecepcionistaEvent(
      {required this.recepcionistaID, required this.recepcionistas});
}

class EditRecepcionistaEvent extends RecepcionistaEvent {
  Recepcionista recepcionista;
  List<Recepcionista> recepcionistas;

  EditRecepcionistaEvent(
      {required this.recepcionista, required this.recepcionistas});
}
