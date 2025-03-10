import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:tyres_frontend/core/Widgets/CustomTextFormField.dart';
import 'package:tyres_frontend/core/Widgets/LogoutButton.dart';
import 'package:tyres_frontend/core/Widgets/TitleText.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_bloc.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_blocEvents.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_blocStates.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';
import 'package:tyres_frontend/features/Trucks/presenation/widgets/EditTruckForm.dart';
import 'package:tyres_frontend/features/Trucks/presenation/widgets/installTyreForm.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEnums.dart';
import 'package:collection/collection.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyrePositionEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/ChangeTyrePositionUseCase.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_bloc.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_blocEvents.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_blocStates.dart';

class ViewTruckPage extends StatelessWidget {
  final int truckId; // Truck ID passed for fetching the truck details

  ViewTruckPage({Key? key, required this.truckId}) : super(key: key);

  late TruckBloc truckBloc;
  late TyreBloc tyreBloc;
  @override
  Widget build(BuildContext context) {
    // Access the TruckBloc directly using BlocProvider
    truckBloc = BlocProvider.of<TruckBloc>(context);
    tyreBloc = BlocProvider.of<TyreBloc>(context);

    // Fetch the truck details when the page is first built
    truckBloc.add(GetTruckEvent(truckId: truckId));

    return MultiBlocListener(
      listeners: [
        BlocListener<TyreBloc, TyreState>(
          listener: (context, state) {
            if (state is TyreErrorState)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            else if (state is TyreInstalledOnTruckState || state is TyreRemovedFromTruckState || state is TyrePositionChangedState)
              truckBloc.add(GetTruckEvent(truckId: truckId));

            if (state is TyreInstalledOnTruckState) {
              if (state.serial.isNotEmpty)
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('New Tyre Added'),
                      content: Text("New Serial Number: ${state.serial}"),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Okay'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
            }
          },
        ),
        BlocListener<TruckBloc, TruckState>(
          listener: (context, state) {
            if (state is TruckErrorState)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );

            if (state is TruckUpdateErrorState)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );

            if (state is TruckUpdatedState || state is TruckUpdateErrorState) truckBloc.add(GetTruckEvent(truckId: truckId));
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Truck Details',
            style: TextStyle(fontSize: 18.sp), // Responsive text size
          ),
          actions: [LogoutButton()],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w), // Responsive padding
          child: BlocBuilder<TruckBloc, TruckState>(
            buildWhen: (previous, current) => current is TruckLoadingState || current is TruckLoadedState,
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
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${truck.currentMileage ?? 0} km',
                            style: TextStyle(fontSize: 14.sp), // Responsive text
                          ),
                          Expanded(child: SizedBox()),
                          ElevatedButton.icon(
                            onPressed: () {
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
                              'Update Mileage',
                              style: TextStyle(fontSize: 16.sp), // Responsive text
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    // Current Mileage
                    ListTile(
                      title: Text(
                        'Last Updated Mileage Date',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold), // Responsive text
                      ),
                      subtitle: Text(
                        truck.lastUpdatedMileageDate == null ? "N/A" : DateFormat("dd/MM/yyyy").format(truck.lastUpdatedMileageDate!),
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
                    buildTyreLayout(context, truck.tyres ?? [], truck, false, null),

                    Divider(),

                    // Edit Button (Popup Modal for Editing Truck)
                  ],
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
      ),
    );
  }

  // Builds the tyre layout based on the tyre positions
  Widget buildTyreLayout(BuildContext context, List<TyreEntity> tyres, TruckEntity truck, bool changePosition, int? changedTyreId) {
    return Column(
      children: [
        TitleText(title: "Front Of The Truck"),
        // First row (single front wheels)
        buildDoubleWheels(context, findTyre(tyres, enum_TyreSide.Left, 1, enum_TyreDirection.Single),
            findTyre(tyres, enum_TyreSide.Right, 1, enum_TyreDirection.Single), 'Front Left', 'Front Right', truck,
            row: 1, changePosition: changePosition, changedTyreId: changedTyreId),

        SizedBox(height: 40.h), // Spacing between rows

        // Second to Seventh rows (double wheels)
        for (int row = 2; row <= 7; row++)
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 40.h),
                child: buildDoubleWheels(context, findTyre(tyres, enum_TyreSide.Left, row, enum_TyreDirection.Outer),
                    findTyre(tyres, enum_TyreSide.Right, row, enum_TyreDirection.Outer), 'L${row}', 'R${row}', truck,
                    leftInner: findTyre(tyres, enum_TyreSide.Left, row, enum_TyreDirection.Inner),
                    rightInner: findTyre(tyres, enum_TyreSide.Right, row, enum_TyreDirection.Inner),
                    row: row,
                    changePosition: changePosition,
                    changedTyreId: changedTyreId),
              ),
              if (row == 3)
                Padding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  child: Divider(),
                ),
            ],
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
    String rightLabel,
    TruckEntity truck, {
    TyreEntity? leftInner,
    TyreEntity? rightInner,
    required int row,
    required bool changePosition,
    int? changedTyreId,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left wheels (Outer and possibly Inner)
        Row(
          children: [
            buildWheel(
                context,
                leftOuter,
                (row == 1 ? enum_TyreDirection.Single : enum_TyreDirection.Outer) == enum_TyreDirection.Single ? leftLabel : leftLabel + "O",
                TyrePositionEntity(
                  direction: row == 1 ? enum_TyreDirection.Single : enum_TyreDirection.Outer,
                  side: enum_TyreSide.Left,
                  index: row,
                ),
                truck,
                changePosition,
                changedTyreId),
            if (row != 1)
              buildWheel(
                  context,
                  leftInner,
                  leftLabel + "I",
                  TyrePositionEntity(
                    direction: enum_TyreDirection.Inner,
                    side: enum_TyreSide.Left,
                    index: row,
                  ),
                  truck,
                  changePosition,
                  changedTyreId),
          ],
        ),
        // Right wheels (Outer and possibly Inner)
        Row(
          children: [
            if (row != 1)
              buildWheel(
                  context,
                  rightInner,
                  rightLabel + "I",
                  TyrePositionEntity(
                    direction: enum_TyreDirection.Inner,
                    side: enum_TyreSide.Right,
                    index: row,
                  ),
                  truck,
                  changePosition,
                  changedTyreId),
            buildWheel(
              context,
              rightOuter,
              (row == 1 ? enum_TyreDirection.Single : enum_TyreDirection.Outer) == enum_TyreDirection.Single ? rightLabel : rightLabel + "O",
              TyrePositionEntity(
                direction: row == 1 ? enum_TyreDirection.Single : enum_TyreDirection.Outer,
                side: enum_TyreSide.Right,
                index: row,
              ),
              truck,
              changePosition,
              changedTyreId,
            ),
          ],
        ),
      ],
    );
  }

  // Builds a single wheel widget
  Widget buildWheel(
      BuildContext context, TyreEntity? tyre, String label, TyrePositionEntity position, TruckEntity truck, bool changePostion, int? changedTyreId) {
    if (tyre != null) {
      return GestureDetector(
        onTap: () {
          if (!changePostion) showTyreInfo(context, tyre, truck);
        },
        child: Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: changePostion ? Colors.red : Colors.grey[700],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: changePostion ? Colors.red : Colors.white,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          if (!changePostion)
            installTyre(context, position, truck);
          else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                      'Are you sure you want to transfere tyre to ${position.side == enum_TyreSide.Left ? "Left" : "Right"} ${position.index} ${position.direction == enum_TyreDirection.Outer ? "Outer" : "Inner"}?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Yes'),
                      onPressed: () {
                        tyreBloc.add(
                          ChangeTyrePositionEvent(
                            params: ChangeTyrePositionParams(tyreId: changedTyreId!, newPosition: position),
                          ),
                        );
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: changePostion ? Colors.green : Colors.grey[300],
            shape: BoxShape.circle,
          ),
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
  void showTyreInfo(BuildContext context, TyreEntity tyre, TruckEntity truck) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tyre Info'),
          content: Text(
            'Serial: ${tyre.serial}\nModel: ${tyre.model}\nStart Mileage: ${tyre.startMileage}\nEnd Mileage: ${tyre.endMileage ?? "N/A"}\nInstalled Date: ${tyre.installedDate == null ? "N/A" : DateFormat("dd/MM/yyyy").format(tyre.installedDate!)}\nTotal Mileage on the Truck: ${(tyre.endMileage ?? 0) - (tyre.startMileage ?? 0)} Km\nTotal Tyre Mileage: ${tyre.totalMileage} Km',
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Change position on the truck!'),
              onPressed: () {
                changeTyrePositionForm(context, tyre, truck);
              },
            ),
            TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: Text(
                'Uninstall Tyre From Truck',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Are you sure you want to uninstall tyre form the truck?'),
                      content: Text('Make sure to update truck Mileage is updated!'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Yes'),
                          onPressed: () {
                            tyreBloc.add(RemoveTyreFromTruckEvent(tyreId: tyre.id!));
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  void installTyre(BuildContext context, TyrePositionEntity position, TruckEntity truck) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
          child: InstallTyreForm(
            position: position,
            truck: truck,
            tyreBloc: tyreBloc,
          ),
        );
      },
    );
  }

  void changeTyrePositionForm(BuildContext context, TyreEntity tyre, TruckEntity truck) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tyre Info'),
          content: SizedBox(
            width: 10000,
            child: SingleChildScrollView(
              child: buildTyreLayout(context, truck.tyres ?? [], truck, true, tyre.id),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
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
