import 'package:flutter/material.dart';

class SelectCityDialog extends StatefulWidget {
  final TextEditingController cityNameController;
  final VoidCallback voidCallback;

  const SelectCityDialog({
    Key? key,
    required this.cityNameController,
    required this.voidCallback,
  }) : super(key: key);

  @override
  State<SelectCityDialog> createState() => _SelectCityDialogState();
}

class _SelectCityDialogState extends State<SelectCityDialog> {
  List<String> cityList = [
    'Anuradhapura',
    'Colombo',
    'Jaffna',
    'Kandy',
    'Galle',
    'Anuradhapura',
    'Mannar',
    'Chavakachcheri',
    'Anuradhapura',
    'Vavuniya',
    'Sri Jayewardenepura Kotte',
    'Dehiwela-Mount Lavinia',
    'Nuwara Eliya',
    'Polonnaruwa',
    'Point Pedro',
    'Valvettithurai',
    'Kurunegala',
    'Ratnapura',
    'Badulla',
    'Bandarawela',
    'Happutalle',
    'Trincomalee',
    'Kinniya',
    'Anuradhapura',
    'Batticaloa',
    'Eravur',
    'Kattankudy',
    'Ampara',
    'Kalmunai',
    'Akkaraipattu',
    'Embilipitiya',
    'Anuradhapura',
    'Kegalle',
    'Balangoda',
    'Anuradhapura',
    'Matale',
    'Dambulla',
    'Kalutata',
    'Matara',
    'Hambantota',
    'Chilaw',
    'Kuliyapitiya',
    'Gampaha',
    'Negombo',
    'Homagama',
  ];

  @override
  void initState() {
    cityList.sort();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Select a City',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: cityList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                widget.cityNameController.text = cityList[index];
                widget.voidCallback;
                Navigator.of(context).pop();

              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(cityList[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
