import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/navigation_cubit.dart';

/// Drives [NavigationCubit.tick] from a vsync [Ticker], only while playing.
///
/// The ticker is owned by this widget's State and disposed with it, so no
/// frame callback can outlive the screen. Tickers also don't fire while the
/// app is backgrounded; the animator clamps the first delta after resume.
class NavigationTicker extends StatefulWidget {
  const NavigationTicker({required this.child, super.key});

  final Widget child;

  @override
  State<NavigationTicker> createState() => _NavigationTickerState();
}

class _NavigationTickerState extends State<NavigationTicker>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker = createTicker(_onTick);
  Duration _last = Duration.zero;

  void _onTick(Duration elapsed) {
    final delta = elapsed - _last;
    _last = elapsed;
    if (!mounted) return;
    context.read<NavigationCubit>().tick(delta);
  }

  void _sync(bool playing) {
    if (playing && !_ticker.isActive) {
      _last = Duration.zero; // Ticker.elapsed restarts at zero on start().
      _ticker.start();
    } else if (!playing && _ticker.isActive) {
      _ticker.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    _sync(context.read<NavigationCubit>().state.isPlaying);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationCubit, NavigationState>(
      listenWhen: (a, b) => a.isPlaying != b.isPlaying,
      listener: (_, state) => _sync(state.isPlaying),
      child: widget.child,
    );
  }
}
