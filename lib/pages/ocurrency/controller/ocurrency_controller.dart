import 'dart:convert';
import 'package:dartt_maat_v2/models/cliente_model.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dartt_maat_v2/models/fornecedor_model.dart';
import 'package:dartt_maat_v2/models/ocurrency_model.dart';
import 'package:dartt_maat_v2/services/loading_services.dart';
import 'package:flutter/material.dart';

class OcurrencyController extends GetxController {
  final GlobalKey<FormState> formKeyHeader = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyClient = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyAdress = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyProcurador = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyDescription = GlobalKey<FormState>();
  final List<GlobalKey<FormState>> formKeyFornecedor =
      List<GlobalKey<FormState>>.generate(
          12, (index) => GlobalKey(debugLabel: 'key_$index'),
          growable: false);

  List<FornecedorModel> listFornecedor = [];
  OcurrencyModel ocurrency = OcurrencyModel();
  ClienteModel cliente = ClienteModel();
  late FornecedorModel forn;

  bool isLoading = false;
  bool whithProcurador = false;

  TextEditingController dataOcorrenciaController = TextEditingController();
  TextEditingController dataNascimentoController = TextEditingController();
  TextEditingController dataNascProcuradorController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController cnpjController = TextEditingController();

  int typeLocation = 0;

  void setLoading(bool value) {
    isLoading = value;
    if (isLoading) {
      LoadingServices.showLoading();
    } else {
      LoadingServices.hideLoading();
    }
    update();
  }

  void setWhithProcurador(bool value) {
    whithProcurador = value;
    update();
  }

  void setTypeLocation(int value) {
    typeLocation = value;
    update();
  }

  void setremoveListFornecedor(FornecedorModel value) {
    listFornecedor.remove(value);
    update();
  }

  String getDataHoraAtual() {
    var dia = DateTime.now().day.toString();
    var mes = DateTime.now().month.toString();
    var ano = DateTime.now().year.toString();
    var hora = DateTime.now().hour.toString();
    var min = DateTime.now().minute.toString();
    return '$dia/$mes/$ano - $hora:$min';
  }

  void setDataFato(DateTime value) {
    var dia = value.day.toString();
    var mes = value.month.toString();
    var ano = value.year.toString();
    String dataFato = '$dia/$mes/$ano';
    dataOcorrenciaController.text = dataFato;
    update();
  }

  void setDataNascimento(DateTime value) {
    var dia = value.day.toString();
    var mes = value.month.toString();
    var ano = value.year.toString();
    String dataNascimento = '$dia/$mes/$ano';
    dataNascimentoController.text = dataNascimento;
    update();
  }

  void setDataNascProcurador(DateTime value) {
    var dia = value.day.toString();
    var mes = value.month.toString();
    var ano = value.year.toString();
    String dataNascimento = '$dia/$mes/$ano';
    dataNascProcuradorController.text = dataNascimento;
    update();
  }

  Future<Map<String, dynamic>> fecthCep({required String cep}) async {
    try {
      setLoading(true);
      final response =
          await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
      setLoading(false);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final notCNPJ = jsonEncode({"erro": true});
        return json.decode(notCNPJ);
        // throw Exception('Não foi possível buscar o Cep!');
      }
    } catch (e) {
      setLoading(false);
      final notCNPJ = jsonEncode({"erro": true});
      return json.decode(notCNPJ);
    }
  }

  Future<Map<String, dynamic>> fecthCnpj({required String cnpj}) async {
    // https://receitaws.com.br/v1/cnpj/$cnpj
    setLoading(true);
    final response =
        await http.get(Uri.parse('https://publica.cnpj.ws/cnpj/$cnpj'));
    setLoading(false);
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      return res;
    } else {
      final notCNPJ = jsonEncode({"erro": true});
      return json.decode(notCNPJ);
      // throw Exception('Não foi possível buscar o CNPJ!');
    }
  }

  void setDataCNPJ(Map<String, dynamic> cnpj) {
    String cnpjNumber;
    String fornecedor;
    String fantasia;
    String email;
    String telefone;
    String ddd;
    String situacao;
    cnpjNumber = cnpj['estabelecimento']['cnpj'] as String;
    situacao = cnpj['estabelecimento']['situacao_cadastral'] as String;
    if (cnpj['razao_social'] != null) {
      fornecedor = cnpj['razao_social'] as String;
    } else {
      fornecedor = "CNPJ Não econtrado";
    }

    if (cnpj['estabelecimento']['nome_fantasia'] != null) {
      fantasia = cnpj['estabelecimento']['nome_fantasia'] as String;
    } else {
      fantasia = "Não possui fantasia";
    }

    if (cnpj['estabelecimento']['email'] != null) {
      email = cnpj['estabelecimento']['email'] as String;
    } else {
      email = "Não possui email cadastrado";
    }

    if (cnpj['estabelecimento']['telefone1'] != null) {
      telefone = cnpj['estabelecimento']['telefone1'] as String;
      ddd = cnpj['estabelecimento']['ddd1'] as String;
    } else {
      telefone = "Não possui telefone cadastrado";
      ddd = '';
    }

    forn = FornecedorModel(
        cnpj: cnpjNumber,
        fantasia: fantasia,
        razaoSocial: fornecedor,
        email: email,
        telefone: '$ddd$telefone',
        situacao: situacao);

    listFornecedor.add(forn);
    cnpjController.text = '';
    update();
  }

  void setEnderecoCEP(Map<String, dynamic> endereco) {
    logradouroController.text = endereco['logradouro'] as String;
    bairroController.text = endereco['bairro'] as String;
    cidadeController.text = endereco['localidade'] as String;
    estadoController.text = endereco['uf'] as String;
    update();
  }

  void limpaEnderecoCEP() {
    logradouroController.text = '';
    bairroController.text = '';
    cidadeController.text = '';
    estadoController.text = '';
    update();
  }

  void getLocationAuto() async {
    setLoading(true);
    Position pos = await _determinePosition();
    GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: pos.latitude,
        longitude: pos.longitude,
        googleMapApiKey: "AIzaSyAgPEMzB6QxZSTu4ITuqbX6fStR_bLSVL4");
    setLoading(false);
    numeroController.text = data.address.split(',')[1].split('-')[0];
    logradouroController.text = data.address.split(',')[0];
    bairroController.text = data.address.split(',')[1].split('-')[1];
    cidadeController.text = data.city;
    estadoController.text = data.state;
    cepController.text = data.postalCode;
    update();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Os serviços de localização estão desativados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('As permissões de localização foram negadas');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'As permissões de localização são permanentemente negadas, não podemos solicitar permissões.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
