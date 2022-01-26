import 'dart:math';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    Key? key,
    required this.currentValue,
    required this.totalValue,
  }) : super(key: key);

  final double currentValue;
  final double totalValue;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double _progressBarWidthFactor = 0;
  String _progressBarPercentage = '';

  double _getProgressBarWidthFactor() =>
      min(widget.currentValue / widget.totalValue, 1);

  Future<void> _setProgressBarWidthFactor() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      _progressBarWidthFactor = _getProgressBarWidthFactor();
      _progressBarPercentage =
          (_progressBarWidthFactor * 100).toStringAsFixed(0);
    });
  }

  @override
  void initState() {
    super.initState();
    _setProgressBarWidthFactor();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    final progressBarWidth = mediaQuery.size.width - 30;

    return Stack(
      alignment: _progressBarWidthFactor > 0.12
          ? AlignmentDirectional.topStart
          : AlignmentDirectional.center,
      children: [
        Container(
          height: 20,
          width: progressBarWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey[850],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuint,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 20,
                  width: progressBarWidth * _progressBarWidthFactor,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.shade300,
                        colorScheme.primary,
                      ],
                    ),
                  ),
                ),
                if (_progressBarWidthFactor > 0.12)
                  Positioned(
                    right: 5,
                    child: Text(
                      '$_progressBarPercentage%',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (_progressBarWidthFactor <= 0.12)
          const Text(
            'Nothing significant yet',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
