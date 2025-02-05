import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:tyres_frontend/core/Widgets/CustomTextFormField.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/GetTyreBySerialUseCase.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_bloc.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_blocEvents.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_blocStates.dart';
import 'package:tyres_frontend/features/Tyres/presenation/pages/addTyreWidget.dart';

class TyreSearchPage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  TyreSearchPage({
    Key? key,
    required this.tyreBloc,
  }) : super(key: key);
  TyreBloc tyreBloc;
  @override
  Widget build(BuildContext context) {
    // Access the TyreBloc directly using BlocProvider
    tyreBloc.add(GetTyreBySerialEvent(serial: ""));

    return Padding(
      padding: EdgeInsets.all(16.w), // Responsive padding
      child: Column(
        children: [
          // Search bar for searching tyres by plate number
          CustomTextFormField(
            controller: searchController,
            labelText: 'Search by Serial Number',
            onChanged: (value) {
              // Dispatch the search event whenever the user types in the search bar
              tyreBloc.add(GetTyreBySerialEvent(serial: searchController.text));
            },
          ),
          SizedBox(height: 16.h), // Responsive spacing

          // Display tyre list based on the current bloc state
          Expanded(
              child: BlocConsumer<TyreBloc, TyreState>(
            builder: (context, state) {
              if (state is TyreLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TyresLoadedState) {
                if (state.tyres.length == 0) {
                  return Center(
                    child: Text(
                      'No tyres found.',
                      style: TextStyle(fontSize: 16.sp), // Responsive text
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: state.tyres.length,
                  itemBuilder: (context, index) {
                    final TyreEntity tyre = state.tyres[index];

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h), // Responsive vertical padding between list items
                      child: ListTile(
                        title: Text(
                          'Serial: ${tyre.serial ?? "N/A"}',
                          style: TextStyle(fontSize: 16.sp), // Responsive text size for plate number
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Model: ${tyre.model ?? 0}',
                              style: TextStyle(fontSize: 14.sp), // Responsive text size for mileage
                            ),
                            Text(
                              'Total: ${tyre.totalMileage ?? 0} Km',
                              style: TextStyle(fontSize: 14.sp), // Responsive text size for mileage
                            ),
                            Text(
                              'Plat No: ${tyre.currentTruckPlateNo ?? "Not Installed"}',
                              style: TextStyle(fontSize: 14.sp), // Responsive text size for mileage
                            ),
                          ],
                        ),
                        onTap: () {
                          // Navigate to tyre details or edit page
                          // context.go('/tyre-details/${tyre.id}');
                        },
                      ),
                    );
                  },
                );
              } else if (state is TyreErrorState) {
                return Center(
                  child: Text(
                    'Error: ${state.message}',
                    style: TextStyle(fontSize: 16.sp), // Responsive text size for error message
                  ),
                );
              }

              // Default state when no interaction or data is available
              return Center(
                child: Text(
                  'Start searching for tyres.',
                  style: TextStyle(fontSize: 16.sp), // Responsive text size for default message
                ),
              );
            },
            listener: (context, state) => {if (state is TyreAddedState) tyreBloc.add(GetTyreBySerialEvent(serial: ""))},
          )),
        ],
      ),
    );
  }
}
