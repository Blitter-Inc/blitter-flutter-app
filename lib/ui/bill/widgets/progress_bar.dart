import 'dart:math';
import 'package:flutter/material.dart';

import 'package:blitter_flutter_app/utils/extensions.dart';

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
      children: [
        Container(
          height: 20,
          width: progressBarWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: colorScheme.progressBarContainer,
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
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (_progressBarWidthFactor <= 0.12)
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '$_progressBarPercentage%',
                style: TextStyle(
                  color: colorScheme.progressBarEmptyText,
                  fontSize: 11.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
