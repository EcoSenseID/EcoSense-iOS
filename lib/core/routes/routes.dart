import 'package:ecosense/features/pages/campaign/browse_category/browse_category.dart';
import 'package:ecosense/features/pages/eco_world/main/eco_world.dart';
import 'package:ecosense/features/pages/eco_world/new_story/new_story.dart';
import 'package:ecosense/features/pages/home/home.dart';
import 'package:ecosense/features/pages/profile/change_password/change_password.dart';
import 'package:ecosense/features/pages/profile/ecostore/ecostore.dart';
import 'package:ecosense/features/pages/profile/edit_profile/edit_profile.dart';
import 'package:ecosense/features/pages/profile/main/profile.dart';
import 'package:ecosense/features/pages/profile/settings/profile_settings.dart';
import 'package:flutter/material.dart';

import '../../features/pages/auth/login.dart';
import '../../features/pages/auth/register.dart';

class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String profileSettings = '/profile/settings';
  static const String ecoStore = '/profile/ecostore';
  static const String editProfile = '/profile/edit';
  static const String changePassword = 'profile/changePassword';
  static const String ecoWorld = '/ecoworld';
  static const String comments = '/ecoworld/comments';
  static const String newStory = '/ecoworld/new';
  static const String browseCategory = '/campaign/category';
  static const String campaignList = '/campaign/list';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => Home(),
    register: (context) => const RegisterScreen(),
    login: (context) => const LoginScreen(),
    profile: (context) => const ProfileScreen(),
    profileSettings: (context) => const SettingsScreen(),
    ecoStore: (context) => const EcoStoreScreen(),
    editProfile: (context) => const EditProfileScreen(),
    changePassword: (context) => const ChangePasswordScreen(),
    ecoWorld: (context) => const EcoWorldScreen(),
    // comments: (context) => const StoryCommentsScreen(),
    newStory: (context) => const NewStoryScreen(),
    browseCategory: (context) => const BrowseCategoryScreen(),
    // campaignList: (context) => const CampaignListScreen(),
  };
}
