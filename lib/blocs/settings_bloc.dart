import 'package:bloc/bloc.dart';
import 'package:duck_shop/infrastructure/settings_repository.dart';
import 'package:duck_shop/models/settings.dart';
import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class DefaultSettings extends SettingsState {
  final Settings settings;
  const DefaultSettings({this.settings});
}

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SetDefaultSettings extends SettingsEvent {}

class UpdateSettings extends SettingsEvent {
  final Settings settings;
  const UpdateSettings({this.settings});
}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsRepository settingsRepository;
  SettingsBloc({this.settingsRepository});

  @override
  SettingsState get initialState => DefaultSettings();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SetDefaultSettings) {
      var settings = await settingsRepository.get();
      yield DefaultSettings(settings: settings);
    }
    if (event is UpdateSettings) {
      await settingsRepository.update(event.settings);
      yield DefaultSettings(settings: event.settings);
    }
  }
}
