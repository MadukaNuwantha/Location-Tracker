import 'package:flutter/material.dart';
import 'package:geofencing/Services/location_services.dart';
import 'package:geofencing/Widgets/custom_click_text_field.dart';
import 'package:geofencing/Widgets/custom_elevated_button.dart';
import 'package:geofencing/Widgets/select_city_dialog.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Consumer<LocationServices>(
            builder: (context, locationServices, child) {
              locationServices.requestLocationPermission(context);
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Location Tracker',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        'Location Coordinates',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Longitude : ${locationServices.currentLocation?.longitude ?? 'Unknown'}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Latitude : ${locationServices.currentLocation?.latitude ?? 'Unknown'}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Location Address',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'City : ${locationServices.placeMark?.locality ?? 'Unknown'}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Country : ${locationServices.placeMark?.country ?? 'Unknown'}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Location Status',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        cityController.text.isNotEmpty
                            ? locationServices.placeMark?.locality.toString() == cityController.text
                                ? 'Inside Boundary'
                                : 'Outside Boundary'
                            : 'Select boundary city',
                        style: TextStyle(
                          fontSize: 20,
                          color: cityController.text.isNotEmpty
                              ? locationServices.placeMark?.locality.toString() ==
                                      cityController.text
                                  ? Colors.blue
                                  : Colors.red
                              : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 50),
                      CustomClickTextField(
                        hintText: 'Boundary City',
                        controller: cityController,
                        voidCallback: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SelectCityDialog(
                                cityNameController: cityController,
                                voidCallback: () {
                                  setState(() {});
                                },
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              text: 'Get Location',
                              onPressed: () {
                                locationServices.listenCurrentLocation(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
