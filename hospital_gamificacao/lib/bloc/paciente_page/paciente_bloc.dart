import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_gamificacao/bloc/paciente_page/paciente_event.dart';
import 'package:hospital_gamificacao/bloc/paciente_page/paciente_state.dart';
import 'package:hospital_gamificacao/models/paciente.dart';
import 'package:hospital_gamificacao/services/interfaces/ihospital_api.dart';
import 'package:hospital_gamificacao/services/service_locator.dart';

class PacienteBloc extends Bloc<PacienteEvent, PacienteState> {
  final IHospitalApi _apiService = getIt<IHospitalApi>();

  PacienteBloc() : super(PacienteInitialState()) {
    on<LoadPacienteEvent>(
      (event, emit) async {
        List<Paciente>? response;
        try {
          response = await _apiService.getPacientes();
        } catch (e) {
          debugPrint(e.toString());
        }

        if (response != null) {
          if (response.isNotEmpty) {
            emit(
              PacienteSuccessState(
                paciente: response,
              ),
            );
          } else {
            emit(PacienteErrorState());
          }
        } else {
          emit(PacienteErrorState());
        }
      },
    );

    on<RemovePacienteEvent>(
      (event, emit) async {
        bool response;
        try {
          response = await _apiService.removePaciente(event.pacienteID);
          if (response != true) {
            emit(PacienteErrorState());
          }
          if (response == true) {
            var pacientes = event.pacientes;
            var item = pacientes
                .where((element) => element.id == event.pacienteID)
                .first;

            pacientes.remove(item);
            emit(PacienteSuccessState(paciente: pacientes));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );

    on<SavePacienteEvent>(
      (event, emit) async {
        bool response;
        try {
          response = await _apiService.adicionarPaciente(event.paciente);
          if (response != true) {
            emit(PacienteErrorState());
          }
          if (response == true) {
            var especialidades = event.pacientes;
            especialidades.add(event.paciente);
            emit(PacienteSuccessState(paciente: especialidades));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );

    on<EditPacienteEvent>(
      (event, emit) async {
        bool response;
        try {
          response = await _apiService.editarPaciente(event.paciente);
          if (response != true) {
            emit(PacienteErrorState());
          }
          if (response == true) {
            var pacientes = event.pacientes;

            for (var item in pacientes) {
              if (item.id == event.paciente.id) {
                pacientes.remove(item);
                pacientes.add(event.paciente);
                pacientes.sort((a, b) => a.id.compareTo(b.id));
              }
            }
            emit(PacienteSuccessState(paciente: pacientes));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
  }
}
