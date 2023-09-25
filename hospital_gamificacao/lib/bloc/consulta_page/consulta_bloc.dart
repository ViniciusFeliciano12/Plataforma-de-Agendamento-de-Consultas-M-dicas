import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_gamificacao/bloc/consulta_page/consulta_event.dart';
import 'package:hospital_gamificacao/bloc/consulta_page/consulta_state.dart';
import 'package:hospital_gamificacao/models/consulta.dart';
import 'package:hospital_gamificacao/services/interfaces/ihospital_api.dart';
import 'package:hospital_gamificacao/services/service_locator.dart';

class ConsultaBloc extends Bloc<ConsultaEvent, ConsultaState> {
  final IHospitalApi _apiService = getIt<IHospitalApi>();

  ConsultaBloc() : super(ConsultaInitialState()) {
    on<LoadConsultaEvent>(
      (event, emit) async {
        List<Consulta>? response;
        try {
          response = await _apiService.getConsultas();
        } catch (e) {
          debugPrint(e.toString());
        }

        if (response != null) {
          if (response.isNotEmpty) {
            emit(
              ConsultaSuccessState(
                consulta: response,
              ),
            );
          } else {
            emit(ConsultaErrorState());
          }
        } else {
          emit(ConsultaErrorState());
        }
      },
    );

    on<RemoveConsultaEvent>(
      (event, emit) async {
        bool response;
        try {
          response = await _apiService.removeConsulta(event.consultaID);
          if (response != true) {
            emit(ConsultaErrorState());
          }
          if (response == true) {
            var consultas = event.consultas;
            var item = consultas
                .where((element) => element.id == event.consultaID)
                .first;

            consultas.remove(item);
            emit(ConsultaSuccessState(consulta: consultas));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );

    on<SaveConsultaEvent>(
      (event, emit) async {
        bool response;
        try {
          response = await _apiService.adicionarConsulta(event.consulta);
          if (response != true) {
            emit(ConsultaErrorState());
          }
          if (response == true) {
            var consultas = event.consultas;
            consultas.add(event.consulta);
            emit(ConsultaSuccessState(consulta: consultas));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );

    on<EditConsultaEvent>(
      (event, emit) async {
        bool response;
        try {
          response = await _apiService.editarConsulta(event.consulta);
          if (response != true) {
            emit(ConsultaErrorState());
          }
          if (response == true) {
            var consultas = event.consultas;

            for (var item in consultas) {
              if (item.id == event.consulta.id) {
                consultas.remove(item);
                consultas.add(event.consulta);
                consultas.sort((a, b) => a.id.compareTo(b.id));
              }
            }
            emit(ConsultaSuccessState(consulta: consultas));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
  }
}
