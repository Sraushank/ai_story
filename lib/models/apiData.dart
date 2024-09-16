class OpenAiData {
  String result;
  bool status;
  String prompt;
  int serverCode;

  OpenAiData({
    required this.result,
    required this.status,
    required this.prompt,
    required this.serverCode,
  });

  factory OpenAiData.fromJson(Map<String, dynamic> json) {
    return OpenAiData(
      result: json["result"],
      status: json["status"],
      prompt: json["prompt"] ?? "",
      serverCode: json["server_code"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "result": result,
      "status": status,
      "prompt": prompt,
      "server_code": serverCode,
    };
  }
}
