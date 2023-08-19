import 'package:http/http.dart';

abstract class DataState<T> {
  final T? data;
  final ClientException? exception;
  const DataState({this.data, this.exception});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataException<T> extends DataState<T> {
  final ClientException clientException;
  DataException({required this.clientException});
}
