part of 'home_bloc.dart';

/// The base class for all events processed by [HomeBloc].
abstract class HomeEvent {}

/// An event that instructs the [HomeBloc] to load works.
///
/// Typically, this event is dispatched to fetch all the works
/// from a data source.
class CheckIfAnyWorkExistsEvent extends HomeEvent {}
