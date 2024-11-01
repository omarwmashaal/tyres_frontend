// tyre_states.dart

import 'package:equatable/equatable.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';

abstract class TyreState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state, when nothing has happened yet
class TyreInitialState extends TyreState {}

// State when a loading process is happening
class TyreLoadingState extends TyreState {}

// State when a tyre is successfully added
class TyreAddedState extends TyreState {}

// State when a tyre's position is successfully changed
class TyrePositionChangedState extends TyreState {}

// State when a tyre is successfully fetched
class TyreLoadedState extends TyreState {
  final TyreEntity tyre;

  TyreLoadedState({required this.tyre});

  @override
  List<Object?> get props => [tyre];
}
// State when a tyres are successfully fetched
class TyresLoadedState extends TyreState {
  final List<TyreEntity> tyres;

  TyresLoadedState({required this.tyres});

  @override
  List<Object?> get props => [tyres];
}

// State when a tyre is successfully deleted
class TyreDeletedState extends TyreState {
  final int tyreId;

  TyreDeletedState({required this.tyreId});

  @override
  List<Object?> get props => [tyreId];
}

// State when tyres for a truck are successfully fetched
class TyresForTruckLoadedState extends TyreState {
  final List<TyreEntity> tyres;

  TyresForTruckLoadedState({required this.tyres});

  @override
  List<Object?> get props => [tyres];
}

// State when a tyre is successfully installed on a truck
class TyreInstalledOnTruckState extends TyreState {}

// State when a tyre is successfully removed from a truck
class TyreRemovedFromTruckState extends TyreState {}

// State when an error occurs
class TyreErrorState extends TyreState {
  final String message;

  TyreErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
