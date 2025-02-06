import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tyres_frontend/core/Widgets/CustomTextFormField.dart';
import 'package:tyres_frontend/core/Widgets/TitleText.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyrePositionEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/InstallTyreToATruckUseCase.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_bloc.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_blocEvents.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_blocStates.dart';

class InstallTyreForm extends StatefulWidget {
  final TruckEntity truck;
  final TyrePositionEntity position;
  final TyreBloc tyreBloc;
  const InstallTyreForm({
    Key? key,
    required this.truck,
    required this.position,
    required this.tyreBloc,
  }) : super(key: key);

  @override
  _InstallTyreFormState createState() => _InstallTyreFormState();
}

class _InstallTyreFormState extends State<InstallTyreForm> {
  final TextEditingController serialNoController = TextEditingController();
  final TextEditingController startMileageController = TextEditingController();
  final TextEditingController modelController = TextEditingController();

  RxString dtoNumber = "".obs;
  bool newTyre = false;
  int nextId = 0;
  String finalNewSerialNumber = "";

  @override
  Widget build(BuildContext context) {
    widget.tyreBloc.add(GetNextTyreIdEvent());
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensures the modal adjusts dynamically
      children: [
        TitleText(
            title: "Install Tyre to Truck\n PlatNo ${widget.truck.platNo}"),
        SizedBox(height: 16.h), // Responsive spacing

        SizedBox(
          height: 300.h,
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  'Row',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold), // Responsive text
                ),
                subtitle: Text(
                  (widget.position?.index ?? 0).toString(),
                  style: TextStyle(fontSize: 14.sp), // Responsive text
                ),
              ),
              Divider(),

              // Current Mileage
              ListTile(
                title: Text(
                  'Side',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold), // Responsive text
                ),
                subtitle: Text(
                  widget.position.side.name,
                  style: TextStyle(fontSize: 14.sp), // Responsive text
                ),
              ),
              Divider(),

              // Tyre IDs
              ListTile(
                title: Text(
                  'Direction',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold), // Responsive text
                ),
                subtitle: Text(
                  widget.position.direction.name,
                  style: TextStyle(fontSize: 14.sp), // Responsive text
                ),
              ),
              Divider(),
            ],
          ),
        ),

        Row(
          children: [
            Checkbox(
              value: newTyre,
              onChanged: (value) => setState(() {
                newTyre = value ?? false;
                if (newTyre) {
                  dtoNumber.value = serialNoController.text;
                } else {
                  serialNoController.text = dtoNumber.value;
                }
              }),
              tristate: false,
            ),
            Text("New Tyre"),
          ],
        ),
        SizedBox(height: 16.h), // Responsive spacing

        newTyre
            ? BlocBuilder<TyreBloc, TyreState>(
                buildWhen: (previous, current) =>
                    current is LoadingNextTyreIdState ||
                    current is LoadingNextTyreIdErrorState ||
                    current is LoadedNextTyreIdState,
                builder: (context, state) {
                  if (state is LoadingNextTyreIdState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is LoadingNextTyreIdErrorState) {
                    return Center(child: Text("Error loading next tyre id"));
                  } else if (state is LoadedNextTyreIdState) {
                    nextId = state.nextId;
                    return Row(
                      children: [
                        // Tyre Mileage Field
                        Expanded(
                          child: CustomTextFormField(
                            controller: serialNoController,
                            labelText: 'DTO',
                            onChanged: (p0) => dtoNumber.value = p0,
                            // Assume mileage is entered as a string and then parsed to an integer
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () {
                              finalNewSerialNumber =
                                  dtoNumber + " - " + nextId.toString();
                              return Text(
                                  "Serial Number: ${dtoNumber.value + " - " + nextId.toString()}");
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              )
            : CustomTextFormField(
                controller: serialNoController,
                labelText: 'Serial Number',
              ),

        SizedBox(height: 16.h), // Responsive spacing

        CustomTextFormField(
          controller: modelController,
          labelText: 'Model',
        ),
        SizedBox(height: 16.h), // Responsive spacing

        ElevatedButton(
          onPressed: () {
            var serial =
                newTyre ? finalNewSerialNumber : serialNoController.text;
            widget.tyreBloc.add(
              InstallTyreOnTruckEvent(
                tyre: TyreEntity(
                  serial: serial,
                  model: modelController.text,
                  position: widget.position,
                  truckId: widget.truck.id,
                ),
                newTyre: newTyre,
              ),
            );

            // Close the modal after submission
            Navigator.pop(context);
          },
          child: Text('Install Tyre',
              style: TextStyle(fontSize: 16.sp)), // Responsive text size
        ),
      ],
    );
  }
}
