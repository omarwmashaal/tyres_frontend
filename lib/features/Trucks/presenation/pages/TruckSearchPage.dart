import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tyres_frontend/core/Widgets/CustomTextFormField.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_bloc.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_blocEvents.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_blocStates.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';
import 'package:tyres_frontend/features/Trucks/presenation/widgets/addTruckWidget.dart';

class TruckSearchPage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Access the TruckBloc directly using BlocProvider
    final truckBloc = BlocProvider.of<TruckBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Trucks',
          style: TextStyle(fontSize: 18.sp), // Responsive text size for app bar title
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w), // Responsive padding
        child: Column(
          children: [
            // Search bar for searching trucks by plate number
            CustomTextFormField(
              controller: searchController,
              labelText: 'Search by Plate Number',
              onChanged: (value) {
                // Dispatch the search event whenever the user types in the search bar
                truckBloc.add(SearchTrucksEvent(searchTerm: value));
              },
            ),
            SizedBox(height: 16.h), // Responsive spacing

            // Display truck list based on the current bloc state
            Expanded(
              child: BlocBuilder<TruckBloc, TruckState>(
                builder: (context, state) {
                  if (state is TruckLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TrucksSearchedState) {
                    if (state.trucks.isEmpty) {
                      return Center(
                        child: Text(
                          'No trucks found.',
                          style: TextStyle(fontSize: 16.sp), // Responsive text
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: state.trucks.length,
                      itemBuilder: (context, index) {
                        final TruckEntity truck = state.trucks[index];

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h), // Responsive vertical padding between list items
                          child: ListTile(
                            title: Text(
                              'Plate No: ${truck.platNo ?? "N/A"}',
                              style: TextStyle(fontSize: 16.sp), // Responsive text size for plate number
                            ),
                            subtitle: Text(
                              'Mileage: ${truck.currentMileage ?? 0} km',
                              style: TextStyle(fontSize: 14.sp), // Responsive text size for mileage
                            ),
                            onTap: () {
                              // Navigate to truck details or edit page
                              context.go('/truck-details/${truck.id}');
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is TruckErrorState) {
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
                      'Start searching for trucks.',
                      style: TextStyle(fontSize: 16.sp), // Responsive text size for default message
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Single floating action button for adding a new truck
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show modal bottom sheet for adding a new truck
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
                child: AddTruckForm(truckBloc: truckBloc),
              );
            },
          );
        },
        child: Icon(Icons.add, size: 24.sp), // Responsive icon size
      ),
    );
  }
}
