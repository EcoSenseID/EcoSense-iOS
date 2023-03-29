import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileService {
  static Future<void> updateProfile({
    required String fullName,
    required String email,
    XFile? photo,
  }) async {
    final user = FirebaseAuth.instance.currentUser!;
    if (photo != null) await uploadProfilePhoto(photo);
    if (user.displayName != fullName) {
      await user.updateDisplayName(fullName);
    }
    if (user.email != email) {
      await user.updateEmail(email);
    }
  }

  static Future<void> uploadProfilePhoto(XFile photo) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final path = 'users/$uid/profile';
    final ref = FirebaseStorage.instance.ref(path);
    final UploadTask task = ref.putFile(File(photo.path));
    await task.whenComplete(() {});
  }

  static Future<void> updatePassword(
      String oldPassword, String newPassword) async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.reauthenticateWithCredential(
      EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      ),
    );
    await user.updatePassword(newPassword);
  }

  static Future<String?> getProfilePhotoURL() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final path = 'users/$uid/profile';
    final ref = FirebaseStorage.instance.ref(path);
    String? url;
    try {
      url = await ref.getDownloadURL();
    } catch (err) {
      url = FirebaseAuth.instance.currentUser!.photoURL;
    }
    return url;
  }
}
