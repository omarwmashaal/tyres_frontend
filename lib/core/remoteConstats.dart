import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

//const _host = "http://localhost:5000/";
//const _host = "http://18.233.224.72/api/";
//var _host = "http://localhost/api/";
var _host = "http://165.22.31.49:5000";

var t = File("host.txt").readAsStringSync();
setHosts() async {}

final serverHost = "${_host}";
final signalRHost = "${_host}notificationhub";
var token = "";

/***********************************
 * Controllers
 ***********************************/

/*****************
 * Authentication
 *****************/
const authenticationController = "Authentication";
const patientInfoController = "PatientInfo";
const notificationController = "Notifications";
const medicalController = "Medical";
const userController = "User";
const settingsController = "Settings";
const stockController = "Stock";
const imageController = "Image";
const cashFlowController = "CashFlow";
const labRequestsController = "LAB_Requests";
const labCustomerController = "Lab_Customers";
const clinicTreatmentController = "ClinicTreatments";
