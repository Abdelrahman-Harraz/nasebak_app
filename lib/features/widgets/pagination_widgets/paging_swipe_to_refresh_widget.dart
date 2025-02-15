import 'package:flutter/material.dart';

class SwipeToRefreshWidget extends StatelessWidget {
  final Widget child;
  final Function swipedToRefresh;

  const SwipeToRefreshWidget({
    super.key,
    required this.child,
    required this.swipedToRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _refresh,
        child: Align(
          alignment: Alignment.center,
          child: ListView(
            children: [
              // TODO: fix this
              const SizedBox(height: 250),
              Center(child: child),
            ],
          ),
        ));
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1)).then((_) {});
    swipedToRefresh();
  }
}
