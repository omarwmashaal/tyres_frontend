import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_bloc.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_blocEvents.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';

class EditTruckForm extends StatefulWidget {
  final TruckEntity truck;
  final TruckBloc truckBloc;

  const EditTruckForm({
    Key? key,
    required this.truck,
    required this.truckBloc,
  }) : super(key: key);

  @override
  _EditTruckFormState createState() => _EditTruckFormState();
}

class _EditTruckFormState extends State<EditTruckForm> {
  late TextEditingController plateNoController;
  late TextEditingController mileageController;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the truck's current details
    plateNoController = TextEditingController(text: widget.truck.platNo);
    mileageController = TextEditingController(text: widget.truck.currentMileage?.toString() ?? '');
  }

  @override
  void dispose() {
    // Dispose of the controllers when the form is destroyed
    plateNoController.dispose();
    mileageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Makes the modal adjust dynamically
      children: [
        // Plate Number Field
        TextField(
          controller: plateNoController,
          decoration: InputDecoration(
            labelText: 'Plate Number',
          ),
        ),
        SizedBox(height: 16.h), // Responsive spacing

        // Mileage Field
        TextField(
          controller: mileageController,
          decoration: InputDecoration(
            labelText: 'Current Mileage',
          ),
          keyboardType: TextInputType.number, // Ensure numeric input for mileage
        ),
        SizedBox(height: 16.h), // Responsive spacing

        // Update Button
        ElevatedButton(
          onPressed: () {
            // Dispatch the UpdateTruckEvent to the TruckBloc
            widget.truckBloc.add(
              UpdateTruckEvent(
                updatedTruck: TruckEntity(
                  id: widget.truck.id, // Keep the same truck ID
                  platNo: plateNoController.text,
                  currentMileage: int.tryParse(mileageController.text),
                ),
              ),
            );

            // Close the modal after updating
            Navigator.pop(context);
          },
          child: Text('Update Truck', style: TextStyle(fontSize: 16.sp)), // Responsive text size
        ),
      ],
    );
  }
}
