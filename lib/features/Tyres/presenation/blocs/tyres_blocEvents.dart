// tyre_events.dart

import 'package:equatable/equatable.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/ChangeTyrePositionUseCase.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/InstallTyreToATruckUseCase.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/RemoveTyreFromATruckUseCase.dart';

abstract class TyreEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event to add a tyre
class AddTyreEvent extends TyreEvent {
  final TyreEntity tyre;

  AddTyreEvent({required this.tyre});

  @override
  List<Object?> get props => [tyre];
}

// Event to get tyre data by ID
class GetTyreDataEvent extends TyreEvent {
  final int tyreId;

  GetTyreDataEvent({required this.tyreId});

  @override
  List<Object?> get props => [tyreId];
}

// Event to delete a tyre by ID
class DeleteTyreEvent extends TyreEvent {
  final int tyreId;

  DeleteTyreEvent({required this.tyreId});

  @override
  List<Object?> get props => [tyreId];
}

// Event to change the position of a tyre
class ChangeTyrePositionEvent extends TyreEvent {
  final ChangeTyrePositionParams params;

  ChangeTyrePositionEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

// Event to get all tyres for a specific truck
class GetTyresForATruckEvent extends TyreEvent {
  final int truckId;

  GetTyresForATruckEvent({required this.truckId});

  @override
  List<Object?> get props => [truckId];
}

// Event to install a tyre on a truck
class InstallTyreOnTruckEvent extends TyreEvent {
  final TyreEntity params;

  InstallTyreOnTruckEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

// Event to remove a tyre from a truck
class RemoveTyreFromTruckEvent extends TyreEvent {
  final int tyreId;

  RemoveTyreFromTruckEvent({required this.tyreId});

  @override
  List<Object?> get props => [tyreId];
}

// Event to get a tyre by serial number
class GetTyreBySerialEvent extends TyreEvent {
  final String serial;

  GetTyreBySerialEvent({required this.serial});

  @override
  List<Object?> get props => [serial];
}

class GetNextTyreIdEvent extends TyreEvent {
  @override
  List<Object?> get props => [];
}
