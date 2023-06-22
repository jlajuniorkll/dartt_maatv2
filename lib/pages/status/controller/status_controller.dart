import 'package:dartt_maat_v2/models/status_model.dart';
import 'package:dartt_maat_v2/pages/status/repository/status_repository.dart';
import 'package:dartt_maat_v2/results/generics_result.dart';
import 'package:dartt_maat_v2/services/loading_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusController extends GetxController {
  final statusRepository = StatusRepository();

  @override
  void onInit() {
    super.onInit();
    getAllStatus();
  }

  String _searchStatus = '';
  bool isLoading = false;
  List<StatusModel> allStatus = [];
  StatusModel status = StatusModel();
  bool reorder = false;
//  StatusModel? statusSelected;

  //void setStatusSelected(StatusModel statusSelec) {
  //  statusSelected = statusSelec;
  //  update();
  // }

  void setReoder(bool value) {
    reorder = value;
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

  String get searchStatus => _searchStatus;

  set searchStatus(String value) {
    _searchStatus = value;
    update();
  }

  Future<void> getAllStatus({bool? injection}) async {
    if (injection == false) setLoading(true);
    GenericsResult<StatusModel> statusResult =
        await statusRepository.getAllStatus();
    setLoading(false);

    statusResult.when(success: (data) {
      allStatus.assignAll(data);
    }, error: (message) {
      Get.snackbar(
        "Tente novamente",
        "Erro ao buscar lista de status",
        backgroundColor: Colors.grey,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.indigo,
        borderRadius: 0,
        borderWidth: 2,
        barBlur: 0,
      );
    });
  }

  Future<void> addStatus() async {
    setLoading(true);
    status.priority = allStatus.length + 1;
    await statusRepository.addStatus(status: status);
    getAllStatus();
    setLoading(false);
  }

  Future<void> deleteStatus(String id) async {
    setLoading(true);
    await statusRepository.deleteStatus(statusId: id);
    getAllStatus();
    setLoading(false);
  }

  Future<void> updateStatus() async {
    setLoading(true);
    await statusRepository.updateStatus(status: status);
    setLoading(false);
    getAllStatus();
  }

  void reorderStatus(int oldIndex, int newIndex) {
    if (searchStatus.isEmpty) {
      setReoder(true);
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = allStatus.removeAt(oldIndex);
      allStatus.insert(newIndex, item);
    } else {
      Get.snackbar('Ops!', 'Você não pode reordenar um item enquanto pesquisa!',
          backgroundColor: Colors.red);
    }
  }

  Future<void> confirmReorder() async {
    setLoading(true);
    for (var i = 0; i < allStatus.length; i++) {
      await statusRepository.reorderUpdate(
          status: allStatus[i], newPriority: i);
    }
    setLoading(false);
    setReoder(false);
  }

  List<StatusModel> get filteredStatus {
    final List<StatusModel> filteredStatus = [];
    if (searchStatus.isEmpty) {
      filteredStatus.addAll(allStatus);
    } else {
      filteredStatus.addAll(allStatus.where((element) =>
          element.name!.toLowerCase().contains(searchStatus.toLowerCase())));
    }
    return filteredStatus;
  }

  List<StatusModel> get filteredStatusActive {
    final List<StatusModel> filteredStatusActive = [];
    filteredStatusActive
        .addAll(allStatus.where((element) => element.isActive != false));
    return filteredStatusActive;
  }

  void setIsActive(StatusModel value) {
    status = value;
    status.isActive = !value.isActive;
    updateStatus();
    update();
  }

  List<StatusModel> get selectStatus {
    final List<StatusModel> selectionStatus = [];
    selectionStatus.addAll(allStatus.map((e) => e).toList());
    return selectionStatus;
  }
}
