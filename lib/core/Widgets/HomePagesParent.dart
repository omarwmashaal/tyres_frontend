import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tyres_frontend/core/Widgets/globalAuthBloc.dart';
import 'package:tyres_frontend/core/remoteConstats.dart';
import 'package:tyres_frontend/core/service_Injector.dart';
import 'package:tyres_frontend/core/sharedPreferencesDatasource.dart';
import 'package:tyres_frontend/features/Authentication/presenation/blocs/authentication_blocStates.dart';
import 'package:tyres_frontend/features/Authentication/presenation/pages/loginPage.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_bloc.dart';
import 'package:tyres_frontend/features/Trucks/presenation/pages/TruckSearchPage.dart';
import 'package:tyres_frontend/features/Trucks/presenation/widgets/addTruckWidget.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_bloc.dart';
import 'package:tyres_frontend/features/Tyres/presenation/pages/TyreSearchPage.dart';
import 'package:tyres_frontend/features/Tyres/presenation/pages/addTyreWidget.dart';

class Homepagesparent extends StatefulWidget {
  Homepagesparent({super.key});

  @override
  State<Homepagesparent> createState() => _HomepagesparentState();
}

class _HomepagesparentState extends State<Homepagesparent> {
  var navBarIndex = 0.obs;
  late TyreBloc tyreBloc;
  late TruckBloc truckBloc;

  @override
  void initState() {
    tyreBloc = BlocProvider.of<TyreBloc>(context);
    truckBloc = BlocProvider.of<TruckBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          navBarIndex == 0 ? "Search Trucks" : "Search Tyres",
          style: TextStyle(fontSize: 18.sp), // Responsive text size for app bar title
        ),
      ),
      body: BlocListener<Globalauthbloc, AuthenticationState>(
        bloc: globalauthbloc,
        listener: (context, state) {
          if (state is AuthenticationUnAuthorizedState) {
            si<Sharedpreferencesdatasource>().setValue("token", "");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please Login!")),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
              (route) => false,
            );
          }
        },
        child: navBarIndex == 0
            ? TruckSearchPage(
                truckBloc: truckBloc,
              )
            : TyreSearchPage(
                tyreBloc: tyreBloc,
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navBarIndex.value,
        onTap: (value) {
          setState(() {
            navBarIndex.value = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fire_truck),
            label: "Trucks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: "Tyres",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (navBarIndex == 0)
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
          else {
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
          }
        },
        child: Icon(Icons.add, size: 24.sp), // Responsive icon size
      ),
    );
  }
}
