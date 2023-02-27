import 'package:freezed_annotation/freezed_annotation.dart';


part 'uploadfiles_result.freezed.dart';

@freezed
class UploadFilesResult<T> with _$UploadFilesResult<T>{
  factory UploadFilesResult.success(T obj) = Success;
  factory UploadFilesResult.error(String message) = Error;
}