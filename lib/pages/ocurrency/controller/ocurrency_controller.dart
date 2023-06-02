// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:dartt_maat_v2/results/generics_result.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:dartt_maat_v2/config/const.dart';
import 'package:dartt_maat_v2/models/anexo_model.dart';
import 'package:dartt_maat_v2/models/cliente_model.dart';
import 'package:dartt_maat_v2/models/comentario_model.dart';
import 'package:dartt_maat_v2/models/fornecedor_model.dart';
import 'package:dartt_maat_v2/models/ocurrency_model.dart';
import 'package:dartt_maat_v2/models/procurador_model.dart';
import 'package:dartt_maat_v2/models/typeocurrency_model.dart';
import 'package:dartt_maat_v2/pages/ocurrency/repository/ocurrency_repository.dart';
import 'package:dartt_maat_v2/pages/typeocurrency/controller/typeocurrency_controller.dart';
import 'package:dartt_maat_v2/pages/user/controller/user_controller.dart';
import 'package:dartt_maat_v2/services/loading_services.dart';

class OcurrencyController extends GetxController {
  final ocurrencyRepository = OcurrencyRepository();
  final GlobalKey<FormState> formKeyHeader = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyClient = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyAdress = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyProcurador = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyDescription = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyFornecedor = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyDetails = GlobalKey<FormState>();

  List<FornecedorModel> listFornecedor = [];
  List<AnexoModel> listAnexos = [];
  OcurrencyModel ocurrency = OcurrencyModel();
  ClienteModel cliente = ClienteModel();
  ProcuradorModel procurador = ProcuradorModel();
  TypeOcurrencyModel typeOcurrency = TypeOcurrencyModel();
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
  TextEditingController typeOcurrencyController = TextEditingController();

  RxBool notSuggestion = true.obs;
  double progress = 0.0;
  String infoUpload = '';
  bool notValidateAdress = false;

  List<OcurrencyModel> allOcurrency = [];

  @override
  void onInit() {
    super.onInit();
    getAllOcurrency();
  }

  void setNotValidateAdress(bool value) {
    notValidateAdress = value;
    update();
  }

  void setAnexos(AnexoModel value) {
    listAnexos.add(value);
    update();
  }

  void delAnexos(AnexoModel value) {
    listAnexos.remove(value);
    update();
  }

  void setProgress(double value) {
    progress = value;
    update();
  }

  void setInfoUpload(String value) {
    infoUpload = value;
    update();
  }

  void setSuggestion(bool value) {
    notSuggestion.value = value;
    update();
  }

  void setTypeOcurrecyController(String value) {
    typeOcurrencyController.text = value;
    update();
  }

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

  void setTypeOcurrency(String value) {
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
    var dia = DateTime.now().day;
    var mes = DateTime.now().month;
    var ano = DateTime.now().year;
    var hora = DateTime.now().hour;
    var min = DateTime.now().minute;
    return '$dia/$mes/$ano - $hora:$min';
  }

  void setDataFato(DateTime value) {
    var dia = value.day;
    var mes = value.month;
    var ano = value.year;
    String dataFato = '$dia/$mes/$ano';
    dataOcorrenciaController.text = dataFato;
    update();
  }

  void setDataNascimento(DateTime value) {
    var dia = value.day;
    var mes = value.month;
    var ano = value.year;
    String dataNascimento = '$dia/$mes/$ano';
    dataNascimentoController.text = dataNascimento;
    update();
  }

  void setDataNascProcurador(DateTime value) {
    var dia = value.day;
    var mes = value.month;
    var ano = value.year;
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

  void setDataCNPJ({Map<String, dynamic>? cnpj}) {
    if (listFornecedor.length > 10) {
      Get.snackbar('Erro!',
          "Você pode cadastrar somente 10 fornecedores. Caso precise de mais, entre em contato presencialmente!",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundGradient: linearBlue,
          duration: const Duration(seconds: 5),
          margin: const EdgeInsets.only(bottom: 8));
    } else {
      String cnpjNumber = '';
      String fornecedor = '';
      String fantasia = '';
      String email = '';
      String telefone = '';
      String ddd = '';
      String situacao = '';
      if (cnpj != null) {
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
    }
    update();
  }

  void setEnderecoCEP(Map<String, dynamic> endereco) {
    logradouroController.text = endereco['logradouro'] as String;
    bairroController.text = endereco['bairro'] as String;
    cidadeController.text = endereco['localidade'] as String;
    estadoController.text = endereco['uf'] as String;
    setAdressClient();
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
    setAdressClient();
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

  List<TypeOcurrencyModel> getSuggestions(String query) {
    final controllerType = Get.find<TypeOcurrencyController>().allTypeOcurrency;
    return controllerType;
  }

  Future<void> selectFile() async {
    setProgress(0);
    setInfoUpload('');
    List<String> extensions = ['jpg', 'pdf', 'doc', 'png'];

    FilePickerResult? results = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
    );

    if (results != null) {
      for (var result in results.files) {
        String dateTimeNowOrder = _getDateTimeNowOrder();
        PlatformFile file = result;
        Uint8List? fileBytes = file.bytes;
        String fileName = '${dateTimeNowOrder}z_z${file.name}';

        final taskResult = await ocurrencyRepository.setFileFirebase(
            fileBytes: fileBytes!, fileName: fileName);
        taskResult.when(success: (data) {
          data.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
            switch (taskSnapshot.state) {
              case TaskState.running:
                setProgress((100.0 *
                        (taskSnapshot.bytesTransferred /
                            taskSnapshot.totalBytes))
                    .roundToDouble());
                setInfoUpload("Carregando...$progress%.");
                break;
              case TaskState.paused:
                setInfoUpload("Upload está pausado");
                break;
              case TaskState.canceled:
                setInfoUpload("Upload está cancelado");
                break;
              case TaskState.error:
                setInfoUpload("Erro ao realizar o upload");
                break;
              case TaskState.success:
                setInfoUpload("Upload feito com sucesso!");
                break;
            }
          });
          data.whenComplete(() async {
            final url = await data.snapshot.ref.getDownloadURL();
            setAnexos(AnexoModel(name: fileName, url: url));
          });
        }, error: (message) {
          Get.snackbar(
            "Tente novamente",
            message,
            backgroundColor: Colors.grey,
            snackPosition: SnackPosition.BOTTOM,
            borderColor: Colors.indigo,
            borderRadius: 0,
            borderWidth: 2,
            barBlur: 0,
          );
        });
      }
    }
  }

  Future<void> selectCamera() async {
    setProgress(0);
    setInfoUpload('');
    final ImagePicker picker = ImagePicker();
    final XFile? photo =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    String dateTimeNowOrder = _getDateTimeNowOrder();
    String fileName = '${dateTimeNowOrder}z_z${photo!.name}';

    if (fileName != '') {
      setLoading(true);
      final fileBytes = await photo.readAsBytes();
      setLoading(false);
      final taskResult = await ocurrencyRepository.setFileFirebase(
          fileBytes: fileBytes, fileName: fileName);

      taskResult.when(success: (data) {
        data.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
          switch (taskSnapshot.state) {
            case TaskState.running:
              setProgress((100.0 *
                      (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes))
                  .roundToDouble());
              setInfoUpload("Carregando...$progress%.");
              break;
            case TaskState.paused:
              setInfoUpload("Upload está pausado");
              break;
            case TaskState.canceled:
              setInfoUpload("Upload está cancelado");
              break;
            case TaskState.error:
              setInfoUpload("Erro ao realizar o upload");
              break;
            case TaskState.success:
              setInfoUpload("Upload feito com sucesso!");
              break;
          }
        });
        data.whenComplete(() async {
          final url = await data.snapshot.ref.getDownloadURL();
          setAnexos(AnexoModel(name: fileName, url: url));
        });
      }, error: (message) {
        Get.snackbar(
          "Tente novamente",
          message,
          backgroundColor: Colors.grey,
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.indigo,
          borderRadius: 0,
          borderWidth: 2,
          barBlur: 0,
        );
      });
    }
  }

  Future<void> removeFileFirebase(AnexoModel anexo) async {
    setLoading(true);
    final res = await ocurrencyRepository.removeFileFirebase(anexo.name!);
    setLoading(false);
    if (res) {
      delAnexos(anexo);
    } else {
      Get.snackbar(
        "Tente novamente",
        "Erro ao excluir o arquivo!",
        backgroundColor: Colors.grey,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.indigo,
        borderRadius: 0,
        borderWidth: 2,
        barBlur: 0,
      );
    }
  }

  String _getDateTimeNowOrder() {
    final dateNow = DateTime.now();
    int year = dateNow.year;
    int month = dateNow.month;
    int day = dateNow.day;
    int hour = dateNow.hour;
    int minute = dateNow.minute;
    int second = dateNow.second;
    return '$year$month$day$hour$minute$second';
  }

  void setAdressClient() {
    cliente.cep = cepController.text;
    cliente.logradouro = logradouroController.text;
    cliente.numero = numeroController.text;
    cliente.bairro = bairroController.text;
    cliente.cidade = cidadeController.text;
    cliente.estado = estadoController.text;
    update();
  }

  void finalizarReclamacao() async {
    cliente.procurador = ProcuradorModel(
        id: procurador.id,
        nome: procurador.nome,
        cpf: procurador.cpf,
        nascimento: procurador.nascimento);

    final userController = Get.find<UserController>();
    ocurrency.user = userController.usuarioLogado;

    ocurrency.dataOcorrencia = dataOcorrenciaController.text;
    // ocurrency.ocorrencia = ocurrency.ocorrencia;

    ocurrency.cliente = cliente;
    ocurrency.fornecedores = listFornecedor;
    ocurrency.anexos = listAnexos;

    ocurrency.typeOcurrencyId = typeOcurrency;

    // ocurrency.id; // ver
    // ocurrency.dataAt;
    // ocurrency.previsao; // ver
    ComentarioModel comentarios = ComentarioModel(
        description: "Reclamação aberta",
        dataComentario: ocurrency.dataRegistro,
        usuario: ocurrency.user);
    ocurrency.comentarios?.add(comentarios);
    ocurrency.protocolo = await ocurrencyRepository.getProtocolo;
    await ocurrencyRepository.addOcurrency(ocurrency: ocurrency);
  }

  void setOcurrency(OcurrencyModel ocurrencyUpdate) async {
    cliente.procurador = ProcuradorModel(
        id: ocurrencyUpdate.cliente!.procurador!.id,
        nome: ocurrencyUpdate.cliente!.procurador!.nome,
        cpf: ocurrencyUpdate.cliente!.procurador!.cpf,
        nascimento: ocurrencyUpdate.cliente!.procurador!.nascimento);
    ocurrency.user = ocurrencyUpdate.user;
    ocurrency.dataOcorrencia = ocurrencyUpdate.dataOcorrencia;
    // ocurrency.ocorrencia = ocurrency.ocorrencia;

    ocurrency.cliente = ocurrencyUpdate.cliente;
    ocurrency.fornecedores = ocurrencyUpdate.fornecedores;
    ocurrency.anexos = ocurrencyUpdate.anexos;

    ocurrency.typeOcurrencyId = ocurrencyUpdate.typeOcurrencyId;

    // ocurrency.id; // ver
    // ocurrency.dataAt;
    // ocurrency.previsao; // ver
    /*ComentarioModel comentarios = ComentarioModel(
        description: "Reclamação aberta",
        dataComentario: ocurrency.dataRegistro,
        usuario: ocurrency.user);
    ocurrency.comentarios?.add(comentarios);*/
    //ocurrency.protocolo = await ocurrencyRepository.getProtocolo;
    //await ocurrencyRepository.addOcurrency(ocurrency: ocurrency);
    update();
  }

  void limpaOcurrency() {
    limpaEnderecoCEP();
  }

  Future<void> getAllOcurrency({bool? injection}) async {
    if (injection == false) setLoading(true);
    GenericsResult<OcurrencyModel> ocurrencyResult =
        await ocurrencyRepository.getAllOcurrency();
    setLoading(false);

    ocurrencyResult.when(success: (data) {
      allOcurrency.assignAll(data);
    }, error: (message) {
      Get.snackbar(
        "Tente novamente",
        "Erro ao buscar lista de canais",
        backgroundColor: Colors.grey,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.indigo,
        borderRadius: 0,
        borderWidth: 2,
        barBlur: 0,
      );
    });
  }
}
