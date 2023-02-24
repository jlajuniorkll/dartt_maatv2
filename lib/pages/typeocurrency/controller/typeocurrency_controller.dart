import 'package:dartt_maat_v2/models/typeocurrency_model.dart';
import 'package:dartt_maat_v2/pages/typeocurrency/repository/typeocurrency_repository.dart';
import 'package:dartt_maat_v2/results/generics_result.dart';
import 'package:dartt_maat_v2/services/loading_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TypeOcurrencyController extends GetxController {
  final typeOcurrencyRepository = TypeOcurrencyRepository();

  @override
  void onInit() {
    super.onInit();
    getAllTypeOcurrency();
  }

  String _searchTypeOcurrency = '';
  bool isLoading = false;
  List<TypeOcurrencyModel> allTypeOcurrency = [];
  TypeOcurrencyModel typeOcurrency = TypeOcurrencyModel();
  bool notSuggestion = true;

  void setLoading(bool value) {
    isLoading = value;
    if(isLoading){
      LoadingServices.showLoading();
    }else{
      LoadingServices.hideLoading();
    }
    update();
  }

  String get searchTypeOcurrency => _searchTypeOcurrency;

  set searchTypeOcurrency(String value) {
    _searchTypeOcurrency = value;
    update();
  }

  Future<void> getAllTypeOcurrency({bool? injection}) async {
    if(injection == false) setLoading(true);
    GenericsResult<TypeOcurrencyModel> typeOcurrencyResult =
        await typeOcurrencyRepository.getAllTypeOcurrency();
    setLoading(false);

    typeOcurrencyResult.when(success: (data) {
      allTypeOcurrency.assignAll(data);
    }, error: (message) {
      Get.snackbar(
        "Tente novamente",
        "Erro ao buscar lista de tipos de ocrrência.",
        backgroundColor: Colors.grey,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.indigo,
        borderRadius: 0,
        borderWidth: 2,
        barBlur: 0,
      );
    });
  }

  Future<void> addTypeOcurrency() async{
    setLoading(true);
      await typeOcurrencyRepository.addTypeOcurrency(typeOcurrency: typeOcurrency);
      getAllTypeOcurrency();
      setLoading(false);
  }

  Future<void> deleteTypeOcurrency(String id) async{
    setLoading(true);
    await typeOcurrencyRepository.deleteTypeOcurrency(typeOcurrencyId: id);
    getAllTypeOcurrency();
    setLoading(false);
  }

  Future<void> updateTypeOcurrency() async{
    setLoading(true);
    await typeOcurrencyRepository.updateTypeOcurrency(typeOcurrency: typeOcurrency);
    getAllTypeOcurrency();
    setLoading(false);
  }

    List<TypeOcurrencyModel> get filteredTypeOcurrency {
    final List<TypeOcurrencyModel> filteredTypeOcurrency = [];
    if (searchTypeOcurrency.isEmpty) {
      filteredTypeOcurrency.addAll(allTypeOcurrency);
    } else {
      filteredTypeOcurrency.addAll(allTypeOcurrency.where((element) =>
          element.name!.toLowerCase().contains(searchTypeOcurrency.toLowerCase())));
    }
    return filteredTypeOcurrency;
  }

      void setSuggestion(bool value) {
    notSuggestion = value;
    update();
  }

    Future<List<TypeOcurrencyModel>> getSuggestions(String query) async {
    List<TypeOcurrencyModel> suggestions = [];
    if (query.isEmpty) {
      suggestions.addAll(allTypeOcurrency);
      return suggestions;
    }else{
    suggestions.addAll(allTypeOcurrency.where((element) =>
        element.name!.toLowerCase().contains(query.toLowerCase())));

    return suggestions;
    }
  }
}
