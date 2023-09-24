import 'package:hospital_gamificacao/models/especialidade.dart';

import '../../models/recepcionista.dart';

abstract class IHospitalApi {
  //recepcionistas
  Future<List<Recepcionista>> getRecepcionistas();
  Future<bool> removeRecepcionista(int id);
  Future<bool> adicionarRecepcionista(Recepcionista recepcionista);
  Future<bool> editarRecepcionista(Recepcionista recepcionista);

  //especialidades
  Future<List<Especialidade>> getEspecialidades();
  Future<bool> removeEspecialidades(int id);
  Future<bool> adicionarEspecialidades(Especialidade especialidade);
  Future<bool> editarEspecialidades(Especialidade especialidade);
}
