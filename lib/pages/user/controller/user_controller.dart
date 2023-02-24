import 'package:dartt_maat_v2/config/const.dart';
import 'package:dartt_maat_v2/models/user_model.dart';
import 'package:dartt_maat_v2/page_routes/app_routes.dart';
import 'package:dartt_maat_v2/pages/user/repository/user_repository.dart';
import 'package:dartt_maat_v2/pages/user/result/auth_result.dart';
import 'package:dartt_maat_v2/results/generics_result.dart';
import 'package:dartt_maat_v2/services/loading_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final userRepository = UserRepository();

  @override
  void onInit() {
    super.onInit();
    getAllUser();
  }

  String _searchUser = '';
  bool isLoading = false;
  List<UserModel> allUser = [];
  UserModel usuario = UserModel();
  List<String> tipoUsuario = ['Administrador', 'Operador', 'Cliente'];
  String? tipoUsuarioSelecionado;
  UserModel? usuarioLogado;
  bool sendUser = false;
  UserModel? responsavelSelected;


  void setResponsavelSelected(UserModel value){
    responsavelSelected = value;
    update();
  }

  void setTipoUsuario(String usuario) {
    tipoUsuarioSelecionado = usuario;
    update();
  }

  void setSendUser(bool sendUserSet) {
    sendUser = sendUserSet;
    update();
  }

  void setLoading(bool value) {
    isLoading = value;
    if (isLoading) {
      LoadingServices.showLoading();
    } else {
      LoadingServices.hideLoading();
    }
    update();
  }

  void setUsuarioLogado(UserModel value) {
    usuarioLogado = value;
    update();
  }

  String get searchUser => _searchUser;

  set searchUser(String value) {
    _searchUser = value;
    update();
  }

    List<UserModel> get selectResponsavel {
    final List<UserModel> selectionResponsavel = [];
    selectionResponsavel.addAll(allUser.map((e) => e).toList());
    return selectionResponsavel;
  }

  Future<bool> signIn({required UserModel usuario}) async {
    bool loginSucesso = false;
    setLoading(true);
    AuthResult<UserModel> result =
        await userRepository.signIn(usuario: usuario);
    setLoading(false);
    result.when(success: (data) {
      setUsuarioLogado(data);
      loginSucesso = true;
    }, error: (message) {
      Get.snackbar(
        "Tente novamente",
        "Erro: $message",
        backgroundColor: Colors.grey,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.indigo,
        borderRadius: 0,
        borderWidth: 2,
        barBlur: 0,
      );
    });
    return loginSucesso;
  }

  Future<void> getAllUser({bool? injection}) async {
    if (injection == false) setLoading(true);
    GenericsResult<UserModel> userResult = await userRepository.getAllUser();
    setLoading(false);

    userResult.when(success: (data) {
      allUser.assignAll(data);
    }, error: (message) {
      Get.snackbar(
        "Tente novamente",
        "Erro ao buscar lista de usuários",
        backgroundColor: Colors.grey,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.indigo,
        borderRadius: 0,
        borderWidth: 2,
        barBlur: 0,
      );
    });
  }

  Future<void> addUser({bool signinForm = false}) async {
    setLoading(true);
    usuario.typeUser = tipoUsuarioSelecionado;
    final resultSignup = await userRepository.signUp(usuario: usuario);
    setLoading(false);
    resultSignup.when(
      success: (data) {
        Get.snackbar('Cadastrado',
            'Usuário ${data.name} cadastrado com sucesso!',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.black,
            backgroundGradient: linearGreen,
            duration: const Duration(seconds: 3),
            margin: const EdgeInsets.only(bottom: 8));
        if (signinForm) {
          Get.offNamed(PageRoutes.signin);
        }
      },
      error: (message) {
        Get.snackbar(
          "Tente novamente",
          "Erro ao cadastrar usuário - $message",
          backgroundColor: Colors.grey,
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.indigo,
          borderRadius: 0,
          borderWidth: 2,
          barBlur: 0,
        );
      },
    );
    getAllUser();
  }

  Future<void> deleteUser(String id) async {
    setLoading(true);
    await userRepository.deleteUser(userId: id);
    getAllUser();
    setLoading(false);
  }

  Future<void> updateUser() async {
    setLoading(true);
    if (tipoUsuarioSelecionado != null) {
      usuario.typeUser = tipoUsuarioSelecionado;
    }
    await userRepository.updateUser(user: usuario);
    getAllUser();
    setLoading(false);
  }

  List<UserModel> get filteredUser {
    final List<UserModel> filteredUser = [];
    if (searchUser.isEmpty) {
      filteredUser.addAll(allUser);
    } else {
      filteredUser.addAll(allUser.where((element) =>
          element.name!.toLowerCase().contains(searchUser.toLowerCase())));
    }
    return filteredUser;
  }

    Future<void> resetUser(String email) async {
    await userRepository.resetUser(email: email);
  }
}
