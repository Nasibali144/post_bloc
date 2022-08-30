part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final bool isLoading;
  final List<Post> items;

  @override
  List<Object> get props => [items, isLoading];

  const HomeState(this.items, this.isLoading);
}

class HomeInitialState extends HomeState {
  @override
  List<Object> get props => [];
  const HomeInitialState(super.items, super.isLoading);
}

class HomeErrorState extends HomeState {
  @override
  List<Object> get props => [];
  const HomeErrorState(super.items, super.isLoading);
}

class HomePostGetState extends HomeState {
  @override
  List<Object> get props => [];
  const HomePostGetState(super.items, super.isLoading);
}

class HomeDeleteSuccessState extends HomeState {
  @override
  List<Object> get props => [];
  const HomeDeleteSuccessState(super.items, super.isLoading);
}
