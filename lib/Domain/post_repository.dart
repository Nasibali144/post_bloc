import 'dart:convert';
import 'package:post_bloc/Configuration/api_constants.dart';
import 'package:post_bloc/Data/DataProvider/network_data_provider.dart';
import 'package:post_bloc/Data/Model/post_model.dart';

class PostRepository {
  late NetworkDataProvider networkProvider;

  PostRepository._() {
    networkProvider = NetworkDataProvider.instance;
  }

  static final instance = PostRepository._();

  Future<List<Post>> getAllPost() async {
    List<Post> list = [];
    String? response = await networkProvider.GET(ApiConstants.baseUrl, ApiConstants.apiPost);

    if(response != null) {
      List json = jsonDecode(response);
      list = json.map((element) => Post.fromJson(element)).toList();
    }

    return list;
  }

  Future<bool> deletePost(String id) async {
    String? response = await networkProvider.DELETE(ApiConstants.baseUrl, ApiConstants.apiOnePost + id);
    return response != null;
  }

  Future<bool> createPost(String title, String body, int userId) async {
    Map<String, dynamic> json = {
      "title": title,
      "body": body,
      "userId": userId,
    };

    String? response = await networkProvider.POST(ApiConstants.baseUrl, ApiConstants.apiPost, json);
    return response != null;
  }
}