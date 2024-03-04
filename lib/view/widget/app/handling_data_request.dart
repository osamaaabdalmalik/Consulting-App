
import 'package:consultancy/core/constant/app_assets.dart';
import 'package:consultancy/core/constant/app_status_views.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HandlingDataRequest extends StatelessWidget {
  final StatusView statusView;
  final Widget child;

  const HandlingDataRequest(
      {Key? key, required this.statusView, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusView == StatusView.loading
        ? Center(
            child: Lottie.asset(AppAssets.loading, width: 250, height: 250))
        : statusView == StatusView.serverFailure
            ? Center(
                child: Lottie.asset(AppAssets.server, width: 250, height: 250))
            : statusView == StatusView.noContent
                ? Center(
                    child: Lottie.asset(AppAssets.noContent, width: 250, height: 250,),)
                : child;
  }
}
