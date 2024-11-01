import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tyres_frontend/core/Widgets/CustomTextFormField.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_bloc.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_blocEvents.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_blocStates.dart';
import 'package:tyres_frontend/features/Tyres/presenation/pages/addTyreWidget.dart';

class TyreSearchPage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Access the TyreBloc directly using BlocProvider
    final tyreBloc = BlocProvider.of<TyreBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Tyres',
          style: TextStyle(fontSize: 18.sp), // Responsive text size for app bar title
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w), // Responsive padding
        child: Column(
          children: [
            // Search bar for searching tyres by plate number
            CustomTextFormField(
              controller: searchController,
              labelText: 'Search by Plate Number',
              onChanged: (value) {
                // Dispatch the search event whenever the user types in the search bar
                tyreBloc.add(GetTyreBySerialEvent(serial: searchController.text));
              },
            ),
            SizedBox(height: 16.h), // Responsive spacing

            // Display tyre list based on the current bloc state
            Expanded(
              child: BlocBuilder<TyreBloc, TyreState>(
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
                              'Plate No: ${tyre.serial ?? "N/A"}',
                              style: TextStyle(fontSize: 16.sp), // Responsive text size for plate number
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  'Model: ${tyre.model ?? 0}',
                                  style: TextStyle(fontSize: 14.sp), // Responsive text size for mileage
                                ),
                                Text(
                                  'Start Mileage: ${tyre.startMileage ?? 0}',
                                  style: TextStyle(fontSize: 14.sp), // Responsive text size for mileage
                                ),
                                Text(
                                  'Current Mileage: ${tyre.endMileage ?? 0}',
                                  style: TextStyle(fontSize: 14.sp), // Responsive text size for mileage
                                ),
                              ],
                            ),
                            onTap: () {
                              // Navigate to tyre details or edit page
                              context.go('/tyre-details/${tyre.id}');
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
              ),
            ),
          ],
        ),
      ),
      // Single floating action button for adding a new tyre
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show modal bottom sheet for adding a new tyre
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
                child: AddTyreForm(tyreBloc: tyreBloc),
              );
            },
          );
        },
        child: Icon(Icons.add, size: 24.sp), // Responsive icon size
      ),
    );
  }
}
