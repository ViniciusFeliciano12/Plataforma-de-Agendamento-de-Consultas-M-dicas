import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_gamificacao/bloc/recepcionistas_page/recepcionista_event.dart';
import 'package:hospital_gamificacao/bloc/recepcionistas_page/recepcionista_state.dart';
import 'package:hospital_gamificacao/models/recepcionista.dart';
import 'package:hospital_gamificacao/services/interfaces/ihospital_api.dart';
import 'package:hospital_gamificacao/services/service_locator.dart';

class RecepcionistaBloc extends Bloc<RecepcionistaEvent, RecepcionistaState> {
  final IHospitalApi _apiService = getIt<IHospitalApi>();

  RecepcionistaBloc() : super(RecepcionistaInitialState()) {
    on<LoadRecepcionistaEvent>(
      (event, emit) async {
        List<Recepcionista>? response;
        try {
          response = await _apiService.getRecepcionistas();
        } catch (e) {
          debugPrint(e.toString());
        }

        if (response != null) {
          if (response.isNotEmpty) {
            emit(
              RecepcionistaSuccessState(
                recepcionista: response,
              ),
            );
          } else {
            emit(RecepcionistaErrorState());
          }
        } else {
          emit(RecepcionistaErrorState());
        }
      },
    );

    on<RemoveRecepcionistaEvent>(
      (event, emit) async {
        bool response;
        try {
          response =
              await _apiService.removeRecepcionista(event.recepcionistaID);
          if (response != true) {
            emit(RecepcionistaErrorState());
          }
          if (response == true) {
            var recepcionistas = event.recepcionistas;
            var item = recepcionistas
                .where((element) => element.id == event.recepcionistaID)
                .first;

            recepcionistas.remove(item);
            emit(RecepcionistaSuccessState(recepcionista: recepcionistas));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );

    on<SaveRecepcionistaEvent>(
      (event, emit) async {
        bool response;
        try {
          response =
              await _apiService.adicionarRecepcionista(event.recepcionista);
          if (response != true) {
            emit(RecepcionistaErrorState());
          }
          if (response == true) {
            var recepcionistas = event.recepcionistas;
            recepcionistas.add(event.recepcionista);
            emit(RecepcionistaSuccessState(recepcionista: recepcionistas));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );

    on<EditRecepcionistaEvent>(
      (event, emit) async {
        bool response;
        try {
          response = await _apiService.editarRecepcionista(event.recepcionista);
          if (response != true) {
            emit(RecepcionistaErrorState());
          }
          if (response == true) {
            var recepcionistas = event.recepcionistas;

            for (var item in recepcionistas) {
              if (item.id == event.recepcionista.id) {
                recepcionistas.remove(item);
                recepcionistas.add(event.recepcionista);
                recepcionistas.sort((a, b) => a.id.compareTo(b.id));
              }
            }
            emit(RecepcionistaSuccessState(recepcionista: recepcionistas));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
  }
}
