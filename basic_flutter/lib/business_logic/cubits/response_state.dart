enum DataLoadingStates { dataLoading, dataLoaded, loadingFailed }

class ResponseState {
  DataLoadingStates dataState;

  ResponseState(this.dataState);
}
