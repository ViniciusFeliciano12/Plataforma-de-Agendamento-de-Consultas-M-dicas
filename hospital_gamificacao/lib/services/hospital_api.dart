import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:hospital_gamificacao/models/consulta.dart';
import 'package:hospital_gamificacao/models/especialidade.dart';
import 'package:hospital_gamificacao/models/medico.dart';
import 'package:hospital_gamificacao/models/paciente.dart';
import 'package:hospital_gamificacao/services/interfaces/ihospital_api.dart';
import '../models/recepcionista.dart';
import 'package:http/http.dart' as http;

class HospitalAPI extends IHospitalApi {
  String url = "http://localhost:5164";

  //recepcionistas
  @override
  Future<List<Recepcionista>> getRecepcionistas() {
    Completer<List<Recepcionista>> completer = Completer<List<Recepcionista>>();

    http.get(Uri.parse("$url/recepcionistas")).then((response) {
      try {
        if (response.statusCode == 200) {
          final List<dynamic> jsonResponse = jsonDecode(response.body);
          var recepcionistas =
              jsonResponse.map((data) => Recepcionista.fromJson(data)).toList();
          completer.complete(recepcionistas);
        } else {
          completer.completeError(Exception('Failed to load album'));
        }
      } catch (error) {
        completer.completeError(error);
        debugPrint(error.toString());
      }
    }).catchError((error) {
      completer.completeError(error);
      debugPrint(error.toString());
    });

    return completer.future;
  }

  @override
  Future<bool> removeRecepcionista(int id) async {
    Completer<bool> completer = Completer<bool>();

    try {
      final response = await http.delete(Uri.parse('$url/recepcionistas/$id'));
      if (response.statusCode == 200) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    } catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }

  @override
  Future<bool> adicionarRecepcionista(Recepcionista recepcionista) async {
    Completer<bool> completer = Completer<bool>();

    try {
      final response = await http.post(
        Uri.parse("$url/recepcionistas"),
        body: jsonEncode(recepcionista.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    } catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }

  @override
  Future<bool> editarRecepcionista(Recepcionista recepcionista) async {
    Completer<bool> completer = Completer<bool>();

    try {
      final response = await http.put(
        Uri.parse("$url/recepcionistas"),
        body: jsonEncode(recepcionista.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    } catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }

  //especialidades

  @override
  Future<List<Especialidade>> getEspecialidades() {
    Completer<List<Especialidade>> completer = Completer<List<Especialidade>>();

    http.get(Uri.parse("$url/especialidades")).then((response) {
      try {
        if (response.statusCode == 200) {
          final List<dynamic> jsonResponse = jsonDecode(response.body);
          var especialidades =
              jsonResponse.map((data) => Especialidade.fromJson(data)).toList();
          completer.complete(especialidades);
        } else {
          completer.completeError(Exception('Failed to load album'));
        }
      } catch (error) {
        completer.completeError(error);
        debugPrint(error.toString());
      }
    }).catchError((error) {
      completer.completeError(error);
      debugPrint(error.toString());
    });

    return completer.future;
  }

  @override
  Future<bool> removeEspecialidades(int id) async {
    Completer<bool> completer = Completer<bool>();

    try {
      final response = await http.delete(Uri.parse('$url/especialidades/$id'));
      if (response.statusCode == 200) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    } catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }

  @override
  Future<bool> adicionarEspecialidades(Especialidade especialidade) async {
    Completer<bool> completer = Completer<bool>();

    try {
      final response = await http.post(
        Uri.parse("$url/especialidades"),
        body: jsonEncode(especialidade.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    } catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }

  @override
  Future<bool> editarEspecialidades(Especialidade especialidade) async {
    Completer<bool> completer = Completer<bool>();

    try {
      final response = await http.put(
        Uri.parse("$url/especialidades"),
        body: jsonEncode(especialidade.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    } catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }

  //pacientes

  @override
  Future<List<Paciente>> getPacientes() {
    Completer<List<Paciente>> completer = Completer<List<Paciente>>();

    http.get(Uri.parse("$url/pacientes")).then((response) {
      try {
        if (response.statusCode == 200) {
          final List<dynamic> jsonResponse = jsonDecode(response.body);
          var pacientes =
              jsonResponse.map((data) => Paciente.fromJson(data)).toList();
          completer.complete(pacientes);
        } else {
          completer.completeError(Exception('Failed to load album'));
        }
      } catch (error) {
        completer.completeError(error);
        debugPrint(error.toString());
      }
    }).catchError((error) {
      completer.completeError(error);
      debugPrint(error.toString());
    });

    return completer.future;
  }

  @override
  Future<bool> removePaciente(int id) async {
    Completer<bool> completer = Completer<bool>();

    try {
      final response = await http.delete(Uri.parse('$url/pacientes/$id'));
      if (response.statusCode == 200) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    } catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }

  @override
  Future<bool> adicionarPaciente(Paciente paciente) async {
    Completer<bool> completer = Completer<bool>();

    try {
      final response = await http.post(
        Uri.parse("$url/pacientes"),
        body: jsonEncode(paciente.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    } catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }

  @override
  Future<bool> editarPaciente(Paciente paciente) async {
    Completer<bool> completer = Completer<bool>();

    try {
      final response = await http.put(
        Uri.parse("$url/pacientes"),
        body: jsonEncode(paciente.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    } catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }

//médico

  @override
  Future<List<Medico>> getMedicos() {
    Completer<List<Medico>> completer = Completer<List<Medico>>();

    http.get(Uri.parse("$url/medicos")).then((response) {
      try {
        if (response.statusCode == 200) {
          final List<dynamic> jsonResponse = jsonDecode(response.body);
          var medicos =
              jsonResponse.map((data) => Medico.fromJson(data)).toList();
          completer.complete(medicos);
        } else {
          completer.completeError(Exception('Failed to load album'));
        }
      } catch (error) {
        completer.completeError(error);
        debugPrint(error.toString());
      }
    }).catchError((error) {
      completer.completeError(error);
      debugPrint(error.toString());
    });

    return completer.future;
  }

  @override
  Future<bool> removeMedico(int id) async {
    Completer<bool> completer = Completer<bool>();

    try {
      final response = await http.delete(Uri.parse('$url/medicos/$id'));
      if (response.statusCode == 200) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    } catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }

  @override
  Future<bool> adicionarMedico(Medico medico) async {
    Completer<bool> completer = Completer<bool>();

    try {
      final response = await http.post(
        Uri.parse("$url/medicos"),
        body: jsonEncode(medico.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    } catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }

  @override
  Future<bool> editarMedico(Medico medico) async {
    Completer<bool> completer = Completer<bool>();

    try {
      final response = await http.put(
        Uri.parse("$url/medicos"),
        body: jsonEncode(medico.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    } catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }

  //consulta

  @override
  Future<List<Consulta>> getConsultas() {
    Completer<List<Consulta>> completer = Completer<List<Consulta>>();

    http.get(Uri.parse("$url/consultas")).then((response) {
      try {
        if (response.statusCode == 200) {
          final List<dynamic> jsonResponse = jsonDecode(response.body);
          var consultas =
              jsonResponse.map((data) => Consulta.fromJson(data)).toList();
          completer.complete(consultas);
        } else {
          completer.completeError(Exception('Failed to load album'));
        }
      } catch (error) {
        completer.completeError(error);
        debugPrint(error.toString());
      }
    }).catchError((error) {
      completer.completeError(error);
      debugPrint(error.toString());
    });

    return completer.future;
  }

  @override
  Future<bool> removeConsulta(int id) async {
    Completer<bool> completer = Completer<bool>();

    try {
      final response = await http.delete(Uri.parse('$url/consultas/$id'));
      if (response.statusCode == 200) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    } catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }

  @override
  Future<bool> adicionarConsulta(Consulta consulta) async {
    Completer<bool> completer = Completer<bool>();

    try {
      final response = await http.post(
        Uri.parse("$url/consultas"),
        body: jsonEncode(consulta.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    } catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }

  @override
  Future<bool> editarConsulta(Consulta consulta) async {
    Completer<bool> completer = Completer<bool>();

    try {
      final response = await http.put(
        Uri.parse("$url/consultas"),
        body: jsonEncode(consulta.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    } catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }
}
