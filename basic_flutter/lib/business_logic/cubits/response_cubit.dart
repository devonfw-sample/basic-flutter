import 'dart:async';

import 'package:basic_flutter/business_logic/cubits/response_state.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

class InternetCubit extends Cubit<ResponseState> {
  InternetCubit() : super(DataLoading());
}