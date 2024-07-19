import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:playground/domain/contracts/api/gemini_api.dart';

const prompt = '''
as an Artist, I want to create a poem based on an image provided by the user, so that I can generate a creative output. Here is the image:
''';

@injectable
class GeminiRepository {
  final GeminiApi _api;

  GeminiRepository(this._api);

  Future<String> generateContent({
    required File file,
  }) async {
    try {
      final bytes = await file.readAsBytes();

      final response = await _api.generateContent([
        Content(
          'user',
          [
            DataPart(
              'image/jpeg',
              bytes,
            ),
            TextPart(prompt),
          ],
        ),
      ]);
      return response.text ?? 'ERROR';
    } catch (e) {
      rethrow;
    }
  }
}
