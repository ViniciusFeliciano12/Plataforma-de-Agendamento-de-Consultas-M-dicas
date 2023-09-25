import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_gamificacao/bloc/consulta_page/consulta_bloc.dart';
import 'package:hospital_gamificacao/bloc/consulta_page/consulta_event.dart';
import 'package:hospital_gamificacao/bloc/consulta_page/consulta_state.dart';
import 'package:hospital_gamificacao/models/consulta.dart';
import 'package:hospital_gamificacao/models/medico.dart';
import 'package:hospital_gamificacao/models/paciente.dart';
import 'package:hospital_gamificacao/services/interfaces/ihospital_api.dart';
import 'package:hospital_gamificacao/view/top_navigation_bar.dart';

import '../services/service_locator.dart';

class ConsultaPage extends StatefulWidget {
  const ConsultaPage({super.key});

  @override
  State<ConsultaPage> createState() => _ConsultaPageState();
}

class _ConsultaPageState extends State<ConsultaPage> {
  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const TopNavigationBar(selectedIndex: 6),
        const Text("Lista de pacientes:"),
        const SizedBox(height: 10),
        Flexible(
          child: BlocBuilder<ConsultaBloc, ConsultaState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is ConsultaInitialState) {
                return const Text("Initial state");
              }
              if (state is ConsultaErrorState) {
                return const Text("error state / vazio");
              }
              if (state is ConsultaSuccessState) {
                consultas = state.consulta;
                return ListView.separated(
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: consultas.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () async {
                      medicos = await _apiService.getMedicos();
                      pacientes = await _apiService.getPacientes();
                      _mostrarPopUp2(context, consultas[index]);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Id do médico: ${consultas[index].medicoId}"),
                            Text(
                                "Id do paciente: ${consultas[index].pacienteId}"),
                            Text(
                                "Data da consulta: ${consultas[index].dataEHora}"),
                            Text(
                                "Observações: ${consultas[index].observacoes}"),
                            Text(
                                "Tipo da consulta: ${consultas[index].tipoConsulta}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                bloc.add(RemoveConsultaEvent(
                                  consultaID: consultas[index].id,
                                  consultas: consultas,
                                ));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        )
      ],
    );
  }

  late List<Consulta> consultas = [];
  late final ConsultaBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ConsultaBloc();
    bloc.add(LoadConsultaEvent());
  }

  void _mostrarPopUp2(BuildContext context, Consulta consulta) {
    final observacoesController = TextEditingController();
    final idController = TextEditingController();
    final dataEHoraController = TextEditingController();
    DateTime selectedDate = consulta.dataEHora;
    String? selectedOption1;
    int selectedMedicId = consulta.medicoId;
    int selectedPacientId = consulta.pacienteId;

    dataEHoraController.text = consulta.dataEHora.toString();
    observacoesController.text = consulta.observacoes;
    idController.text = consulta.id.toString();

    Widget _buildTextField(String label, {TextEditingController? controller}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            TextFormField(
              enabled:
                  label == "ID:" || label == "Data da consulta:" ? false : true,
              controller: controller,
            ),
          ],
        ),
      );
    }

    Future<void> _selectDateTime(BuildContext context) async {
      final DateTime? pickedDateTime = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (pickedDateTime != null) {
        // ignore: use_build_context_synchronously
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(selectedDate),
        );

        if (pickedTime != null) {
          setState(() {
            selectedDate = DateTime(
              pickedDateTime.year,
              pickedDateTime.month,
              pickedDateTime.day,
              pickedTime.hour,
              pickedTime.minute,
            );

            dataEHoraController.text = selectedDate.toString().substring(0, 16);
          });
        }
      }
    }

    selectedOption1 = consulta.tipoConsulta;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return AlertDialog(
            title: const Text("Editar consulta"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField("ID:", controller: idController),
                DropdownButton<int>(
                  isExpanded: true,
                  value: selectedMedicId,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedMedicId = newValue ?? 0;
                    });
                  },
                  items: medicos.map<DropdownMenuItem<int>>((Medico doctor) {
                    return DropdownMenuItem<int>(
                      value: doctor.id,
                      child: Text(doctor.name),
                    );
                  }).toList(),
                ),
                DropdownButton<int>(
                  isExpanded: true,
                  value: selectedPacientId,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedPacientId = newValue ?? 0;
                    });
                  },
                  items:
                      pacientes.map<DropdownMenuItem<int>>((Paciente patient) {
                    return DropdownMenuItem<int>(
                      value: patient.id,
                      child: Text(patient.name),
                    );
                  }).toList(),
                ),
                _buildTextField("Observações:",
                    controller: observacoesController),
                const Text("Tipo de consulta:"),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedOption1,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedOption1 = newValue;
                    });
                  },
                  items: <String>[
                    'presencial',
                    'online',
                  ].map<DropdownMenuItem<String>>((String value1) {
                    return DropdownMenuItem<String>(
                      value: value1,
                      child: Text(value1),
                    );
                  }).toList(),
                ),
                InkWell(
                    onTap: () => _selectDateTime(context),
                    child: _buildTextField("Data da consulta:",
                        controller: dataEHoraController)),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Fechar"),
              ),
              TextButton(
                onPressed: () {
                  if (observacoesController.text.isEmpty) {
                    Navigator.of(context).pop();
                    return;
                  }
                  Consulta sendConsulta = Consulta(
                      id: consulta.id,
                      dataEHora: consulta.dataEHora,
                      medicoId: selectedMedicId,
                      pacienteId: selectedPacientId,
                      observacoes: observacoesController.text,
                      tipoConsulta: selectedOption1!);

                  bloc.add(
                    EditConsultaEvent(
                        consulta: sendConsulta, consultas: consultas),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text("Salvar"),
              ),
            ],
          );
        });
      },
    );
  }

  final IHospitalApi _apiService = getIt<IHospitalApi>();
  late List<Paciente> pacientes = [];
  late List<Medico> medicos = [];

  // Função para mostrar a pop-up
  void _mostrarPopUp(BuildContext context) {
    final observacoesController = TextEditingController();
    final dataEHoraController = TextEditingController();
    String? selectedOption = "presencial";
    int? selectedMedicId;
    int? selectedPatientId;
    DateTime selectedDate = DateTime.now();

    // ignore: no_leading_underscores_for_local_identifiers
    Widget _buildTextField(String label, TextEditingController controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            TextFormField(
              controller: controller,
              enabled: label == "Data da consulta:" ? false : true,
            ),
          ],
        ),
      );
    }

    Future<void> _selectDateTime(BuildContext context) async {
      final DateTime? pickedDateTime = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (pickedDateTime != null) {
        // ignore: use_build_context_synchronously
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(selectedDate),
        );

        if (pickedTime != null) {
          setState(() {
            selectedDate = DateTime(
              pickedDateTime.year,
              pickedDateTime.month,
              pickedDateTime.day,
              pickedTime.hour,
              pickedTime.minute,
            );

            dataEHoraController.text = selectedDate.toString().substring(0, 16);
          });
        }
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return AlertDialog(
            title: const Text("Adicionar consulta"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DropdownButton<int>(
                  isExpanded: true,
                  value: selectedMedicId,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedMedicId = newValue ?? 0;
                    });
                  },
                  items: medicos.map<DropdownMenuItem<int>>((Medico doctor) {
                    return DropdownMenuItem<int>(
                      value: doctor.id,
                      child: Text(doctor.name),
                    );
                  }).toList(),
                ),
                DropdownButton<int>(
                  isExpanded: true,
                  value: selectedPatientId,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedPatientId = newValue ?? 0;
                    });
                  },
                  items:
                      pacientes.map<DropdownMenuItem<int>>((Paciente patient) {
                    return DropdownMenuItem<int>(
                      value: patient.id,
                      child: Text(patient.name),
                    );
                  }).toList(),
                ),
                _buildTextField("Observações:", observacoesController),
                const Text("Tipo de consulta:"),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedOption = newValue;
                    });
                  },
                  items: <String>[
                    'presencial',
                    'online',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                InkWell(
                    onTap: () => _selectDateTime(context),
                    child: _buildTextField(
                        "Data da consulta:", dataEHoraController)),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Fechar"),
              ),
              TextButton(
                onPressed: () {
                  try {
                    if (observacoesController.text.isEmpty ||
                        dataEHoraController.text.isEmpty ||
                        selectedMedicId == null ||
                        selectedPatientId == null) {
                      Navigator.of(context).pop();
                      return;
                    }
                    Consulta consulta = Consulta(
                        id: 0,
                        dataEHora: selectedDate,
                        medicoId: selectedMedicId!,
                        pacienteId: selectedPatientId!,
                        observacoes: observacoesController.text,
                        tipoConsulta: selectedOption!);

                    bloc.add(
                      SaveConsultaEvent(
                          consulta: consulta, consultas: consultas),
                    );
                    Navigator.of(context).pop();
                  } catch (error) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Enviar"),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consulta Page"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () async {
              medicos = await _apiService.getMedicos();
              pacientes = await _apiService.getPacientes();
              _mostrarPopUp(context);
            },
          ),
        ],
      ),
      body: _body(),
    );
  }
}
