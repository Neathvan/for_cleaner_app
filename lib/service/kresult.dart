import 'package:clean_app/repository/repository.dart';

class KResult<T> {
  ApiStatus? status = ApiStatus.empty;
  T? data;

  KResult( status, data );
}