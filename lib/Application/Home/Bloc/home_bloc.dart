import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_bloc/Data/Model/post_model.dart';
import 'package:post_bloc/Domain/post_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  PostRepository postRepository = PostRepository.instance;

  HomeBloc() : super(const HomeInitialState([])) {
    on<HomePostGetEvent>(getPosts);
  }

  Future<void> getPosts(HomePostGetEvent event, Emitter<HomeState> emit) async {
    var result = await postRepository.getAllPost();
    emit(HomePostGetState(result));
  }
}
