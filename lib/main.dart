// Copyright (c) 2022 The Project Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'logics.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  mpr(Widget child) => MaterialPageRoute(builder: (context) => child);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News webapp',
      color: Colors.white,
      onGenerateRoute: (route) {
        var path = route.name!.substring(1);
        if (path.isEmpty) {
          return mpr(
              const Scaffold(body: Center(child: Text('Inital Route!'))));
        } else {
          var domain = (path).replaceAll('https://', '').split('/').first;
          switch (domain) {
            case 'gameranx.com':
              return mpr(DisplayHtml(operation: gameranxHandler, url: path));
            case 'news.abplive.com':
              return mpr(DisplayHtml(operation: abpliveHandler, url: path));
            default:
              return mpr(
                  const Scaffold(body: Center(child: Text('No Route!'))));
          }
        }
      },
    );
  }
}

class DisplayHtml extends StatelessWidget {
  final Future<String?> Function(String path) operation;
  final String url;
  const DisplayHtml({Key? key, required this.operation, required this.url})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder<String?>(
            future: operation(url),
            builder: (context, snapshot) {
              switch (snapshot.hasData) {
                case true:
                  if (snapshot.data != null) {
                    ui.platformViewRegistry.registerViewFactory(
                        'test-view-type',
                        (int viewId) => html.IFrameElement()
                          ..style.width = '100%'
                          ..style.height = '100%'
                          ..srcdoc = snapshot.data!
                          ..style.border = 'none');
                    return const HtmlElementView(viewType: 'test-view-type');
                  } else {
                    return const Text('Server Error!');
                  }
                default:
                  return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
