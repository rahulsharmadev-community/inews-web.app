// Copyright (c) 2022 The Project Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html' as html;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart';

Future<String?> gameranxHandler(String url) async {
  try {
    // path : 'https://gameranx.com/updates/id/307454/article/why-dean-narrates-the-winchesters-and-not-sam/'
    http.Response response = await http.get(Uri.parse(url));
    var n = Document.html(response.body)
      ..getElementsByClassName('site-header')[0].remove()
      ..getElementsByClassName('site-footer')[0].remove()
      ..getElementsByClassName('entry-custom-content')[0].remove()
      ..getElementsByClassName('entry-meta entry-meta-after-content')[0]
          .remove()
      ..getElementsByClassName('mai-ad').forEach((element) => element.remove())
      ..getElementsByClassName('sidebar sidebar-primary widget-area')[0]
          .remove();
    return n.outerHtml;
  } on HttpException catch (e) {
    return null;
  }
}

Future<String?> abpliveHandler(String path) async {
  try {
    // path : 'https://news.abplive.com/gaming/wordle-342-answer-today-may-27-wordle-solution-puzzle-hints-1533958'
    http.Response response = await http.get(Uri.parse(path));
    var n = Document.html(response.body)
      ..getElementsByClassName(
              'header header_shadow uk-position-relative header-line')[0]
          .remove()
      ..getElementsByClassName('uk-position-relative uk-box-shadow-small')[0]
          .remove()
      ..getElementsByClassName('uk-container content track_score_card_click')[0]
          .remove()
      ..getElementById('taboola-below-article-thumbnails')!.remove()
      ..getElementsByClassName('_sticky_bottom_class ')[0].remove()
      ..getElementsByClassName('new_section').forEach((e) => e.remove())
      ..getElementsByClassName('ad-slot').forEach((e) => e.remove())
      ..getElementsByClassName('uk-flex _gAeIcon')[0].remove()
      ..getElementsByClassName('twitter-tweet twitter-tweet-rendered')
          .forEach((e) => e.remove())
      ..getElementsByClassName('uk-container uk-text-normal uk-margin-top')[0]
          .remove()
      ..getElementsByClassName('W_HOM_POS_1')[0].remove()
      ..getElementsByClassName('trc_popover_aug_container')
          .forEach((e) => e.remove());
    return n.outerHtml;
  } on HttpException catch (e) {
    return null;
  }
}
