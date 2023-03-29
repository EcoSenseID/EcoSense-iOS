import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecosense/services/auth/profile_service.dart';
import 'package:flutter/material.dart';

class Images {
  static Widget userAvatar({double radius = 18}) {
    final imageUrl = ProfileService.getProfilePhotoURL();
    return FutureBuilder<String?>(
      future: imageUrl,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: CachedNetworkImage(
              imageUrl: snapshot.data!,
              width: radius * 2,
              height: radius * 2,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/logo_only.png',
                width: radius * 2,
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return const Icon(Icons.error);
        }
        return Image.asset(
          'assets/images/logo_only.png',
          width: radius * 2,
        );
      }),
    );
    // }), future: imageUrl);
    // return CircleAvatar(
    //   radius: radius,
    //   backgroundImage:
    //       ? CachedNetworkImageProvider(imageUrl ?? ''),
    // );
  }

  static Widget circle(String? url, {double radius = 38}) => url == null
      ? Image.asset(
          'assets/images/logo_only.png',
          width: radius * 2,
        )
      : CircleAvatar(
          radius: radius,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                width: radius * 2,
                height: radius * 2,
                errorWidget: (context, url, error) => Image.asset(
                      'assets/images/logo_only.png',
                      width: radius * 2,
                    )),
          ),
        );
}
