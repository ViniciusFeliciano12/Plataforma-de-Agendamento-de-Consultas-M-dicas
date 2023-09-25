import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_gamificacao/bloc/medicos_page/medico_bloc.dart';
import 'package:hospital_gamificacao/bloc/medicos_page/medico_event.dart';
import 'package:hospital_gamificacao/bloc/medicos_page/medico_state.dart';
import 'package:hospital_gamificacao/models/especialidade.dart';
import 'package:hospital_gamificacao/models/medico.dart';
import 'package:hospital_gamificacao/services/service_locator.dart';
import 'package:hospital_gamificacao/view/top_navigation_bar.dart';

import '../services/interfaces/ihospital_api.dart';

class MedicoPage extends StatefulWidget {
  const MedicoPage({super.key});

  @override
  State<MedicoPage> createState() => _MedicoPageState();
}

class _MedicoPageState extends State<MedicoPage> {
  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const TopNavigationBar(selectedIndex: 2),
        const Text("Lista de medicos:"),
        const SizedBox(height: 10),
        Flexible(
          child: BlocBuilder<MedicoBloc, MedicoState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is MedicoInitialState) {
                return const Text("Initial state");
              }
              if (state is MedicoErrorState) {
                return const Text("error state");
              }
              if (state is MedicoSuccessState) {
                medicos = state.medico;
                return ListView.separated(
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: medicos.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () async {
                      especialidades = await _apiService.getEspecialidades();
                      _mostrarPopUp2(context, medicos[index]);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("nome: ${medicos[index].name}"),
                            Text(
                                "Registro: ${medicos[index].registroProfissional}"),
                            medicos[index].especialidade != null
                                ? Text(
                                    "Especialidade: ${medicos[index].especialidade!.especialidade}")
                                : Container(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                bloc.add(RemoveMedicoEvent(
                                  medicoID: medicos[index].id,
                                  medicos: medicos,
                                ));
                              },
                            ),
                          ],
                        ),
                        if (medicos[index].consultasMedicas.isNotEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: medicos[index].consultasMedicas.length,
                            itemBuilder:
                                (BuildContext context, int consultaIndex) {
                              final consulta = medicos[index]
                                  .consultasMedicas[consultaIndex];
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Consulta: ${consultaIndex + 1}"),
                                      Text(
                                          "Id do paciente: ${consulta.pacienteId}"),
                                      Text(
                                          "Id do médico: ${consulta.medicoId}"),
                                      Text(
                                          "Data da consulta: ${consulta.dataEHora}"),
                                      Text(
                                          "Tipo de consulta: ${consulta.tipoConsulta}"),
                                      Text(
                                          "Observações: ${consulta.observacoes}"),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              );
                            },
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

  late List<Medico> medicos = [];
  late final MedicoBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = MedicoBloc();
    bloc.add(LoadMedicoEvent());
  }

  void _mostrarPopUp2(BuildContext context, Medico medico) {
    final nomeController = TextEditingController();
    final registroController = TextEditingController();
    final idController = TextEditingController();

    selectedEspecialidade = medico.especialidade;
    nomeController.text = medico.name;
    registroController.text = medico.registroProfissional;
    idController.text = medico.id.toString();

    Widget _buildTextField(String label, {TextEditingController? controller}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            TextFormField(
              enabled: label == "ID:" ? false : true,
              controller: controller,
            ),
          ],
        ),
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return AlertDialog(
            title: const Text("Editar médico"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField("ID:", controller: idController),
                _buildTextField("Nome:", controller: nomeController),
                _buildTextField("Registro:", controller: registroController),
                const Text("Selecione especialidade: "),
                Column(
                  children: especialidades.map((especialidade) {
                    return Row(
                      children: <Widget>[
                        Radio<Especialidade>(
                          value: especialidade,
                          toggleable: true,
                          groupValue: selectedEspecialidade,
                          onChanged: (Especialidade? value) {
                            selectedEspecialidade = value;

                            setState(() {});
                          },
                        ),
                        Text(especialidade.especialidade),
                      ],
                    );
                  }).toList(),
                ),
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
                  if (nomeController.text.isEmpty ||
                      registroController.text.isEmpty) {
                    Navigator.of(context).pop();
                    return;
                  }
                  Medico sendMedico = Medico(
                      id: medico.id,
                      name: nomeController.text,
                      registroProfissional: registroController.text,
                      especialidade: selectedEspecialidade,
                      consultasMedicas: medico.consultasMedicas);

                  bloc.add(
                    EditMedicoEvent(medico: sendMedico, medicos: medicos),
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
  late List<Especialidade> especialidades;
  late Especialidade? selectedEspecialidade = null;

  // Função para mostrar a pop-up
  void _mostrarPopUp(BuildContext context) {
    final nomeController = TextEditingController();
    final registroController = TextEditingController();

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
            ),
          ],
        ),
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return AlertDialog(
            title: const Text("Adicionar medico"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField("Nome:", nomeController),
                _buildTextField("Registro:", registroController),
                const Text("Selecione especialidade: "),
                Column(
                  children: especialidades.map((especialidade) {
                    return Row(
                      children: <Widget>[
                        Radio<Especialidade>(
                          value: especialidade,
                          toggleable: true,
                          groupValue: selectedEspecialidade,
                          onChanged: (Especialidade? value) {
                            selectedEspecialidade = value;

                            setState(() {});
                          },
                        ),
                        Text(especialidade.especialidade),
                      ],
                    );
                  }).toList(),
                ),
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
                    if (nomeController.text.isEmpty ||
                        registroController.text.isEmpty ||
                        selectedEspecialidade == null) {
                      Navigator.of(context).pop();
                      return;
                    }
                    Medico sendMedico = Medico(
                        id: 0,
                        name: nomeController.text,
                        registroProfissional: registroController.text,
                        especialidade: selectedEspecialidade,
                        consultasMedicas: []);

                    bloc.add(
                      SaveMedicoEvent(medico: sendMedico, medicos: medicos),
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
        title: const Text("Medico Page"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () async {
              especialidades = await _apiService.getEspecialidades();
              _mostrarPopUp(context);
            },
          ),
        ],
      ),
      body: _body(),
    );
  }
}
