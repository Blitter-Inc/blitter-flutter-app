import 'package:hydrated_bloc/hydrated_bloc.dart';

import './config_event.dart';
import './config_state.dart';

class ConfigBloc extends HydratedBloc<ConfigEvent, ConfigState> {
  ConfigBloc() : super(const ConfigState()) {
    on<SwitchThemeMode>(
      (event, emit) => emit(
        state.copyWith(darkModeEnabled: !state.darkModeEnabled),
      ),
    );
    on<SetPrimaryColor>(
      (event, emit) => emit(
        state.copyWith(
          primaryColor: event.color,
          // shall be removed when seperate color for modules will be followed
          billPrimaryColor: event.color,
        ),
      ),
    );
    on<SetBillPrimaryColor>(
      (event, emit) => emit(
        state.copyWith(billPrimaryColor: event.color),
      ),
    );
    on<ResetConfigBloc>((_, emit) => emit(const ConfigState()));
  }

  @override
  ConfigState fromJson(Map<String, dynamic> json) => ConfigState.fromJson(json);

  @override
  Map<String, dynamic> toJson(ConfigState state) => state.toJson();
}
