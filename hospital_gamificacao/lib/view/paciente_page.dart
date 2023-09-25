import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_gamificacao/bloc/paciente_page/paciente_bloc.dart';
import 'package:hospital_gamificacao/bloc/paciente_page/paciente_event.dart';
import 'package:hospital_gamificacao/bloc/paciente_page/paciente_state.dart';
import 'package:hospital_gamificacao/models/paciente.dart';
import 'package:hospital_gamificacao/view/top_navigation_bar.dart';

class PacientePage extends StatefulWidget {
  const PacientePage({super.key});

  @override
  State<PacientePage> createState() => _PacientePageState();
}

class _PacientePageState extends State<PacientePage> {
  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const TopNavigationBar(selectedIndex: 4),
        const Text("Lista de pacientes:"),
        const SizedBox(height: 10),
        Flexible(
          child: BlocBuilder<PacienteBloc, PacienteState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is PacienteInitialState) {
                return const Text("Initial state");
              }
              if (state is PacienteErrorState) {
                return const Text("error state");
              }
              if (state is PacienteSuccessState) {
                pacientes = state.paciente;
                return ListView.separated(
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: pacientes.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      _mostrarPopUp2(context, pacientes[index]);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${pacientes[index].name} ${pacientes[index].sobrenome}"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                bloc.add(RemovePacienteEvent(
                                  pacienteID: pacientes[index].id,
                                  pacientes: pacientes,
                                ));
                              },
                            ),
                          ],
                        ),
                        if (pacientes[index].consultasMedicas.isNotEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: pacientes[index].consultasMedicas.length,
                            itemBuilder:
                                (BuildContext context, int consultaIndex) {
                              final consulta = pacientes[index]
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

  late List<Paciente> pacientes = [];
  late final PacienteBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = PacienteBloc();
    bloc.add(LoadPacienteEvent());
  }

  void _mostrarPopUp2(BuildContext context, Paciente paciente) {
    final nomeController = TextEditingController();
    final sobrenomeController = TextEditingController();
    final idController = TextEditingController();

    nomeController.text = paciente.name;
    sobrenomeController.text = paciente.sobrenome;
    idController.text = paciente.id.toString();

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
        return AlertDialog(
          title: const Text("Editar Paciente"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField("ID:", controller: idController),
              _buildTextField("Nome:", controller: nomeController),
              _buildTextField("Sobrenome:", controller: sobrenomeController),
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
                    sobrenomeController.text.isEmpty) {
                  Navigator.of(context).pop();
                  return;
                }
                Paciente sendPaciente = Paciente(
                    id: paciente.id,
                    name: nomeController.text,
                    sobrenome: sobrenomeController.text,
                    consultasMedicas: paciente.consultasMedicas);

                bloc.add(
                  EditPacienteEvent(
                      paciente: sendPaciente, pacientes: pacientes),
                );
                Navigator.of(context).pop();
              },
              child: const Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  // Função para mostrar a pop-up
  void _mostrarPopUp(BuildContext context) {
    final nomeController = TextEditingController();
    final sobrenomeController = TextEditingController();

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
        return AlertDialog(
          title: const Text("Adicionar paciente"),
          content: Column(
            children: [
              _buildTextField("Nome:", nomeController),
              _buildTextField("Sobrenome:", sobrenomeController),
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
                      sobrenomeController.text.isEmpty) {
                    Navigator.of(context).pop();
                    return;
                  }
                  Paciente paciente = Paciente(
                      id: 0,
                      name: nomeController.text,
                      sobrenome: sobrenomeController.text,
                      consultasMedicas: []);

                  bloc.add(
                    SavePacienteEvent(paciente: paciente, pacientes: pacientes),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paciente Page"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              _mostrarPopUp(context);
            },
          ),
        ],
      ),
      body: _body(),
    );
  }
}
