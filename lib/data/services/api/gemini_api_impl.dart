import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:playground/domain/contracts/api/gemini_api.dart';

@LazySingleton(as: GeminiApi)
class GeminiApiImpl implements GeminiApi {
  final GenerativeModel model;

  GeminiApiImpl(this.model);

  @override
  Stream<GenerateContentResponse> generateContent(
    List<Content> content,
  ) {
    try {
      return model.generateContentStream(content);
    } catch (e) {
      rethrow;
    }
  }
}
