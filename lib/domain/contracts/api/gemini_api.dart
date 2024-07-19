import 'package:google_generative_ai/google_generative_ai.dart';

abstract class GeminiApi {
  Future<GenerateContentResponse> generateContent(
    List<Content> content,
  );
}
