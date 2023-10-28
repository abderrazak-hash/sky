import 'package:flutter/material.dart';

abstract class DirectionIntent extends Intent {
  const DirectionIntent();
}

class DirectionIntentLeft extends DirectionIntent {
  const DirectionIntentLeft();
}

class DirectionIntentRight extends DirectionIntent {
  const DirectionIntentRight();
}

class DirectionIntentUp extends DirectionIntent {
  const DirectionIntentUp();
}

class DirectionIntentDown extends DirectionIntent {
  const DirectionIntentDown();
}
