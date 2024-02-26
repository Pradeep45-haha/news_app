import 'package:flutter/material.dart';
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

// abstract class DataSuccesOrFaliure<T> {
//   final T newData;
//   void operateOnData() {}
//   const DataSuccesOrFaliure({required this.newData});
// }

// class DataS<T> implements DataSuccesOrFaliure<T> {
//   final T dataSuccess = {} as T;
//   @override
//   T get newData => dataSuccess;

//   @override
//   void operateOnData() {
//     debugPrint(dataSuccess.toString());
//   }
// }
