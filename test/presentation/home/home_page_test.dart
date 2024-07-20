import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:playground/domain/repositories/gemini_repository.dart';
import 'package:playground/domain/repositories/user_repository.dart';
import 'package:playground/presentation/pages/home/bloc/home_bloc.dart';
import 'package:playground/presentation/pages/home/home_page.dart';

class MockUserRepository extends Mock implements UserRepository {}
class MockGeminiRepository extends Mock implements GeminiRepository {}

void main() {
  testWidgets('HomePage', (tester) async {
    final userRepository = MockUserRepository();
    final geminiRepository = MockGeminiRepository();

    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        home: BlocProvider(
          create: (context) => HomeBloc(
            userRepository: userRepository,
            geminiRepository: geminiRepository,
          ),
          child: const HomePage(),
        ),
      ),
    );
  });
}