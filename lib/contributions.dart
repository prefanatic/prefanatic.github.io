import 'package:flutter/material.dart';

class Contributions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class ContributionChart extends LeafRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderContributionChart();
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderContributionChart renderObject,
  ) {
    super.updateRenderObject(context, renderObject);
  }
}

class RenderContributionChart extends RenderBox {}
