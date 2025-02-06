// truck_states.dart

import 'package:equatable/equatable.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';

abstract class TruckState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state, when nothing has happened yet
class TruckInitialState extends TruckState {}

// State when a loading process is happening
class TruckLoadingState extends TruckState {}

// State when a truck is successfully added
class TruckAddedState extends TruckState {
  final TruckEntity truck;

  TruckAddedState({required this.truck});

  @override
  List<Object?> get props => [truck];
}

// State when a single truck is successfully fetched
class TruckLoadedState extends TruckState {
  final TruckEntity truck;

  TruckLoadedState({required this.truck});

  @override
  List<Object?> get props => [truck];
}

// State when a truck is successfully removed
class TruckRemovedState extends TruckState {
  final int truckId;

  TruckRemovedState({required this.truckId});

  @override
  List<Object?> get props => [truckId];
}

// State when a list of trucks is found through search
class TrucksSearchedState extends TruckState {
  final List<TruckEntity> trucks;

  TrucksSearchedState({required this.trucks});

  @override
  List<Object?> get props => [trucks];
}

// State when a truck is successfully updated
class TruckUpdatedState extends TruckState {
  final TruckEntity truck;

  TruckUpdatedState({required this.truck});

  @override
  List<Object?> get props => [truck];
}

// State when an error occurs
class TruckErrorState extends TruckState {
  final String message;

  TruckErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

// State when an error occurs
class TruckUpdateErrorState extends TruckState {
  final String message;

  TruckUpdateErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
