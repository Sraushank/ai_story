import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/apiData.dart';

Future<OpenAiData?> postRequest(String data) async {
  final url = Uri.parse('https://chatgpt-42.p.rapidapi.com/conversationgpt4-2');

  final headers = {
    'Content-Type': 'application/json',
    'x-rapidapi-host': 'chatgpt-42.p.rapidapi.com',
    'x-rapidapi-key': 'cc19090772mshac9740f949a8255p146fb3jsne392aba920a5',
  };

  final body = jsonEncode({
    'messages': [
      {
        'role': 'user',
        'content': data,
      }
    ],
    'system_prompt': '',
    'temperature': 0.9,
    'top_k': 5,
    'top_p': 0.9,
    'max_tokens': 256,
    'web_access': false,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      print('Response data: ${response.body}');

      return OpenAiData.fromJson(responseData);
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
