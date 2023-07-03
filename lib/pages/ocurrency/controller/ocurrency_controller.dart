// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartt_maat_v2/models/channel_model.dart';
import 'package:dartt_maat_v2/models/status_model.dart';
import 'package:dartt_maat_v2/models/user_model.dart';
import 'package:dartt_maat_v2/pages/channel/controller/channel_controller.dart';
import 'package:dartt_maat_v2/pages/status/controller/status_controller.dart';
import 'package:dartt_maat_v2/results/generics_result.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
  List<ComentarioModel> commentarios = [];
  OcurrencyModel ocurrency = OcurrencyModel();
  ClienteModel cliente = ClienteModel();
  ProcuradorModel procurador = ProcuradorModel();
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

  void setTypeOcurrency(TypeOcurrencyModel value) {
    ocurrency.typeOcurrencyId = value;
    update();
  }

  void setStatusOcurrency(StatusModel value) {
    ocurrency.status = value;
    update();
  }

  void setChannelOcurrency(ChannelModel value) {
    ocurrency.channel = value;
    update();
  }

  void setUserOcurrency(UserModel value) {
    ocurrency.responsavel = value;
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
    var ano = DateTime.now().year.toString().padLeft(2, "0");
    var hora = DateTime.now().hour.toString().padLeft(2, "0");
    var min = DateTime.now().minute.toString().padLeft(2, "0");
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
    numeroController.text = '';
    cepController.text = '';
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
    var hour = dateNow.hour.toString().padLeft(2, "0");
    var minute = dateNow.minute.toString().padLeft(2, "0");
    var second = dateNow.second.toString().padLeft(2, "0");
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
    if (ocurrency.id != null) {
      ComentarioModel commm = ComentarioModel(
          description: "Reclamação atualizada",
          dataComentario: ocurrency.dataRegistro,
          usuario: ocurrency.user);
      commentarios.add(commm);
      ocurrency.comentarios = commentarios;

      await ocurrencyRepository.updateOcurrency(ocurrency: ocurrency);
    } else {
      cliente.procurador = ProcuradorModel(
          id: procurador.id,
          nome: procurador.nome,
          cpf: procurador.cpf,
          nascimento: procurador.nascimento);

      final userController = Get.find<UserController>();
      ocurrency.user = UserModel(
        id: userController.usuarioLogado!.id,
        name: userController.usuarioLogado!.name,
        cpf: userController.usuarioLogado!.cpf,
        email: userController.usuarioLogado!.email,
        typeUser: userController.usuarioLogado!.typeUser,
      );
      ocurrency.dataOcorrencia = dataOcorrenciaController.text;
      ocurrency.cliente = cliente;
      ocurrency.fornecedores = listFornecedor;
      ocurrency.anexos = listAnexos;
      ComentarioModel commm = ComentarioModel(
          description: "Reclamação aberta",
          dataComentario: ocurrency.dataRegistro,
          usuario: ocurrency.user);
      commentarios.add(commm);
      ocurrency.comentarios = commentarios;

      ocurrency.dataAt = ocurrency.dataRegistro;
      ocurrency.protocolo = await ocurrencyRepository.getProtocolo;
      await ocurrencyRepository.addOcurrency(ocurrency: ocurrency);
    }
    clearAll();
  }

  void setOcurrency(OcurrencyModel ocurrencyUpdate) {
    clearAll();

    ocurrency.id = ocurrencyUpdate.id;
    ocurrency.user = ocurrencyUpdate.user;
    ocurrency.dataRegistro = ocurrencyUpdate.dataRegistro;
    ocurrency.status = ocurrencyUpdate.status;

    var statusController = Get.find<StatusController>();
    ocurrency.status = statusController.selectStatus.elementAt(statusController
        .selectStatus
        .indexWhere((element) => element.id == ocurrency.status!.id));

    var userController = Get.find<UserController>();
    ocurrency.responsavel = userController.selectResponsavel.elementAt(
        userController.selectResponsavel
            .indexWhere((element) => element.id == ocurrencyUpdate.user!.id));

    var channelController = Get.find<ChannelController>();
    ocurrency.channel = channelController.selectChannel.elementAt(
        channelController.selectChannel.indexWhere(
            (element) => element.id == ocurrencyUpdate.channel!.id));

    ocurrency.dataOcorrencia = ocurrencyUpdate.dataOcorrencia;
    dataOcorrenciaController.text = ocurrency.dataOcorrencia!;
    cliente = ocurrencyUpdate.cliente!;
    ocurrency.cliente = cliente;
    dataNascimentoController.text = ocurrencyUpdate.cliente!.nascimento!;

    if (ocurrencyUpdate.cliente!.procurador!.nome != null) {
      dataNascProcuradorController.text =
          ocurrencyUpdate.cliente!.procurador!.nascimento!;
      procurador = ocurrencyUpdate.cliente!.procurador!;
      setWhithProcurador(true);
    }
    numeroController.text = ocurrencyUpdate.cliente!.numero!;
    logradouroController.text = ocurrencyUpdate.cliente!.logradouro!;
    bairroController.text = ocurrencyUpdate.cliente!.bairro!;
    cidadeController.text = ocurrencyUpdate.cliente!.cidade!;
    estadoController.text = ocurrencyUpdate.cliente!.estado!;
    cepController.text = ocurrencyUpdate.cliente!.cep!;

    ocurrency.fornecedores = ocurrencyUpdate.fornecedores;
    listFornecedor.addAll(ocurrency.fornecedores!);
    var typeController = Get.find<TypeOcurrencyController>();
    ocurrency.typeOcurrencyId = typeController.selectTypeOcurrency.elementAt(
        typeController.selectTypeOcurrency.indexWhere(
            (element) => element.id == ocurrencyUpdate.typeOcurrencyId!.id));

    ocurrency.anexos = ocurrencyUpdate.anexos;
    listAnexos.addAll(ocurrency.anexos!);
    ocurrency.comentarios = ocurrencyUpdate.comentarios;

    ocurrency.ocorrencia = ocurrencyUpdate.ocorrencia;
    // TODO: data atualizacao
    ocurrency.protocolo = ocurrencyUpdate.protocolo;
    ocurrency.dataAt = getDataHoraAtual();
  }

  void clearAll({bool? deleteAnexos = false}) {
    if (deleteAnexos == true) {
      if (ocurrency.anexos != null) {
        for (var la in ocurrency.anexos!) {
          removeFileFirebase(la);
        }
        ocurrency.anexos!.clear();
        listAnexos.clear();
      }
    }
    limpaEnderecoCEP();
    dataNascimentoController.text = '';
    OcurrencyModel.reset();
    ocurrency = OcurrencyModel();
    listFornecedor.clear();
    listAnexos.clear();
    ClienteModel.reset();
    cliente = ClienteModel();
    TypeOcurrencyModel.reset();
    ProcuradorModel.reset();
    procurador = ProcuradorModel();
    dataOcorrenciaController.text = '';
    dataNascProcuradorController.text = '';
    setWhithProcurador(false);
    getAllOcurrency();
    update();
  }

  Previsao getPrevisao(String data) {
    var tempoVencido = 30;
    var tempoVencendo = 5;
    List<String> campos = data.split('/');
    int dia = int.parse(campos[0]);
    int mes = int.parse(campos[1]);
    int ano = int.parse(campos[2].substring(0, 4));
    DateTime dataOcorrencia = DateTime(ano, mes, dia);
    DateTime dataPrevisao = dataOcorrencia.add(Duration(days: tempoVencido));
    DateTime dataPrevista =
        dataOcorrencia.add(Duration(days: ((tempoVencido) - tempoVencendo)));
    DateTime dataHoje = DateTime.now();

    if (dataHoje.compareTo(dataPrevisao) < 0) {
      if (dataHoje.compareTo(dataPrevista) < 0) {
        return Previsao.setPrevisao()[0];
      } else {
        return Previsao.setPrevisao()[1];
      }
    } else {
      return Previsao.setPrevisao()[2];
    }
  }

  //void limpaOcurrency() {
  //  limpaEnderecoCEP();
  // }

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
        "Erro ao buscar lista de ocorrência ou não existe nenhuma ocorrência registrada!",
        backgroundColor: Colors.yellow,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.yellow,
        colorText: Colors.black,
        borderRadius: 0,
        borderWidth: 2,
        barBlur: 0,
      );
    });
  }

  Future<Uint8List> fileOcurrencyPDF(OcurrencyModel ocurrency) async {
    setLoading(true);
    final pdf = pw.Document();
    final ByteData bytes1 = await rootBundle.load('images/procon.png');
    final Uint8List img1 = bytes1.buffer.asUint8List();

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Image(pw.MemoryImage(img1), width: 100, height: 100)),
          pw.Divider(),
          pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Text("Reclamação",
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold))),
          pw.Divider(),
          pw.Text('Protocolo: ${ocurrency.protocolo}'),
          pw.Text('Última atualização: ${ocurrency.dataAt}'),
          pw.Text('Data da reclamação: ${ocurrency.dataRegistro}'),
          pw.Text('Canal de atendimento: ${ocurrency.channel!.name}'),
          pw.Text('Solicitante: ${ocurrency.user!.name}'),
          pw.Text('Situação: ${ocurrency.status!.name}'),
          pw.Divider(),
          pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Text("Dados do cliente",
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold))),
          pw.Divider(),
          pw.Text('Nome: ${ocurrency.cliente!.nome}'),
          pw.Text('CPF: ${ocurrency.cliente!.cpf}'),
          pw.Text('Data de nascimento: ${ocurrency.cliente!.nascimento}'),
          pw.Text('Email: ${ocurrency.cliente!.email}'),
          pw.Text('Telefone/whatsapp: ${ocurrency.cliente!.foneWhats}'),
          pw.Text('Telefone: ${ocurrency.cliente!.telefone}'),
          pw.Text('CEP: ${ocurrency.cliente!.cep}'),
          pw.Text('Endereço: ${ocurrency.cliente!.logradouro}'),
          pw.Text('Número: ${ocurrency.cliente!.numero}'),
          pw.Text('Bairro: ${ocurrency.cliente!.bairro}'),
          pw.Divider(),
          pw.Divider(),
          for (var fo in ocurrency.fornecedores!)
            pw.Column(children: [
              pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                      "Dados do Fornecedor ${ocurrency.fornecedores!.indexOf(fo) + 1}",
                      style: pw.TextStyle(
                          fontSize: 14, fontWeight: pw.FontWeight.bold))),
              pw.Text('CNPJ: ${fo.cnpj}'),
              pw.Text('Razão Social: ${fo.razaoSocial}'),
              pw.Text('Nome Fantasia: ${fo.fantasia}'),
              pw.Text('Situacao: ${fo.situacao}'),
              pw.Text('Email: ${fo.email}'),
              pw.Text('Telefone: ${fo.telefone}'),
              pw.Divider(),
            ]),
          pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Text("Detalhes",
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold))),
          pw.Divider(),
          pw.Text('Data da compra/reclamação: ${ocurrency.dataOcorrencia}'),
          pw.Text(
              'Tipo de ocorrência: ${ocurrency.typeOcurrencyId!.name} - ${ocurrency.typeOcurrencyId!.description}'),
          pw.Text('Descrição da reclamação: ${ocurrency.ocorrencia}'),
          pw.Text("Comentários: "),
          if (ocurrency.comentarios != null)
            for (var item in ocurrency.comentarios!) pw.Text(item.description!),
          pw.Column(children: [
            pw.Divider(),
            pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text("Anexo",
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold))),
            pw.Divider(),
            for (var an in ocurrency.anexos!) pw.Text(an.name!),
          ]),
        ];
      },
    ));
    final bytes = await pdf.save();
    setLoading(false);
    return bytes;
  }
}
