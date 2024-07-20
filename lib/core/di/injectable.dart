import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injectable.config.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  getIt.init();
}

@module
abstract class RegisterModule {
  @Named("BaseUrl")
  String get baseUrl => 'https://reqres.in';

  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) => Dio(BaseOptions(baseUrl: url));

  @lazySingleton
  GenerativeModel generativeModel() {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 1.0,
        topK: 64,
        topP: 0.95,
      ),
    );
    return model;
  }
}
