import 'package:dio/dio.dart';
import 'package:ecosense/data/models/story.dart';
import 'package:ecosense/data/models/story_replies.dart';
import 'package:ecosense/data/models/supporter.dart';
import 'package:ecosense/services/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StoryService {
  static Future<List<StoryModel>> getStories(int page, int size) async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await dio.get(
      '/stories',
      options: Options(
        headers: {
          if (idToken != null) 'Authorization': 'Bearer $idToken',
        },
      ),
      queryParameters: {
        'page': page,
        'size': size,
      },
    );
    // log(json.encode(response.data));
    final stories = (response.data['stories'] as List<dynamic>)
        .cast<Map<String, dynamic>>();
    final storyList = stories.map((json) => StoryModel.fromJson(json)).toList();
    return storyList;
  }

  static Future<bool> postStory({
    int? sharedCampaignId,
    XFile? attachedPhoto,
    required String caption,
  }) async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await dio.post(
      '/poststory',
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer $idToken',
        },
      ),
      data: FormData.fromMap({
        if (sharedCampaignId != null) 'sharedCampaignId': sharedCampaignId,
        if (attachedPhoto != null)
          'attachedPhoto': await MultipartFile.fromFile(attachedPhoto.path),
        'caption': caption,
      }),
    );
    if (!response.data['error']) return true;
    return false;
  }

  static Future<List<StoryReply>> getReplies(int storyId) async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await dio.get(
      '/replies',
      queryParameters: {
        'storyId': storyId,
      },
      options: Options(
        headers: {
          if (idToken != null) 'Authorization': 'Bearer $idToken',
        },
      ),
    );
    final data = response.data['replies'] as List<dynamic>;
    final replies = data.map((json) => StoryReply.fromJson(json)).toList();
    return replies;
  }

  static Future<bool> postReply(
      int storyId, String caption, XFile? photo) async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await dio.post(
      '/postreply',
      options: Options(
        headers: {
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'multipart/form-data',
        },
      ),
      data: FormData.fromMap({
        'storyId': storyId,
        'caption': caption,
        if (photo != null) 'photo': await MultipartFile.fromFile(photo.path),
      }),
    );
    if (!response.data['error']) return true;
    throw ErrorDescription(response.data["message"]);
  }

  static Future<bool> supportStory(int storyId) async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await dio.post('/supportstory',
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
          },
        ),
        data: {
          'storyId': storyId,
        });
    if (!response.data['error']) return true;
    throw ErrorDescription(response.data["message"]);
  }

  static Future<bool> unsupportStory(int storyId) async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await dio.post('/unsupportstory',
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
          },
        ),
        data: {
          'storyId': storyId,
        });
    if (!response.data['error']) return true;
    throw ErrorDescription(response.data["message"]);
  }

  static Future<bool> supportReply(int replyId) async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await dio.post('/supportreply',
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
          },
        ),
        data: {
          'replyId': replyId,
        });
    if (!response.data['error']) return true;
    throw ErrorDescription(response.data["message"]);
  }

  static Future<bool> unsupportReply(int replyId) async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await dio.post('/unsupportreply',
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
          },
        ),
        data: {
          'replyId': replyId,
        });
    if (!response.data['error']) return true;
    throw ErrorDescription(response.data["message"]);
  }

  static Future<List<Supporter>> getSupporters(int storyId) async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await dio.get(
      '/supporters',
      queryParameters: {
        'storyId': storyId,
      },
      options: Options(
        headers: {
          if (idToken != null) 'Authorization': 'Bearer $idToken',
        },
      ),
    );
    final data = response.data['supporters'] as List<dynamic>;
    final supporters = data.map((json) => Supporter.fromJson(json)).toList();
    return supporters;
  }
}
