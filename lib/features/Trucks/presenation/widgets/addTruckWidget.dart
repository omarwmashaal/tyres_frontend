import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tyres_frontend/core/Widgets/CustomTextFormField.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_bloc.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_blocEvents.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';

class AddTruckForm extends StatefulWidget {
  final TruckBloc truckBloc;

  const AddTruckForm({Key? key, required this.truckBloc}) : super(key: key);

  @override
  _AddTruckFormState createState() => _AddTruckFormState();
}

class _AddTruckFormState extends State<AddTruckForm> {
  final TextEditingController plateNoController = TextEditingController();
  final TextEditingController mileageController = TextEditingController();
  final TextEditingController tyreIdsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensures the modal adjusts dynamically
      children: [
        // Truck Plate Number Field
        CustomTextFormField(
          controller: plateNoController,
          labelText: 'Plate Number',
        ),
        SizedBox(height: 16.h), // Responsive spacing

        // Truck Mileage Field
        CustomTextFormField(
          controller: mileageController,
          labelText: 'Current Mileage',
          // Assume mileage is entered as a string and then parsed to an integer
        ),
        SizedBox(height: 16.h), // Responsive spacing

        // Responsive spacing

        // Submit Button
        ElevatedButton(
          onPressed: () {
            // Dispatch the AddTruckEvent
            widget.truckBloc.add(
              AddTruckEvent(
                truck: TruckEntity(
                  id: null, // ID will be auto-generated
                  platNo: plateNoController.text,
                  currentMileage: int.tryParse(mileageController.text),
                ),
              ),
            );

            // Close the modal after submission
            Navigator.pop(context);
          },
          child: Text('Add Truck', style: TextStyle(fontSize: 16.sp)), // Responsive text size
        ),
      ],
    );
  }
}
