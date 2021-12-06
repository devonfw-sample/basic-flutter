import '/repository/data_provider.dart';

enum DataLoadingStates { dataLoading, dataLoaded, loadingFailed }

class ResponseState {
  DataLoadingStates dataState;
  DataProvider dataProvider;

  ResponseState(this.dataState, this.dataProvider);
}
