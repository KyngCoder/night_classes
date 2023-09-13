import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:registration_form/test.dart';
import 'package:registration_form/utils.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController DOBController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    genderController.dispose();
    passwordController.dispose();
    DOBController.dispose();
  }

  final formKey = GlobalKey<FormState>();

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      setState(() {
        DOBController.text =
            formattedDate; //set output date to TextField value.
      });
    } else {}
  }

  void submitData() {
    if (formKey.currentState!.validate()) {
      showAdaptiveDialog(
          context: context,
          builder: (context) {
            return AlertDialog.adaptive(
              title: Text("User Information"),
              content: Column(children: [
                Row(
                  children: [
                    Text("First Name: "),
                    Text(firstNameController.text)
                  ],
                )
              ]),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Okay"))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Registraion Screen")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                        labelText: "First Name", border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                        labelText: "Last Name", border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: genderController,
                    decoration: InputDecoration(
                        labelText: "Gender", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value != null && value.length < 2) {
                        return "Please enter a value greater than 4";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: "Password", border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    onTap: _pickDate,
                    controller: DOBController,
                    decoration: InputDecoration(
                        labelText: "DOB", border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(onPressed: submitData, child: Text("Submit"))
                ],
              )),
        ));
  }
}
