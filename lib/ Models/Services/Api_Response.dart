enum Status { loading, complete, error }

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.message, this.data);

  ApiResponse.loading() : status = Status.loading;
  ApiResponse.complete(this.data) : status = Status.complete;

  ApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return "Status: $status\nMessage: $message\nData: $data";
  }
}
