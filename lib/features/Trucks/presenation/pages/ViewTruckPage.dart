import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_bloc.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_blocEvents.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_blocStates.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';
import 'package:tyres_frontend/features/Trucks/presenation/widgets/EditTruckForm.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEnums.dart';
import 'package:collection/collection.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyrePositionEntity.dart';

class ViewTruckPage extends StatelessWidget {
  final int truckId; // Truck ID passed for fetching the truck details

  const ViewTruckPage({Key? key, required this.truckId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TyreEntity> generateMockTyres() {
      return [
        // Front row (single wheels)
        TyreEntity(
          id: 1,
          truckId: 101,
          startMileage: 5000,
          endMileage: null,
          serial: 'FL-1234',
          model: 'Goodyear',
          position: TyrePositionEntity(direction: enum_TyreDirection.Single, side: enum_TyreSide.Left, index: 1),
        ),
        TyreEntity(
          id: 2,
          truckId: 101,
          startMileage: 5000,
          endMileage: null,
          serial: 'FR-5678',
          model: 'Michelin',
          position: TyrePositionEntity(direction: enum_TyreDirection.Single, side: enum_TyreSide.Right, index: 1),
        ),

        // Second row (double wheels)
        TyreEntity(
          id: 3,
          truckId: 101,
          startMileage: 5000,
          endMileage: null,
          serial: 'L2O-1111',
          model: 'Bridgestone',
          position: TyrePositionEntity(direction: enum_TyreDirection.Outer, side: enum_TyreSide.Left, index: 2),
        ),
        TyreEntity(
          id: 4,
          truckId: 101,
          startMileage: 5000,
          endMileage: null,
          serial: 'L2I-2222',
          model: 'Pirelli',
          position: TyrePositionEntity(direction: enum_TyreDirection.Inner, side: enum_TyreSide.Left, index: 2),
        ),
        TyreEntity(
          id: 5,
          truckId: 101,
          startMileage: 5000,
          endMileage: null,
          serial: 'R2O-3333',
          model: 'Goodyear',
          position: TyrePositionEntity(direction: enum_TyreDirection.Outer, side: enum_TyreSide.Right, index: 2),
        ),
        TyreEntity(
          id: 6,
          truckId: 101,
          startMileage: 5000,
          endMileage: null,
          serial: 'R2I-4444',
          model: 'Michelin',
          position: TyrePositionEntity(direction: enum_TyreDirection.Inner, side: enum_TyreSide.Right, index: 2),
        ),

        // Third row
        TyreEntity(
          id: 7,
          truckId: 101,
          startMileage: 5000,
          endMileage: null,
          serial: 'L3O-5555',
          model: 'Bridgestone',
          position: TyrePositionEntity(direction: enum_TyreDirection.Outer, side: enum_TyreSide.Left, index: 3),
        ),
        TyreEntity(
          id: 8,
          truckId: 101,
          startMileage: 5000,
          endMileage: null,
          serial: 'L3I-6666',
          model: 'Pirelli',
          position: TyrePositionEntity(direction: enum_TyreDirection.Inner, side: enum_TyreSide.Left, index: 3),
        ),
        TyreEntity(
          id: 9,
          truckId: 101,
          startMileage: 5000,
          endMileage: null,
          serial: 'R3O-7777',
          model: 'Goodyear',
          position: TyrePositionEntity(direction: enum_TyreDirection.Outer, side: enum_TyreSide.Right, index: 3),
        ),
        TyreEntity(
          id: 10,
          truckId: 101,
          startMileage: 5000,
          endMileage: null,
          serial: 'R3I-8888',
          model: 'Michelin',
          position: TyrePositionEntity(direction: enum_TyreDirection.Inner, side: enum_TyreSide.Right, index: 3),
        ),

        // Fourth row (has missing tyre)
        TyreEntity(
          id: 11,
          truckId: 101,
          startMileage: 5000,
          endMileage: null,
          serial: 'L4O-9999',
          model: 'Bridgestone',
          position: TyrePositionEntity(direction: enum_TyreDirection.Outer, side: enum_TyreSide.Left, index: 4),
        ),
        // Missing one tyre here (right inner of row 4)

        TyreEntity(
          id: 12,
          truckId: 101,
          startMileage: 5000,
          endMileage: null,
          serial: 'R4O-1010',
          model: 'Goodyear',
          position: TyrePositionEntity(direction: enum_TyreDirection.Outer, side: enum_TyreSide.Right, index: 4),
        ),
      ];
    }

    // Access the TruckBloc directly using BlocProvider
    final truckBloc = BlocProvider.of<TruckBloc>(context);

    // Fetch the truck details when the page is first built
    truckBloc.add(GetTruckEvent(truckId: truckId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Truck Details',
          style: TextStyle(fontSize: 18.sp), // Responsive text size
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w), // Responsive padding
        child: BlocBuilder<TruckBloc, TruckState>(
          builder: (context, state) {
            if (state is TruckLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TruckLoadedState) {
              final TruckEntity truck = state.truck;

              return ListView(
                children: [
                  // Plate Number
                  ListTile(
                    title: Text(
                      'Plate Number',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold), // Responsive text
                    ),
                    subtitle: Text(
                      truck.platNo ?? "N/A",
                      style: TextStyle(fontSize: 14.sp), // Responsive text
                    ),
                  ),
                  Divider(),

                  // Current Mileage
                  ListTile(
                    title: Text(
                      'Current Mileage',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold), // Responsive text
                    ),
                    subtitle: Text(
                      '${truck.currentMileage ?? 0} km',
                      style: TextStyle(fontSize: 14.sp), // Responsive text
                    ),
                  ),
                  Divider(),

                  // Tyre IDs
                  ListTile(
                    title: Text(
                      'Tyre IDs',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold), // Responsive text
                    ),
                    subtitle: Text(
                      truck.tyreIds != null && truck.tyreIds!.isNotEmpty ? truck.tyreIds!.join(', ') : 'No tyres assigned',
                      style: TextStyle(fontSize: 14.sp), // Responsive text
                    ),
                  ),
                  Divider(),

                  // Display Tyre Layout
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Text(
                      'Tyre Layout',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),

                  SizedBox(height: 16.h), // Spacing

                  // Build the tyre layout based on the TyreEntity list
                  buildTyreLayout(context, generateMockTyres() ?? []),

                  Divider(),

                  // Edit Button (Popup Modal for Editing Truck)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h), // Responsive padding
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Show the modal bottom sheet for editing the truck
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true, // Ensures the modal is full-height
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                          ),
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
                                top: 16.h,
                                left: 16.w,
                                right: 16.w,
                              ),
                              child: EditTruckForm(truck: truck, truckBloc: truckBloc),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit, size: 20.sp), // Responsive icon size
                      label: Text(
                        'Edit Truck',
                        style: TextStyle(fontSize: 16.sp), // Responsive text
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is TruckErrorState) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: TextStyle(fontSize: 16.sp), // Responsive text
                ),
              );
            }

            // Default state when no data is available
            return Center(
              child: Text(
                'No truck details available.',
                style: TextStyle(fontSize: 16.sp), // Responsive text
              ),
            );
          },
        ),
      ),
    );
  }

  // Builds the tyre layout based on the tyre positions
  Widget buildTyreLayout(BuildContext context, List<TyreEntity> tyres) {
    return Column(
      children: [
        // First row (single front wheels)
        buildDoubleWheels(
          context,
          findTyre(tyres, enum_TyreSide.Left, 1, enum_TyreDirection.Single),
          findTyre(tyres, enum_TyreSide.Right, 1, enum_TyreDirection.Single),
          'Front Left',
          'Front Right',
        ),

        SizedBox(height: 40.h), // Spacing between rows

        // Second to Seventh rows (double wheels)
        for (int row = 2; row <= 7; row++)
          Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: buildDoubleWheels(
              context,
              findTyre(tyres, enum_TyreSide.Left, row, enum_TyreDirection.Outer),
              findTyre(tyres, enum_TyreSide.Right, row, enum_TyreDirection.Outer),
              'L${row}O',
              'R${row}O',
              leftInner: findTyre(tyres, enum_TyreSide.Left, row, enum_TyreDirection.Inner),
              rightInner: findTyre(tyres, enum_TyreSide.Right, row, enum_TyreDirection.Inner),
            ),
          ),
      ],
    );
  }

  // Builds a row of tyres (single front or double back)
  Widget buildDoubleWheels(
    BuildContext context,
    TyreEntity? leftOuter,
    TyreEntity? rightOuter,
    String leftLabel,
    String rightLabel, {
    TyreEntity? leftInner,
    TyreEntity? rightInner,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left wheels (Outer and possibly Inner)
        Row(
          children: [
            buildWheel(context, leftOuter, leftLabel),
            if (leftOuter?.position?.direction != enum_TyreDirection.Single) buildWheel(context, leftInner, leftLabel),
          ],
        ),
        // Right wheels (Outer and possibly Inner)
        Row(
          children: [
            if (rightOuter?.position?.direction != enum_TyreDirection.Single) buildWheel(context, rightInner, rightLabel),
            buildWheel(context, rightOuter, rightLabel),
          ],
        ),
      ],
    );
  }

  // Builds a single wheel widget
  Widget buildWheel(BuildContext context, TyreEntity? tyre, String label) {
    if (tyre != null) {
      return GestureDetector(
        onTap: () {
          showTyreInfo(context, tyre);
        },
        child: Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: Colors.grey[700],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.circle,
        ),
      );
    }
  }

  // Finds a tyre based on its position
  TyreEntity? findTyre(List<TyreEntity> tyres, enum_TyreSide side, int row, enum_TyreDirection direction) {
    return tyres.firstWhereOrNull(
      (tyre) => tyre.position!.side == side && tyre.position!.index == row && tyre.position!.direction == direction,
    );
  }

  // Show tyre info in a dialog
  void showTyreInfo(BuildContext context, TyreEntity tyre) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tyre Info'),
          content: Text(
            'Serial: ${tyre.serial}\nModel: ${tyre.model}\nStart Mileage: ${tyre.startMileage}\nEnd Mileage: ${tyre.endMileage ?? "N/A"}',
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
