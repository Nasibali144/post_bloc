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
      List<Map<String, dynamic>> json = jsonDecode(response);
      list = json.map((element) => Post.fromJson(element)).toList();
    }

    return list;
  }
}