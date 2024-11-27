import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/modules/web/web_bloc.dart';
import 'package:base_bloc/modules/web/web_state.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebPage extends StatefulWidget {
  final String? url;

  const WebPage({Key? key, this.url}) : super(key: key);

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends BaseState<WebPage, WebBloc> {
  InAppWebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (await _controller!.canGoBack()) {
            _controller?.goBack();
            return false;
          }
          return true;
        },
        child: AppScaffold(
            padding: EdgeInsets.zero,
            body: Column(children: [
              loadingWidget(),
              Expanded(
                  child: InAppWebView(
                      initialUrlRequest: URLRequest(
                          url: Uri.parse(
                              widget.url ?? 'https://www.google.com/')),
                      onWebViewCreated: (c) async {
                        _controller = c;
                        await c.clearCache();
                      },
                      initialOptions: InAppWebViewGroupOptions(
                          android: AndroidInAppWebViewOptions(
                              useHybridComposition: true),
                          crossPlatform: InAppWebViewOptions(
                              useShouldOverrideUrlLoading: true)),
                      onLoadStart: (c, cc) => bloc.setLoading(true),
                      onLoadStop: (c, cc) => bloc.setLoading(false),
                      onProgressChanged: (c, value) =>
                          bloc.onProgressChange(value),
                      shouldOverrideUrlLoading: (c, n) async {
                        var url = n.request.url.toString();
                        if (url.startsWith("http") || url.startsWith("https")) {
                          return NavigationActionPolicy.ALLOW;
                        } else {
                          return NavigationActionPolicy.CANCEL;
                        }
                      }))
            ])));
  }

  Widget loadingWidget() => BlocBuilder<WebBloc, WebState>(
      builder: (c, state) => LinearProgressIndicator(
          minHeight: 1,
          value: state.value.toDouble() == 100 ? 0 : state.value.toDouble(),
          backgroundColor: colorWhite),
      bloc: bloc);

  @override
  WebBloc createCubit() => WebBloc();

  @override
  void init() {
    // TODO: implement init
  }
}
