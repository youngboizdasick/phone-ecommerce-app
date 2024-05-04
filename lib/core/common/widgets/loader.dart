import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _getIndicatorWidget(Theme.of(context).platform),
    );
  }

  /// Returns the appropriate "loading indicator" icon for the given `platform`.
  Widget _getIndicatorWidget(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
        return const CupertinoActivityIndicator();
      case TargetPlatform.android:
        return const CircularProgressIndicator();
      default:
        return const CircularProgressIndicator();
    }
  }
}
