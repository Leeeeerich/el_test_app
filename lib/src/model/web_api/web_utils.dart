


class Result<T> {
  final StatusCode _statusCode;
  final T _result;
  dynamic error;

  Result(this._result, this._statusCode, {this.error});

  bool get isSuccessful => _statusCode == StatusCode.successful;
  StatusCode get statusCode => _statusCode;
  T get result => _result;
}

enum StatusCode { successful, unsuccessfully }
