import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:chat_app/utils/theme.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      child: Loading(
        indicator: BallScaleIndicator(),
        size: 25.0,
        color: AppTheme.appBarColor,
      ),
    );
  }
}
