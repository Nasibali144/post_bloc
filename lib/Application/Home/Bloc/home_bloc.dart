import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_bloc/Application/Detail/View/detail_page.dart';
import 'package:post_bloc/Data/Model/post_model.dart';
import 'package:post_bloc/Domain/post_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  PostRepository postRepository = PostRepository.instance;

  HomeBloc() : super(const HomeInitialState([], true)) {
    on<HomePostGetEvent>(_getPosts);
    on<HomePostDeleteEvent>(_deletePost);
    on<HomeCreatePostEvent>(_createPost);
  }

  Future<void> _getPosts(HomePostGetEvent event, Emitter<HomeState> emit) async {
    var result = await postRepository.getAllPost();
    emit(HomePostGetState(result, false));
  }

  Future<void> _deletePost(
      HomePostDeleteEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitialState(state.items, true));

    var result = await postRepository.deletePost(event.id);
    if (result) {
      state.items.removeWhere((element) => element.id == event.id);
      emit(HomeDeleteSuccessState(state.items, false));
    } else {
      emit(HomeErrorState(state.items, false));
    }
  }

  Future<void> _createPost(HomeCreatePostEvent event, Emitter<HomeState> emit) async {
    var result = await Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (context) => const DetailPage(),
      ),
    );

    if(result != null) {
      emit(HomeInitialState(state.items, true));
      var result = await postRepository.getAllPost();
      emit(HomePostGetState(result, false));
    }
  }
}
