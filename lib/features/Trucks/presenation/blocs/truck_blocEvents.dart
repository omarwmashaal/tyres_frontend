// truck_events.dart

import 'package:equatable/equatable.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';

abstract class TruckEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event to add a truck
class AddTruckEvent extends TruckEvent {
  final TruckEntity truck;

  AddTruckEvent({required this.truck});

  @override
  List<Object?> get props => [truck];
}

// Event to get a truck by ID
class GetTruckEvent extends TruckEvent {
  final int truckId;

  GetTruckEvent({required this.truckId});

  @override
  List<Object?> get props => [truckId];
}

// Event to remove a truck by ID
class RemoveTruckEvent extends TruckEvent {
  final int truckId;

  RemoveTruckEvent({required this.truckId});

  @override
  List<Object?> get props => [truckId];
}

// Event to search for trucks by a search term
class SearchTrucksEvent extends TruckEvent {
  final String searchTerm;

  SearchTrucksEvent({required this.searchTerm});

  @override
  List<Object?> get props => [searchTerm];
}

// Event to update an existing truck
class UpdateTruckEvent extends TruckEvent {
  final TruckEntity updatedTruck;

  UpdateTruckEvent({required this.updatedTruck});

  @override
  List<Object?> get props => [updatedTruck];
}
