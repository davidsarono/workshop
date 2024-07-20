part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

final class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.users = const <User>[],
    this.poem,
  });

  final HomeStatus status;
  final List<User> users;
  final String? poem;

  HomeState copyWith({
    HomeStatus? status,
    List<User>? users,
    String? poem,
  }) {
    return HomeState(
      status: status ?? this.status,
      users: users ?? this.users,
      poem: poem,
    );
  }

  @override
  List<Object?> get props => [
        status,
        users,
        poem,
      ];
}
