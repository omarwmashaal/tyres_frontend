import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tyres_frontend/core/Widgets/CustomTextFormField.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_bloc.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_blocEvents.dart';

class AddTyreForm extends StatefulWidget {
  final TyreBloc tyreBloc;

  const AddTyreForm({Key? key, required this.tyreBloc}) : super(key: key);

  @override
  _AddTyreFormState createState() => _AddTyreFormState();
}

class _AddTyreFormState extends State<AddTyreForm> {
  final TextEditingController modelController = TextEditingController();
  final TextEditingController serialController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensures the modal adjusts dynamically
      children: [
        // Tyre Plate Number Field
        CustomTextFormField(
          controller: modelController,
          labelText: 'Model',
        ),
        SizedBox(height: 16.h), // Responsive spacing

        // Tyre Mileage Field
        CustomTextFormField(
          controller: serialController,
          labelText: 'Serial',
          // Assume mileage is entered as a string and then parsed to an integer
        ),
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
                  serial: serialController.text,
                  // ID will be auto-generated
                ),
              ),
            );

            // Close the modal after submission
            Navigator.pop(context);
          },
          child: Text('Add Tyre', style: TextStyle(fontSize: 16.sp)), // Responsive text size
        ),
      ],
    );
  }
}
