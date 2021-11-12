import 'package:flutter/cupertino.dart';

enum DataLoadingStates { dataLoading, dataLoaded, loadingFailed }

@immutable
abstract class ResponseState {}

class DataLoading extends ResponseState {}

class DataLoaded extends ResponseState {}

class LoadingFailed extends ResponseState {}


