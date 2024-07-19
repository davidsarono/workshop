import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playground/domain/entities/user.dart';
import 'package:playground/domain/repositories/gemini_repository.dart';
import 'package:playground/domain/repositories/user_repository.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required UserRepository userRepository,
    required GeminiRepository geminiRepository,
  }) : _userRepository = userRepository,
  _geminiRepository = geminiRepository, super(const HomeState()) {
    on<UsersRequested>(_onUsersRequested);
    on<GeneratePoem>(_onGeneratePoem);
    on<ResetPoem>(_onResetPoem);
  }

  final UserRepository _userRepository;
  final GeminiRepository _geminiRepository;

  Future<void> _onUsersRequested(
    UsersRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final users = await _userRepository.getUsers();
      emit(state.copyWith(status: HomeStatus.success, users: users));
    } catch (error) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> _onGeneratePoem(
    GeneratePoem event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final poem = await _geminiRepository.generateContent(file: event.image);
      emit(state.copyWith(status: HomeStatus.success, poem: poem));
    } catch (error) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> _onResetPoem(
    ResetPoem event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    await Future.delayed(const Duration(seconds: 1), () {
      emit(state.copyWith(status: HomeStatus.success, poem: null));
    });
  }
}
