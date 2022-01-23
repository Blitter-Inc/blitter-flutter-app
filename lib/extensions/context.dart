import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/ui.dart';
import 'package:blitter_flutter_app/ui/shared.dart';

extension CustomBuildContext on BuildContext {
  void switchThemeMode() {
    final configBloc = read<ConfigBloc>();
    configBloc.add(SwitchThemeMode());
  }

  void showColorPickerSheet() {
    showModalBottomSheet(
      context: this,
      barrierColor: Colors.black87,
      backgroundColor: Colors.transparent,
      builder: (context) => const ColorPickerSheet(),
    );
  }

  void resetApp() async {
    read<AuthBloc>().add(ResetAuthBloc());
    read<BillBloc>().add(ResetBillBloc());
    read<ConfigBloc>().add(ResetConfigBloc());
    read<ContactBloc>().add(ResetContactBloc());
    await Future.delayed(const Duration(milliseconds: 100));
    Navigator.of(this).pushNamedAndRemoveUntil(
      SigninScreen.route,
      (route) => false,
    );
  }
}
