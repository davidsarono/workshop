import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:playground/domain/contracts/api/gemini_api.dart';

const prompt = '''
Generate creative poem based on provided image and only return the content of the poem.
''';

@injectable
class GeminiRepository {
  final GeminiApi _api;

  GeminiRepository(this._api);

  Stream<GenerateContentResponse> generateContent({
    required File file,
  }) {
    try {
      final bytes = file.readAsBytesSync();

      final response = _api.generateContent([
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
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
