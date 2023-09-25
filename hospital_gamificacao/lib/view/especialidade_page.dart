import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_gamificacao/bloc/especialidade_page/especialidade_bloc.dart';
import 'package:hospital_gamificacao/bloc/especialidade_page/especialidade_event.dart';
import 'package:hospital_gamificacao/bloc/especialidade_page/especialidade_state.dart';
import 'package:hospital_gamificacao/models/especialidade.dart';
import 'package:hospital_gamificacao/services/service_locator.dart';
import 'package:hospital_gamificacao/view/top_navigation_bar.dart';

import '../services/interfaces/ihospital_api.dart';

class EspecialidadePage extends StatefulWidget {
  const EspecialidadePage({super.key});

  @override
  State<EspecialidadePage> createState() => _EspecialidadePageState();
}

class _EspecialidadePageState extends State<EspecialidadePage> {
  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const TopNavigationBar(selectedIndex: 5),
        const Text("Lista de especialidades:"),
        const SizedBox(height: 10),
        Flexible(
          child: BlocBuilder<EspecialidadeBloc, EspecialidadeState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is EspecialidadeInitialState) {
                return const Text("Initial state");
              }
              if (state is EspecialidadeErrorState) {
                return const Text("error state");
              }
              if (state is EspecialidadeSuccessState) {
                especialidades = state.especialidade;
                return ListView.separated(
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: especialidades.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      _mostrarPopUp2(context, especialidades[index]);
                    },
                    child: Row(
                      children: [
                        Text(especialidades[index].especialidade),
                        const SizedBox(width: 10),
                        Text(especialidades[index].descricao),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  bloc.add(RemoveEspecialidadeEvent(
                                      especialidadeID: especialidades[index].id,
                                      especialidades: especialidades));
                                },
                              ),
                            ],
                          ),
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

  late List<Especialidade> especialidades = [];
  late final EspecialidadeBloc bloc;
  final IHospitalApi _apiService = getIt<IHospitalApi>();

  @override
  void initState() {
    super.initState();
    bloc = EspecialidadeBloc();
    bloc.add(LoadEspecialidadeEvent());
  }

  void _mostrarPopUp2(BuildContext context, Especialidade especialidade) {
    final especialidadeController = TextEditingController();
    final descricaoController = TextEditingController();
    final idController = TextEditingController();

    especialidadeController.text = especialidade.especialidade;
    descricaoController.text = especialidade.descricao;
    idController.text = especialidade.id.toString();

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
          title: const Text("Editar Recepcionista"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField("ID:", controller: idController),
              _buildTextField("Especialidade:",
                  controller: especialidadeController),
              _buildTextField("Descricao:", controller: descricaoController),
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
                if (especialidadeController.text.isEmpty ||
                    descricaoController.text.isEmpty) {
                  Navigator.of(context).pop();
                  return;
                }
                Especialidade sendEspecialidade = Especialidade(
                  id: especialidade.id,
                  especialidade: especialidadeController.text,
                  descricao: descricaoController.text,
                );

                bloc.add(
                  EditEspecialidadeEvent(
                      especialidade: sendEspecialidade,
                      especialidades: especialidades),
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
    final especialidadeController = TextEditingController();
    final descricaoController = TextEditingController();

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
          title: const Text("Adicionar especialidade"),
          content: Column(
            children: [
              _buildTextField("Especialidade:", especialidadeController),
              _buildTextField("Descricao:", descricaoController),
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
                  if (especialidadeController.text.isEmpty ||
                      descricaoController.text.isEmpty) {
                    Navigator.of(context).pop();
                    return;
                  }
                  Especialidade especialidade = Especialidade(
                    id: 0,
                    especialidade: especialidadeController.text,
                    descricao: descricaoController.text,
                  );

                  bloc.add(
                    SaveEspecialidadeEvent(
                        especialidade: especialidade,
                        especialidades: especialidades),
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
        title: const Text("Especialidade Page"),
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
