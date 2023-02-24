import 'package:freezed_annotation/freezed_annotation.dart';


part 'generics_result.freezed.dart';

@freezed
class GenericsResult<T> with _$GenericsResult<T>{
  factory GenericsResult.success(List<T> obj) = Success;
  factory GenericsResult.error(String message) = Error;
}