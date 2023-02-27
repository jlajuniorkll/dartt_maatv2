import 'dart:typed_data';
import 'package:dartt_maat_v2/results/uploadfiles_result.dart';
import 'package:firebase_storage/firebase_storage.dart';

class OcurrencyRepository {
  final storageRef = FirebaseStorage.instance;

  Future<UploadFilesResult<UploadTask>> setFileFirebase(
      {required Uint8List fileBytes, required String fileName}) async {
    try {
      UploadTask uploadTask =
          storageRef.ref().child("files/$fileName").putData(fileBytes);
return UploadFilesResult.success(uploadTask);

    } catch (e) {
      return UploadFilesResult.error(
          'Erro ao fazer o upload do arquivo no servidor!');
    }
  }

  Future<bool> removeFileFirebase(String fileName) async {
    try {
      final res = storageRef.ref().child("files/$fileName");
      await res.delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
