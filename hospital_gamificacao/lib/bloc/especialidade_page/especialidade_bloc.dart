import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_gamificacao/bloc/especialidade_page/especialidade_event.dart';
import 'package:hospital_gamificacao/bloc/especialidade_page/especialidade_state.dart';
import 'package:hospital_gamificacao/models/especialidade.dart';
import 'package:hospital_gamificacao/services/interfaces/ihospital_api.dart';
import 'package:hospital_gamificacao/services/service_locator.dart';

class EspecialidadeBloc extends Bloc<EspecialidadeEvent, EspecialidadeState> {
  final IHospitalApi _apiService = getIt<IHospitalApi>();

  EspecialidadeBloc() : super(EspecialidadeInitialState()) {
    on<LoadEspecialidadeEvent>(
      (event, emit) async {
        List<Especialidade>? response;
        try {
          response = await _apiService.getEspecialidades();
        } catch (e) {
          debugPrint(e.toString());
        }

        if (response != null) {
          if (response.isNotEmpty) {
            emit(
              EspecialidadeSuccessState(
                especialidade: response,
              ),
            );
          } else {
            emit(EspecialidadeErrorState());
          }
        } else {
          emit(EspecialidadeErrorState());
        }
      },
    );

    on<RemoveEspecialidadeEvent>(
      (event, emit) async {
        bool response;
        try {
          response =
              await _apiService.removeRecepcionista(event.especialidadeID);
          if (response != true) {
            emit(EspecialidadeErrorState());
          }
          if (response == true) {
            var especialidades = event.especialidades;
            var item = especialidades
                .where((element) => element.id == event.especialidadeID)
                .first;

            especialidades.remove(item);
            emit(EspecialidadeSuccessState(especialidade: especialidades));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );

    on<SaveEspecialidadeEvent>(
      (event, emit) async {
        bool response;
        try {
          response =
              await _apiService.adicionarEspecialidades(event.especialidade);
          if (response != true) {
            emit(EspecialidadeErrorState());
          }
          if (response == true) {
            var especialidades = event.especialidades;
            especialidades.add(event.especialidade);
            emit(EspecialidadeSuccessState(especialidade: especialidades));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );

    on<EditEspecialidadeEvent>(
      (event, emit) async {
        bool response;
        try {
          response =
              await _apiService.editarEspecialidades(event.especialidade);
          if (response != true) {
            emit(EspecialidadeErrorState());
          }
          if (response == true) {
            var especialidades = event.especialidades;

            for (var item in especialidades) {
              if (item.id == event.especialidade.id) {
                especialidades.remove(item);
                especialidades.add(event.especialidade);
                especialidades.sort((a, b) => a.id.compareTo(b.id));
              }
            }
            emit(EspecialidadeSuccessState(especialidade: especialidades));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
  }
}
