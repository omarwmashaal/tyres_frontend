import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tyres_frontend/core/Widgets/CustomTextFormField.dart';
import 'package:tyres_frontend/core/Widgets/TitleText.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyrePositionEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/InstallTyreToATruckUseCase.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_bloc.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_blocEvents.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensures the modal adjusts dynamically
      children: [
        TitleText(title: "Install Tyre to Truck\n PlatNo ${widget.truck.platNo}"),
        SizedBox(height: 16.h), // Responsive spacing

        SizedBox(
          height: 300.h,
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  'Row',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold), // Responsive text
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
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold), // Responsive text
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
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold), // Responsive text
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
        CustomTextFormField(
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
            widget.tyreBloc.add(InstallTyreOnTruckEvent(
                params: TyreEntity(
              serial: serialNoController.text,
              model: modelController.text,
              position: widget.position,
              truckId: widget.truck.id,
            )));

            // Close the modal after submission
            Navigator.pop(context);
          },
          child: Text('Install Tyre', style: TextStyle(fontSize: 16.sp)), // Responsive text size
        ),
      ],
    );
  }
}
