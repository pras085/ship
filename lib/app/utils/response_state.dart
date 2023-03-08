enum ResponseStates {
  LOADING,
  COMPLETE,
  ERROR,
}

// this class help you to call an API and separate it state
class ResponseState<T> {
  ResponseStates state;
  T data;
  String exception;
  ResponseState({
    this.state,
    this.data,
    this.exception,
  });

  static ResponseState<T> loading<T>() {
    return ResponseState(state: ResponseStates.LOADING);
  }

  static ResponseState<T> complete<T>(T data) {
    return ResponseState(state: ResponseStates.COMPLETE, data: data,);
  }

  static ResponseState<T> error<T>(String exception) {
    return ResponseState(state: ResponseStates.ERROR, exception: exception);
  }
}