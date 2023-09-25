import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_gamificacao/bloc/home_page/home_event.dart';
import 'package:hospital_gamificacao/bloc/home_page/home_state.dart';
import 'package:hospital_gamificacao/bloc/medicos_page/medico_event.dart';
import 'package:hospital_gamificacao/bloc/medicos_page/medico_state.dart';
import 'package:hospital_gamificacao/models/medico.dart';
import 'package:hospital_gamificacao/services/interfaces/ihospital_api.dart';
import 'package:hospital_gamificacao/services/service_locator.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IHospitalApi _apiService = getIt<IHospitalApi>();

  HomeBloc() : super(HomeInicialState()) {
    on<LoadHomeEvent>(
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
              HomeSuccessState(),
            );
          } else {
            emit(HomeErrorState());
          }
        } else {
          emit(HomeErrorState());
        }
      },
    );
  }
}
