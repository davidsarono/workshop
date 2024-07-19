part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class UsersRequested extends HomeEvent {
  const UsersRequested();
}

final class GeneratePoem extends HomeEvent {
  final File image;

  const GeneratePoem({
    required this.image,
  });

  @override
  List<Object?> get props => [image];
}

final class ResetPoem extends HomeEvent {
  const ResetPoem();
}