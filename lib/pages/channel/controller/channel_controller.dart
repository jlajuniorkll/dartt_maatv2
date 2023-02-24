import 'package:dartt_maat_v2/models/channel_model.dart';
import 'package:dartt_maat_v2/pages/channel/repository/channel_repository.dart';
import 'package:dartt_maat_v2/results/generics_result.dart';
import 'package:dartt_maat_v2/services/loading_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChannelController extends GetxController {
  final channelRepository = ChannelRepository();

  @override
  void onInit() {
    super.onInit();
    getAllChannels();
  }

  String _searchChannel = '';
  bool isLoading = false;
  List<ChannelModel> allChannels = [];
  ChannelModel channel = ChannelModel();
  ChannelModel? channnelSelected;


  void setChannelSelected(ChannelModel channelSelec){
    channnelSelected = channelSelec;
    update();
  }

  void setLoading(bool value) {
    isLoading = value;
    if(isLoading){
      LoadingServices.showLoading();
    }else{
      LoadingServices.hideLoading();
    }
    update();
  }


  String get searchChannel => _searchChannel;

  set searchChannel(String value) {
    _searchChannel = value;
    update();
  }

    List<ChannelModel> get selectChannel {
    final List<ChannelModel> selectionChannel = [];
    selectionChannel.addAll(allChannels.map((e) => e).toList());
    return selectionChannel;
  }

  Future<void> getAllChannels({bool? injection}) async {
    if(injection == false) setLoading(true);
    GenericsResult<ChannelModel> channelResult =
        await channelRepository.getAllChannels();
    setLoading(false);

    channelResult.when(success: (data) {
      allChannels.assignAll(data);
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

  Future<void> addChannel() async{
    setLoading(true);
      await channelRepository.addChannel(channel: channel);
      getAllChannels();
      setLoading(false);
  }

  Future<void> deleteChannel(String id) async{
    setLoading(true);
    await channelRepository.deleteChannel(channelId: id);
    getAllChannels();
    setLoading(false);
  }

  Future<void> updateChannel() async{
    setLoading(true);
    await channelRepository.updateChannel(channel: channel);
    getAllChannels();
    setLoading(false);
  }

    List<ChannelModel> get filteredChannel {
    final List<ChannelModel> filteredChannel = [];
    if (searchChannel.isEmpty) {
      filteredChannel.addAll(allChannels);
    } else {
      filteredChannel.addAll(allChannels.where((element) =>
          element.name!.toLowerCase().contains(searchChannel.toLowerCase())));
    }
    return filteredChannel;
  }
}
