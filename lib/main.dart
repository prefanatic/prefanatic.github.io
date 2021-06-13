import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cody Goldberg',
      theme: ThemeData(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Stack(
        children: [
          ListView(
            children: [
              HeaderTitle(),
              const SizedBox(height: 72),
              BlurbContent(),
              ContributionOverview(),
            ],
          ),
          BlendMask(
            child: FractionallySizedBox(
              alignment: Alignment.centerRight,
              widthFactor: 0.45,
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContributionOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplitPanel(
      left: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          'Contributions',
          textAlign: TextAlign.end,
          style: TextStyle(fontSize: 24),
        ),
      ),
      right: Padding(
        padding: const EdgeInsets.all(24.0),
        child: const SizedBox(),
      ),
    );
  }
}

class BlurbContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplitPanel(
      left: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          'Hello world',
          textAlign: TextAlign.end,
          style: TextStyle(fontSize: 24),
        ),
      ),
      right: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'An engineer at heart; loves the art of building.  Rooted in aspects '
              'of health and clean design.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'I am currently engineering applications, tools, and systems '
              'in a pharmaceutical environment; bringing modern development '
              'practices to an environment largely shared by a regulated health '
              'space.',
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.roboto(
        textStyle: TextStyle(fontSize: 80),
      ),
      child: SplitPanel(
        left: Text(
          'Cody',
          textAlign: TextAlign.end,
        ),
        right: Text(
          'Goldberg',
        ),
      ),
    );
  }
}

class SplitPanel extends StatelessWidget {
  const SplitPanel({
    Key? key,
    required this.left,
    required this.right,
  }) : super(key: key);

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: left,
        ),
        const SizedBox(width: 16),
        Flexible(
          flex: 5,
          fit: FlexFit.tight,
          child: right,
        ),
      ],
    );
  }
}

class BlendMask extends SingleChildRenderObjectWidget {
  const BlendMask({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderBlendMask();
  }
}

class RenderBlendMask extends RenderProxyBox {
  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.saveLayer(
      offset & size,
      Paint()
        ..blendMode = BlendMode.difference
        ..color = Colors.white,
    );

    super.paint(context, offset);

    context.canvas.restore();
  }
}
