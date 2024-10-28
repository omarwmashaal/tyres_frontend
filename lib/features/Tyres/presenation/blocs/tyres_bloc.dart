// tyre_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/AddTyreUseCase.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/ChangeTyrePositionUseCase.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/DeleteTyreUseCase.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/GetTyreBySerialUseCase.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/InstallTyreToATruckUseCase.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/RemoveTyreFromATruckUseCase.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/getTyresForATruckUseCase.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_blocEvents.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_blocStates.dart';

class TyreBloc extends Bloc<TyreEvent, TyreState> {
  final AddTyreUseCase addTyreUseCase;
  final ChangeTyrePositionUseCase changeTyrePositionUseCase;
  final DeleteTyreUseCase deleteTyreUseCase;
  final GetTyreBySerialUseCase getTyreBySerialUseCase;
  final GetTyresForATruckUseCase getTyresForATruckUseCase;
  final InstallTyreToATruckUseCase installTyreToATruckUseCase;
  final RemoveTyreFromATruckUseCase removeTyreFromATruckUseCase;

  TyreBloc({
    required this.addTyreUseCase,
    required this.changeTyrePositionUseCase,
    required this.deleteTyreUseCase,
    required this.getTyreBySerialUseCase,
    required this.getTyresForATruckUseCase,
    required this.installTyreToATruckUseCase,
    required this.removeTyreFromATruckUseCase,
  }) : super(TyreInitialState()) {
    // Add a new tyre
    on<AddTyreEvent>((event, emit) async {
      emit(TyreLoadingState());
      final Either<Failure, NoParams> result = await addTyreUseCase(event.tyre);
      result.fold(
        (failure) => emit(TyreErrorState(message: failure.message)),
        (_) => emit(TyreAddedState()),
      );
    });

    // Change a tyre's position
    on<ChangeTyrePositionEvent>((event, emit) async {
      emit(TyreLoadingState());
      final Either<Failure, NoParams> result = await changeTyrePositionUseCase(event.params);
      result.fold(
        (failure) => emit(TyreErrorState(message: failure.message)),
        (_) => emit(TyrePositionChangedState()),
      );
    });

    // Get tyre data by ID
    on<GetTyreDataEvent>((event, emit) async {
      emit(TyreLoadingState());
      final Either<Failure, TyreEntity> result = await getTyreBySerialUseCase(event.tyreId.toString());
      result.fold(
        (failure) => emit(TyreErrorState(message: failure.message)),
        (tyre) => emit(TyreLoadedState(tyre: tyre)),
      );
    });

    // Delete a tyre by ID
    on<DeleteTyreEvent>((event, emit) async {
      emit(TyreLoadingState());
      final Either<Failure, NoParams> result = await deleteTyreUseCase(event.tyreId);
      result.fold(
        (failure) => emit(TyreErrorState(message: failure.message)),
        (_) => emit(TyreDeletedState(tyreId: event.tyreId)),
      );
    });

    // Get all tyres for a specific truck
    on<GetTyresForATruckEvent>((event, emit) async {
      emit(TyreLoadingState());
      final Either<Failure, List<TyreEntity>> result = await getTyresForATruckUseCase(event.truckId);
      result.fold(
        (failure) => emit(TyreErrorState(message: failure.message)),
        (tyres) => emit(TyresForTruckLoadedState(tyres: tyres)),
      );
    });

    // Install a tyre on a truck
    on<InstallTyreOnTruckEvent>((event, emit) async {
      emit(TyreLoadingState());
      final Either<Failure, NoParams> result = await installTyreToATruckUseCase(event.params);
      result.fold(
        (failure) => emit(TyreErrorState(message: failure.message)),
        (_) => emit(TyreInstalledOnTruckState()),
      );
    });

    // Remove a tyre from a truck
    on<RemoveTyreFromTruckEvent>((event, emit) async {
      emit(TyreLoadingState());
      final Either<Failure, NoParams> result = await removeTyreFromATruckUseCase(event.params);
      result.fold(
        (failure) => emit(TyreErrorState(message: failure.message)),
        (_) => emit(TyreRemovedFromTruckState()),
      );
    });

    // Get a tyre by serial number
    on<GetTyreBySerialEvent>((event, emit) async {
      emit(TyreLoadingState());
      final Either<Failure, TyreEntity> result = await getTyreBySerialUseCase(event.serial);
      result.fold(
        (failure) => emit(TyreErrorState(message: failure.message)),
        (tyre) => emit(TyreLoadedState(tyre: tyre)),
      );
    });
  }
}
