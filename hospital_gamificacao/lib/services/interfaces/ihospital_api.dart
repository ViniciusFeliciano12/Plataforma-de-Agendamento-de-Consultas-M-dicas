import 'package:hospital_gamificacao/models/consulta.dart';
import 'package:hospital_gamificacao/models/especialidade.dart';
import 'package:hospital_gamificacao/models/medico.dart';
import 'package:hospital_gamificacao/models/paciente.dart';

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

  //pacientes
  Future<List<Paciente>> getPacientes();
  Future<bool> removePaciente(int id);
  Future<bool> adicionarPaciente(Paciente paciente);
  Future<bool> editarPaciente(Paciente paciente);

  //medicos
  Future<List<Medico>> getMedicos();
  Future<bool> removeMedico(int id);
  Future<bool> adicionarMedico(Medico medico);
  Future<bool> editarMedico(Medico medico);

  //consultas
  Future<List<Consulta>> getConsultas();
  Future<bool> removeConsulta(int id);
  Future<bool> adicionarConsulta(Consulta consulta);
  Future<bool> editarConsulta(Consulta consulta);
}
