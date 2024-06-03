import 'package:fithub_v1/providers/global_config_provider.dart';
import 'package:flutter/material.dart';

class QuestionsViewWidget extends StatelessWidget {
  final String image;
  final Widget child;

  const QuestionsViewWidget({
    super.key,
    required this.image,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: (GlobalConfigProvider.getMaxHeight()! * 0.8),
      width: (GlobalConfigProvider.getMaxWidth()! * 0.8),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

/*
class QuestionsViewWidget extends StatelessWidget {
  final String image;
  final Widget child;

  const QuestionsViewWidget({
    super.key,
    required this.image,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: (GlobalConfigProvider.getMaxHeight()! * 0.8),
      width: (GlobalConfigProvider.getMaxWidth()! * 0.8),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
*/