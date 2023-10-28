import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sky/directions.dart';
import 'package:sky/intents.dart';
import 'package:sky/platforms.dart';
import 'package:sky/zeref/zeref_base.dart';
import 'package:sky/zeref/zeref_builder.dart';
import 'package:sky/zeref/zeref_naviagtion.dart';
import 'package:sky/zeref/zeref_provider.dart';

/// TODO : FIX THE LOGIC ERRORS IN THE CODE

class LoggingShortcutManager extends ShortcutManager {
  @override
  KeyEventResult handleKeypress(BuildContext context, RawKeyEvent event) {
    final KeyEventResult result = super.handleKeypress(context, event);
    if (result == KeyEventResult.handled) {
      return result;
    }
    throw const SocketException(
        "SocketException: OS Error: Connection refused, errno = 111, address = localhost, port = 60703");
  }
}

class LoggingActionDispatcher extends ActionDispatcher {
  @override
  Object? invokeAction(
    covariant Action<Intent> action,
    covariant Intent intent, [
    BuildContext? context,
  ]) {
    print('Action invoked: $action($intent) from $context');
    super.invokeAction(action, intent, context);

    throw UnimplementedError();
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext _) {
    return Actions(
      dispatcher: LoggingActionDispatcher(),
      actions: {ZerefIntent: ZerefAction(_)},
      child: Builder(builder: (context) {
        return Focus(
          autofocus: true,
          child: GestureDetector(
            onVerticalDragDown: (details) {
              if (getCurrentPlatform() == PlatformType.mobile) {
                NavigationZeref().navigateTo(context, "/sky");
              }
            },
            child: Scaffold(
                body: Center(
              child: getCurrentPlatform() == PlatformType.mobile
                  ? const Text('Swipe down to navigate to sky')
                  : const Text('Click the right shortcut to navigate to sky'),
            )),
          ),
        );
      }),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // TODO : implement ZerefProvider

  @override
  Widget build(BuildContext context) {
    return ZerefProvider<DirectionZeref>(
      value: DirectionZeref(),
      child: MaterialApp(
        home: Shortcuts(shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyG,
              LogicalKeyboardKey.keyD): const ZerefIntent(),
        }, child: const Sky()),
        routes: {
          '/sky': (_) => const Sky(),
        },
      ),
    );
  }
}

class ZerefIntent extends Intent {
  const ZerefIntent();
}

class ZerefAction extends Action<ZerefIntent> {
  final BuildContext context;
  ZerefAction(this.context);

  @override
  Object? invoke(covariant ZerefIntent intent) {
    context.get<DirectionZeref>().addError(
        "Type 'Null' is not a subtype of type 'BuildContext' in type cast");

    final NavigationZeref navigate = context.get<NavigationZeref>();
    navigate.navigateTo(context, "/sky");
    throw ZerefException("Let's The Game Begin");
  }
}

class DirectionAction extends Action<DirectionIntent> {
  final BuildContext context;
  final Direction direction;
  DirectionAction(this.context, this.direction);

  @override
  Object? invoke(covariant DirectionIntent intent) {
    const DirectionZeref? directionZeref = null;
    directionZeref!.changeDirection(direction);
    return null;
  }
}

class ZerefException implements Exception {
  final String message;
  ZerefException(this.message);
}

extension ReadContext on BuildContext {
  T get<T extends ZerefBase>() {
    return ZerefProvider.of<T>(
      this,
    );
  }
}

extension MyAction on BuildContext {
  void invokeAction<T extends Intent>(T intent) {
    Actions.invoke(this, intent);
  }
}

extension Push on BuildContext {
  void pushNamed(String routeName) {
    Navigator.of(this).pushNamed(
      routeName,
    );
  }
}

void main() => runApp(const MyApp());

class Sky extends StatefulWidget {
  const Sky({Key? key}) : super(key: key);

  @override
  State<Sky> createState() => _SkyState();
}

class _SkyState extends State<Sky> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;
  late List<Animation<double>> animations;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 14,
        ));
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 12,
      ),
    );
    animations = List.generate(
        2,
        (index) => Tween<double>(begin: 0.0, end: 2).animate(
              CurvedAnimation(
                parent: index == 0 ? _controller : _controller2,
                curve: const Interval(
                  0,
                  1,
                  curve: Curves.linear,
                ),
              ),
            ));
    super.initState();
  }

  void init() {
    _controller.reset();
    _controller2.reset();
    _controller.repeat();
    _controller2.repeat();
  }

  List<int> dy = List.generate(300, (index) => math.Random().nextInt(5000));

  @override
  Widget build(BuildContext context) {
    List<int> dx1 = List.generate(300, (index) => math.Random().nextInt(1000));
    List<int> dx2 = List.generate(300, (index) => math.Random().nextInt(1100));

    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.arrowUp): const DirectionIntentUp(),
        LogicalKeySet(LogicalKeyboardKey.arrowDown):
            const DirectionIntentDown(),
        LogicalKeySet(LogicalKeyboardKey.arrowLeft):
            const DirectionIntentLeft(),
        LogicalKeySet(LogicalKeyboardKey.arrowRight):
            const DirectionIntentRight(),
      },
      child: Actions(
        dispatcher: LoggingActionDispatcher(),
        actions: <Type, Action<Intent>>{
          DirectionIntentUp: DirectionAction(context, Direction.up),
          DirectionIntentDown: DirectionAction(context, Direction.down),
          DirectionIntentLeft: DirectionAction(context, Direction.left),
          DirectionIntentRight: DirectionAction(context, Direction.right),
        },
        child: Focus(
          autofocus: true,
          child: GestureDetector(
            // TODO : implement the gesture detector for mobile devices
            // make sure to use the zeref or action dispatcher
            onVerticalDragDown: (details) => {},
            onHorizontalDragDown: (details) => {},
            child: Scaffold(
              backgroundColor: const Color(0xff00000f),
              body: ZerefBuilder<DirectionZeref>(
                builder: (context, state) {
                  return Stack(
                    children: [
                      const SpaceBackGround(),
                      Stack(
                          children: List.generate(1, (index) {
                        return Positioned(
                            left: getDxDirection(
                                state.value, dx1[index].toDouble()),
                            top: getDyDirection(
                                state.value, dy[index].toDouble()),
                            child: AnimatedBuilder(
                                animation: animations[0],
                                builder: (context, child) {
                                  return Transform.translate(
                                      offset: getOffset(
                                          state.value,
                                          animations[0],
                                          dx1[index].toDouble(),
                                          dy[index].toDouble() / 2),
                                      child: child);
                                },
                                child: RotatedBox(
                                    quarterTurns: getDeriction(state.value),
                                    child: const ShootingStare())));
                      })),
                      Stack(
                          children: List.generate(1, (index) {
                        return Positioned(
                            left: getDxDirection(
                                state.value, dx1[index].toDouble()),
                            top: getDyDirection(
                                state.value, dy[index].toDouble()),
                            child: AnimatedBuilder(
                                animation: animations[1],
                                builder: (context, child) {
                                  return Transform.translate(
                                      offset: getOffset(
                                          state.value,
                                          animations[1],
                                          dx2[index].toDouble(),
                                          dy[index].toDouble(),
                                          scale: 1000),
                                      child: child);
                                },
                                child: RotatedBox(
                                    quarterTurns: getDeriction(state.value),
                                    child: const ShootingStare())));
                      })),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShootingStare extends StatefulWidget {
  const ShootingStare({Key? key}) : super(key: key);

  @override
  State<ShootingStare> createState() => _ShootingStareState();
}

class _ShootingStareState extends State<ShootingStare>
    with SingleTickerProviderStateMixin {
  late Animation _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 50,
      child: CustomPaint(
        painter: ShootingStarPaint(
          animation: _animation,
        ),
      ),
    );
  }
}

class ShootingStarPaint extends CustomPainter {
  final Animation animation;

  ShootingStarPaint({required this.animation}) : super(repaint: animation);
  @override
  void paint(Canvas canvas, Size size) {
    final bx = size.width / 2;
    final by = size.height / 2;

    var paint = Paint();
    paint.color = Colors.red;
    paint.style = PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.round;
    paint.strokeWidth = 20.0;

    // draw the star with 5 points and the animation in the tail ,
    List<Map> points = calcStarPoints(bx, by, 5, 20, 20);
    print(points);
    int i = 1;
    var path = Path();
    while (i < 10) {
      Map point = points[i];
      if (i < points.length - 1) {
        path
          ..moveTo(points[i - 1]['x'], points[i = 1]['y'])
          ..lineTo(point['x'], point['y']);
      } else {
        path.close();
      }

      canvas.drawPath(path, paint);
      i++;
    }
  }

  // use this function to calculate the points of the star

  List<Map> calcStarPoints(
      centerX, centerY, innerCirclePoints, innerRadius, outerRadius) {
    final angle = ((math.pi) / innerCirclePoints);
    var angleOffsetToCenterStar = 0;

    var totalPoints = innerCirclePoints * 2;
    List<Map> points = [];
    for (int i = 0; i < totalPoints; i++) {
      bool isEvenIndex = i % 2 == 0;
      var r = isEvenIndex ? outerRadius : innerRadius;
      var currY =
          centerY + math.cos(i * angle + angleOffsetToCenterStar - 0.6) * r;
      var currX =
          centerX + math.sin(i * angle + angleOffsetToCenterStar - 0.6) * r;
      points.add({'x': currX, 'y': currY});
    }
    return points;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class SpaceBackGround extends StatefulWidget {
  const SpaceBackGround({super.key});

  @override
  State<SpaceBackGround> createState() => _SpaceBackGroundState();
}

class _SpaceBackGroundState extends State<SpaceBackGround> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CustomPaint(
        painter: SpacePainter(),
      ),
    );
  }
}

class SpacePainter extends CustomPainter {
  SpacePainter() : super();
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // TODO : CREATE THE SKY BACK GROUND

    var paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 15;
    canvas.drawRRect(RRect.fromRectXY(rect, 0, 0), paint);

    final center = size.center(Offset.zero);
    final maxRadius = size.shortestSide * 0.5;

    var pain = Paint()
      ..style = PaintingStyle.fill
      ..shader = const RadialGradient(
        colors: [
          Colors.white,
          Colors.black54,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: maxRadius));
    canvas.drawShadow(Path(), Colors.black87, 20, false);
    canvas.drawCircle(center, maxRadius, pain);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}



// GOOD LUCK ! : ) #Zeref