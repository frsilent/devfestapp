import 'dart:collection';

import 'package:devfest_florida_app/main.dart';

class Speaker {
  int id;
  String speakerId;
  String bio;
  String company;
  String name;
  String lastName;
  String jobTitle;
  String thumbnailUrl = "";
  String photoUrl = "";
  bool featured;

  LinkedHashMap<String, String> socialMap = new LinkedHashMap<String, String>();

  Speaker.loadFromFireBase(LinkedHashMap map) {
    for (String key in map.keys) {
      switch (key) {
        case 'id':
          this.speakerId = map[key].toString();
          break;
        case 'bio':
          this.bio = map[key];
          break;
        case 'company':
          this.company = map[key];
          break;
        case 'name':
          this.name = map[key];
          if (this.name != null && this.name != "" && this.name.contains(" ")) {
            this.lastName = this.name.substring(this.name.lastIndexOf(" "));
          }
          break;
        case 'lastname':
          this.lastName = map[key];
          break;
        case 'thumbnailUrl':
          this.thumbnailUrl = map[key];
          break;
        case 'photoUrl':
          this.photoUrl = map[key];
          if (!this.photoUrl.startsWith("https://")
              || !this.photoUrl.startsWith("http://")) {
            this.photoUrl = baseUrl + this.photoUrl;
          }
          this.thumbnailUrl = this.photoUrl;
          break;
        case 'jobTitle':
          this.jobTitle = map[key];
          break;
        case 'featured':
          this.featured = map[key];
          break;
        case 'social': {
            if (map[key] is HashMap) {
              this.socialMap = map[key];
            }
          }
          break;
        case 'socials':
          {
            if (map[key] is List) {
              if (map[key].length > 0) {
                map[key].forEach((listItem) {
                  if (listItem != null && listItem is HashMap) {
                    if (listItem.containsKey("icon") && listItem.containsKey("link")) {
                      this.socialMap.putIfAbsent(
                          listItem["icon"], () => listItem["link"]);
                    }
                  }
                });
              }
            }
          }
          break;
        default:
          break;
      }
    }
  }
}

class Social {
  String platform;
  String url;
  Social (this.platform, this.url);
}