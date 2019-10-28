import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DefaultDashboard extends DashboardState {}

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class SetDefaultDashboard extends DashboardEvent {}

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  @override
  DashboardState get initialState => DefaultDashboard();

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is SetDefaultDashboard) {
      yield DefaultDashboard();
    }
  }
}
