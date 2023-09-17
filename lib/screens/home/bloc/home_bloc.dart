import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import '../../../data/datasources/work_data_source.dart';
import '../../../data/repositories/work_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

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
