import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import '../../data/datasources/work_data_source.dart';
import '../../data/repositories/work_repository.dart';

/// The base class for all events processed by [HomeBloc].
abstract class HomeEvent {}

/// An event that instructs the [HomeBloc] to load works.
///
/// Typically, this event is dispatched to fetch all the works
/// from a data source.
class CheckIfAnyWorkExistsEvent extends HomeEvent {}

/// The base class for all states emitted by [HomeBloc].
abstract class HomeState {}

/// Represents the initial state for the [HomeBloc].
///
/// This state is emitted when the bloc is first created or reset.
class WorkDoneInitial extends HomeState {}

/// Represents the state when there are one or more tasks or works
/// that have been completed.
///
/// This state indicates that the user has completed some tasks and
/// there are records of such in the system.
class WorkDoneLengthMoreThanZero extends HomeState {}

/// Represents the state when no tasks or works have been completed.
///
/// This state indicates that the user hasn't completed any task and
/// there's no record of any completed task in the system.
class WorkDoneLengthEqualsZero extends HomeState {}

/// Represents an error state.
///
/// This state is emitted when there's an error processing tasks or works.
class WorkDoneError extends HomeState {
  /// Creates an error state with a descriptive error [message].
  WorkDoneError(this.message);

  /// Descriptive error message explaining what went wrong.
  final String message;
}

/// A [Bloc] that manages the home screen's state and events.
///
/// Listens to [HomeEvent]s and emits [HomeState]s in response to changes in
/// the home screen's data or user interactions.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// Constructs a new instance of [HomeBloc].
  ///
  /// Upon initialization, it listens to [CheckIfAnyWorkExistsEvent] events and
  /// processes them using [_checkIfAnyWorkExists].
  HomeBloc()
      : _workRepository = GetIt.I<WorkDataSource>(),
        super(WorkDoneInitial()) {
    on<CheckIfAnyWorkExistsEvent>(_checkIfAnyWorkExists);
  }

  /// The repository to interact with `Work` data.
  final WorkRepository _workRepository;

  Future<void> _checkIfAnyWorkExists(
    CheckIfAnyWorkExistsEvent event,
    Emitter<HomeState> emit,
  ) async {
    final log = Logger('CheckIfAnyWorkExistsEvent_loadData');
    try {
      final savedWorks = await _workRepository.loadWorks();
      if (savedWorks.isEmpty) {
        emit(WorkDoneLengthEqualsZero());
      } else {
        emit(WorkDoneLengthMoreThanZero());
      }
    } catch (error) {
      log.log(Level.WARNING, error.toString());
      emit(WorkDoneError(error.toString()));
    }
  }
}
