// truck_bloc.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';
import 'package:tyres_frontend/features/Trucks/domain/usecases/usaeCase_addTruck.dart';
import 'package:tyres_frontend/features/Trucks/domain/usecases/usaeCase_getTruck.dart';
import 'package:tyres_frontend/features/Trucks/domain/usecases/usaeCase_removeTruck.dart';
import 'package:tyres_frontend/features/Trucks/domain/usecases/usaeCase_searchTrucks.dart';
import 'package:tyres_frontend/features/Trucks/domain/usecases/usaeCase_updateTruck.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_blocEvents.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_blocStates.dart';

class TruckBloc extends Bloc<TruckEvent, TruckState> {
  final AddTruckUseCase addTruckUseCase;
  final GetTruckUseCase getTruckUseCase;
  final RemoveTruckUseCase removeTruckUseCase;
  final SearchTrucksUseCase searchTrucksUseCase;
  final UpdateTruckUseCase updateTruckUseCase;

  TruckBloc({
    required this.addTruckUseCase,
    required this.getTruckUseCase,
    required this.removeTruckUseCase,
    required this.searchTrucksUseCase,
    required this.updateTruckUseCase,
  }) : super(TruckInitialState()) {
    on<AddTruckEvent>((event, emit) async {
      emit(TruckLoadingState());
      final Either<Failure, TruckEntity> result = await addTruckUseCase(event.truck);
      result.fold(
        (failure) => emit(TruckErrorState(message: failure.message)),
        (truck) => emit(TruckAddedState(truck: truck)),
      );
    });

    on<GetTruckEvent>((event, emit) async {
      emit(TruckLoadingState());
      final Either<Failure, TruckEntity> result = await getTruckUseCase(event.truckId);
      result.fold(
        (failure) => emit(TruckErrorState(message: failure.message)),
        (truck) => emit(TruckLoadedState(truck: truck)),
      );
    });

    on<RemoveTruckEvent>((event, emit) async {
      emit(TruckLoadingState());
      final Either<Failure, NoParams> result = await removeTruckUseCase(event.truckId);
      result.fold(
        (failure) => emit(TruckErrorState(message: failure.message)),
        (_) => emit(TruckRemovedState(truckId: event.truckId)),
      );
    });

    on<SearchTrucksEvent>((event, emit) async {
      emit(TruckLoadingState());
      final Either<Failure, List<TruckEntity>> result = await searchTrucksUseCase(event.searchTerm);
      result.fold(
        (failure) => emit(TruckErrorState(message: failure.message)),
        (trucks) => emit(TrucksSearchedState(trucks: trucks)),
      );
    });

    on<UpdateTruckEvent>((event, emit) async {
      emit(TruckLoadingState());
      final Either<Failure, TruckEntity> result = await updateTruckUseCase(event.updatedTruck);
      result.fold(
        (failure) => emit(TruckErrorState(message: failure.message)),
        (truck) => emit(TruckUpdatedState(truck: truck)),
      );
    });
  }
}
