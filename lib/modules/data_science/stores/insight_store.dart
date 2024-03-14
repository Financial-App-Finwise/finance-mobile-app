import 'package:finwise/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'insight_store.g.dart';

class InsightStore = _InsightStoreBase with _$InsightStore;

abstract class _InsightStoreBase with Store {
  @observable
  WebViewController controller = WebViewController();

  @observable
  bool done = false;

  @observable
  int loadingPercentage = 0;

  @action
  void loadWebPage() {
    controller
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          done = false;
          loadingPercentage = 0;
        },
        onProgress: (progress) {
          loadingPercentage = progress;
        },
        onPageFinished: (url) {
          done = true;
          loadingPercentage = 100;
        },
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(
        Uri.parse(
            'https://finwise-data.streamlit.app?token=${ApiService.dio.options.headers['Authorization']}'),
      );
  }

  @action
  void dispose() {}
}
