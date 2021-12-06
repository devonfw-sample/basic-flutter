import '../../repository/data_provider.dart';

enum DataLoadingStates { dataLoading, dataLoaded, dataChanged, loadingFailed }

class ResponseState {
  DataLoadingStates dataState;
  DataProvider stateDataProvider;

  ResponseState(this.dataState, this.stateDataProvider);
}
