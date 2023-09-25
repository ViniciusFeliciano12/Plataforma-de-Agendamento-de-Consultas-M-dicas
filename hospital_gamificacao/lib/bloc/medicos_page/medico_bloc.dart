import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_gamificacao/bloc/medicos_page/medico_event.dart';
import 'package:hospital_gamificacao/bloc/medicos_page/medico_state.dart';
import 'package:hospital_gamificacao/models/medico.dart';
import 'package:hospital_gamificacao/services/interfaces/ihospital_api.dart';
import 'package:hospital_gamificacao/services/service_locator.dart';

class MedicoBloc extends Bloc<MedicoEvent, MedicoState> {
  final IHospitalApi _apiService = getIt<IHospitalApi>();

  MedicoBloc() : super(MedicoInitialState()) {
    on<LoadMedicoEvent>(
      (event, emit) async {
        List<Medico>? response;
        try {
          response = await _apiService.getMedicos();
        } catch (e) {
          debugPrint(e.toString());
        }

        if (response != null) {
          if (response.isNotEmpty) {
            emit(
              MedicoSuccessState(
                medico: response,
              ),
            );
          } else {
            emit(MedicoErrorState());
          }
        } else {
          emit(MedicoErrorState());
        }
      },
    );

    on<RemoveMedicoEvent>(
      (event, emit) async {
        bool response;
        try {
          response = await _apiService.removeMedico(event.medicoID);
          if (response != true) {
            emit(MedicoErrorState());
          }
          if (response == true) {
            var medicos = event.medicos;
            var item =
                medicos.where((element) => element.id == event.medicoID).first;

            medicos.remove(item);
            emit(MedicoSuccessState(medico: medicos));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );

    on<SaveMedicoEvent>(
      (event, emit) async {
        bool response;
        try {
          response = await _apiService.adicionarMedico(event.medico);
          if (response != true) {
            emit(MedicoErrorState());
          }
          if (response == true) {
            var medicos = event.medicos;
            medicos.add(event.medico);
            emit(MedicoSuccessState(medico: medicos));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );

    on<EditMedicoEvent>(
      (event, emit) async {
        bool response;
        try {
          response = await _apiService.editarMedico(event.medico);
          if (response != true) {
            emit(MedicoErrorState());
          }
          if (response == true) {
            var medicos = event.medicos;

            for (var item in medicos) {
              if (item.id == event.medico.id) {
                medicos.remove(item);
                medicos.add(event.medico);
                medicos.sort((a, b) => a.id.compareTo(b.id));
              }
            }
            emit(MedicoSuccessState(medico: medicos));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
  }
}
