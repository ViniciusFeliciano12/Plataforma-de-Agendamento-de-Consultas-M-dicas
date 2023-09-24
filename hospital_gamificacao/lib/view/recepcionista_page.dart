import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_gamificacao/bloc/especialidade_page/especialidade_state.dart';
import 'package:hospital_gamificacao/bloc/recepcionistas_page/recepcionista_bloc.dart';
import 'package:hospital_gamificacao/bloc/recepcionistas_page/recepcionista_event.dart';
import 'package:hospital_gamificacao/bloc/recepcionistas_page/recepcionista_state.dart';
import 'package:hospital_gamificacao/models/recepcionista.dart';
import 'package:hospital_gamificacao/view/top_navigation_bar.dart';

class RecepcionistaPage extends StatefulWidget {
  const RecepcionistaPage({super.key});

  @override
  State<RecepcionistaPage> createState() => _RecepcionistaPageState();
}

class _RecepcionistaPageState extends State<RecepcionistaPage> {
  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const TopNavigationBar(selectedIndex: 3),
        const Text("Lista de recepcionistas:"),
        const SizedBox(height: 10),
        Flexible(
          child: BlocBuilder<RecepcionistaBloc, RecepcionistaState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is RecepcionistaInitialState) {
                return const Text("Initial state");
              }
              if (state is RecepcionistaErrorState) {
                return const Text("Error state");
              }
              if (state is RecepcionistaSuccessState) {
                recepcionistas = state.recepcionista;
                return ListView.separated(
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: recepcionistas.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      _mostrarPopUp2(context, recepcionistas[index]);
                    },
                    child: Row(
                      children: [
                        Text(recepcionistas[index].nome),
                        const SizedBox(width: 10),
                        Text(recepcionistas[index].sobrenome),
                        const SizedBox(width: 10),
                        Text(recepcionistas[index].telefone.toString()),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  bloc.add(RemoveRecepcionistaEvent(
                                      recepcionistaID: recepcionistas[index].id,
                                      recepcionistas: recepcionistas));
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
              return const Text("Error state");
            },
          ),
        )
      ],
    );
  }

  late List<Recepcionista> recepcionistas = [];
  late final RecepcionistaBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = RecepcionistaBloc();
    bloc.add(LoadRecepcionistaEvent());
  }

  void _mostrarPopUp2(BuildContext context, Recepcionista recepcionista) {
    final _nomeController = TextEditingController();
    final _sobrenomeController = TextEditingController();
    final _telefoneController = TextEditingController();
    final _idController = TextEditingController();

    _nomeController.text = recepcionista.nome;
    _sobrenomeController.text = recepcionista.sobrenome;
    _telefoneController.text = recepcionista.telefone.toString();
    _idController.text = recepcionista.id.toString();

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
              _buildTextField("ID:", controller: _idController),
              _buildTextField("Nome:", controller: _nomeController),
              _buildTextField("Sobrenome:", controller: _sobrenomeController),
              _buildTextField("Telefone:", controller: _telefoneController),
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
                if (_nomeController.text.isEmpty ||
                    _sobrenomeController.text.isEmpty ||
                    _telefoneController.text.isEmpty) {
                  Navigator.of(context).pop();
                  return;
                }
                Recepcionista sendrecepcionista = Recepcionista(
                  id: recepcionista.id,
                  nome: _nomeController.text,
                  sobrenome: _sobrenomeController.text,
                  telefone: int.parse(_telefoneController.text),
                );

                bloc.add(
                  EditRecepcionistaEvent(
                      recepcionista: sendrecepcionista,
                      recepcionistas: recepcionistas),
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
    final telefoneController = TextEditingController();

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
          title: const Text("Título da Pop-up"),
          content: Column(
            children: [
              _buildTextField("Nome:", nomeController),
              _buildTextField("Sobrenome:", sobrenomeController),
              _buildTextField("Telefone:", telefoneController),
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
                      telefoneController.text.isEmpty ||
                      telefoneController.text.isEmpty) {
                    Navigator.of(context).pop();
                    return;
                  }
                  Recepcionista recepcionista = Recepcionista(
                    id: 0,
                    nome: nomeController.text,
                    sobrenome: sobrenomeController.text,
                    telefone: int.parse(telefoneController.text),
                  );

                  bloc.add(
                    SaveRecepcionistaEvent(
                        recepcionista: recepcionista,
                        recepcionistas: recepcionistas),
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
        title: const Text("Secretaria Page"),
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
