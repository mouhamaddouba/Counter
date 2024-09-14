class ResponseData {
  dynamic data;

  ResponseData({
    this.data,
  });

  ResponseData.fromJson(
    Map<String, dynamic> json,
  ) {
    data = json;
  }

  ResponseData.setData(dynamic json) {
    data = json;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    return data;
  }
}
