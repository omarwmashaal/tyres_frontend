import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tyres_frontend/core/Widgets/CustomTextFormField.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_bloc.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_blocEvents.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_blocStates.dart';

class AddTyreForm extends StatefulWidget {
  final TyreBloc tyreBloc;

  const AddTyreForm({Key? key, required this.tyreBloc}) : super(key: key);

  @override
  _AddTyreFormState createState() => _AddTyreFormState();
}

class _AddTyreFormState extends State<AddTyreForm> {
  final TextEditingController modelController = TextEditingController();
  final TextEditingController serialController = TextEditingController();

  RxString dtoNumber = "".obs;
  int nextId = 0;
  String finalNewSerialNumber = "";

  @override
  Widget build(BuildContext context) {
    widget.tyreBloc.add(GetNextTyreIdEvent());
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensures the modal adjusts dynamically
      children: [
        // Tyre Plate Number Field
        CustomTextFormField(
          controller: modelController,
          labelText: 'Model',
        ),
        SizedBox(height: 16.h), // Responsive spacing

        BlocBuilder<TyreBloc, TyreState>(
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
                        controller: serialController,
                        labelText: 'DTO',
                        onChanged: (p0) => dtoNumber.value = p0,
                        // Assume mileage is entered as a string and then parsed to an integer
                      ),
                    ),
                    Expanded(child: Obx(() {
                      finalNewSerialNumber =
                          dtoNumber + " - " + nextId.toString();
                      return Text(
                          "Serial Number: ${dtoNumber.value + " - " + nextId.toString()}");
                    })),
                  ],
                );
              }
              return Container();
            }),

        SizedBox(height: 16.h), // Responsive spacing

        // Responsive spacing

        // Submit Button
        ElevatedButton(
          onPressed: () {
            // Dispatch the AddTyreEvent
            widget.tyreBloc.add(
              AddTyreEvent(
                tyre: TyreEntity(
                  id: null,
                  model: modelController.text,
                  serial: finalNewSerialNumber,
                  // ID will be auto-generated
                ),
              ),
            );

            // Close the modal after submission
            Navigator.pop(context);
          },
          child: Text('Add Tyre',
              style: TextStyle(fontSize: 16.sp)), // Responsive text size
        ),
      ],
    );
  }
}
