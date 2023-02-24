import 'dart:convert';
import 'package:dartt_maat_v2/config/const.dart';
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

  List<FornecedorModel> listFornecedor = [];
  OcurrencyModel ocurrency = OcurrencyModel();
  ClienteModel cliente = ClienteModel();

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
  final List<GlobalKey<FormState>> formKeyFornecedor =
      List.generate(10, (i) => GlobalKey<FormState>());
  List<TextEditingController> cnpjController =
      List.generate(10, (i) => TextEditingController());
  List<TextEditingController> fantasiaController =
      List.generate(10, (i) => TextEditingController());
  List<TextEditingController> fornecedorController =
      List.generate(10, (i) => TextEditingController());

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

  void setAddListFornecedor() {
    if (listFornecedor.length >= 9) {
      Get.snackbar('Erro!', "O limite máximo são 10 CNPJ!",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundGradient: linearBlue,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.only(bottom: 8));
    } else {
      listFornecedor.add(FornecedorModel());
    }
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

  void setEnderecoCEP(Map<String, dynamic> endereco) {
    logradouroController.text = endereco['logradouro'] as String;
    bairroController.text = endereco['bairro'] as String;
    cidadeController.text = endereco['localidade'] as String;
    estadoController.text = endereco['uf'] as String;
    update();
  }

  void setEnderecoCNPJ(Map<String, dynamic> cnpj, int index) {
    fornecedorController[index].text = cnpj['razao_social'] != null
        ? cnpj['razao_social'] as String
        : "CNPJ Não econtrado";
    cnpj['estabelecimento']['nome_fantasia'] != null
        ? fantasiaController[index].text =
            cnpj['estabelecimento']['nome_fantasia'] as String
        : fantasiaController[index].text = "Não possui fantasia";
    listFornecedor[index].cnpj = cnpjController[index].text;
    listFornecedor[index].fantasia = fantasiaController[index].text;
    listFornecedor[index].razaoSocial = fornecedorController[index].text;
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
}
