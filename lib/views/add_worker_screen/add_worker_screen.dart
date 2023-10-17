import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:nodusteradminapp/common/drawer_widget.dart';
import 'package:nodusteradminapp/common/snackbar.dart';
import 'package:nodusteradminapp/functions/image_picker.dart';
import 'package:nodusteradminapp/functions/worker_auth.dart';
import 'package:nodusteradminapp/model/worker_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:nodusteradminapp/views/order_list_screen/order_list_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class AddWorkerScreen extends StatefulWidget {
  const AddWorkerScreen({Key? key}) : super(key: key);

  @override
  State<AddWorkerScreen> createState() => _AddWorkerScreenState();
}

class _AddWorkerScreenState extends State<AddWorkerScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _usernamecontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _phonenumbercontroller = TextEditingController();
  final _postalcontroller = TextEditingController();

  String imagurl = 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png';
  String selectedValue = 'Cleaning';
  String selectedservice = 'Select Service';
  bool isLoading = false;
  dynamic pdfdoc;

  List<String> washing = [
    'Select Service',
    'Bike or Car Wash',
  ];

  List<String> cleaning = [
    'Select Service',
    'Kitchen Cleaning',
    'Floor Cleaning',
    'Bathroom Cleaning',
    'Sofa Cleaning',
    'Refrigerator Cleaning',
    'Chimney Cleaning',
    'Dining Table Cleaning',
  ];
  List<String> service = [
    'Select Service',
    'Interior Service',
    'Tiles Services',
    'Plumbing Services',
    'Washing Machine Services',
    'Sofa/Chair Services',
    'Geyser Services',
    'Television Services',
    'Painting Services',
    'Water Purifier Services',
    'Fan Services',
    'AC Services',
  ];

  void handleClick() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 10));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropdownItems = selectedValue == 'Washing'
        ? washing
        : selectedValue == 'Cleaning'
            ? cleaning
            : service;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create A Worker Account',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const DrawerWidget(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 75.0,
                    backgroundImage: NetworkImage(imagurl),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.add_circle_outline,
                        size: 30,
                        color: Colors.blue,
                      ),
                      onPressed: () async {
                        setState(() async {
                          final imageurl = await Images.getimage();
                          setState(() {
                            imagurl = imageurl!;
                            log(imageurl.toString());
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextfieldContainer(
                controller: _usernamecontroller,
                leadingIcon: Icons.person,
                hinttext: 'Name',
              ),
              const SizedBox(height: 20),
              TextfieldContainer(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                leadingIcon: Icons.email,
                hinttext: 'Email',
              ),
              const SizedBox(height: 20),
              TextfieldContainer(
                keyboardType: TextInputType.number,
                controller: _phonenumbercontroller,
                leadingIcon: Icons.phone,
                hinttext: 'Phone number',
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                elevation: 2,
                underline: Container(
                  height: 1,
                  color: Colors.black,
                ),
                dropdownColor: Colors.white,
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                    selectedservice = 'Select Service';
                  });
                },
                items: <String>['Cleaning', 'Service', 'Washing']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                elevation: 2,
                underline: Container(
                  height: 1,
                  color: Colors.black,
                ),
                dropdownColor: Colors.white,
                value: selectedservice,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedservice = newValue!;
                  });
                },
                items:
                    dropdownItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextfieldContainer(
                obscureText: true,
                controller: _passwordController,
                leadingIcon: Icons.lock,
                hinttext: 'Password',
              ),
              const SizedBox(height: 20),
              TextfieldContainer(
                obscureText: true,
                controller: _confirmpasswordController,
                leadingIcon: Icons.lock,
                hinttext: 'Confirm Password',
              ),
              const SizedBox(height: 20),
              TextfieldContainer(
                  controller: _addresscontroller,
                  leadingIcon: Icons.location_on,
                  hinttext: 'Full Address'),
              const SizedBox(height: 20),
              TextfieldContainer(
                keyboardType: TextInputType.number,
                controller: _postalcontroller,
                leadingIcon: Icons.quick_contacts_mail_rounded,
                hinttext: 'Postal Code',
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  onPressed: () async {
                    File? file = await pickAadhaarCard(context);
                    if (file != null) {
                      // ignore: use_build_context_synchronously
                      pdfdoc = await uploadPDFToFirebaseStorage(file, context);
                      // ignore: use_build_context_synchronously
                      Utils.showSnackBar(
                          context: context, text: "Upload Completed");
                      log('pdf URL: $pdfdoc');
                    }
                  },
                  child: const Text('Upload Aadhaar Card'),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(150, 40),
                ),
                onPressed: () async {
                  if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty ||
                      _confirmpasswordController.text.isEmpty ||
                      _usernamecontroller.text.isEmpty ||
                      _addresscontroller.text.isEmpty ||
                      _phonenumbercontroller.text.isEmpty ||
                      _postalcontroller.text.isEmpty ||
                      selectedValue == 'Select Service' ||
                      selectedservice == 'Select Service' ||
                      pdfdoc == null) {
                    Utils.showSnackBar(
                        context: context, text: 'Please fill all fields!');
                  } else if (_passwordController.text !=
                      _confirmpasswordController.text) {
                    Utils.showSnackBar(
                        context: context, text: 'Passwords do not match!');
                  } else {
                    WorkerModel worker = WorkerModel(
                        username: _usernamecontroller.text,
                        email: _emailController.text,
                        phonenumber: _phonenumbercontroller.text,
                        specificservice: selectedservice,
                        address: _addresscontroller.text,
                        postalcode: _postalcontroller.text,
                        mainservice: selectedValue,
                        pdf: pdfdoc,
                        datetime: DateTime.now().toString(),
                        image: imagurl,
                        isAvailable: true,
                        password: _passwordController.text);
                    await WorkerAuth.signUp(
                            workerModel: worker, context: context)
                        .then((value) {
                      handleClick();
                      Get.offAll(const OrderListScreen());
                    });
                  }
                },
                child: isLoading
                    ? const SpinKitThreeBounce(
                        color: Colors.white,
                        size: 20,
                      )
                    : const Text(
                        'Add Worker',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> uploadPDFToFirebaseStorage(
      File file, BuildContext context) async {
    try {
      String fileName = path.basename(file.path);
      firebase_storage.Reference reference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('pdf/$fileName');
      firebase_storage.UploadTask uploadTask = reference.putFile(file);
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      log('Error uploading PDF: $e');
      Utils.showSnackBar(
          context: context, text: 'Error uploading PDF. Please try again.');
      return null;
    }
  }
}

class TextfieldContainer extends StatelessWidget {
  final TextEditingController controller;
  final IconData leadingIcon;
  final String hinttext;
  final bool obscureText;
  final TextInputType keyboardType;

  const TextfieldContainer({
    Key? key,
    required this.controller,
    required this.leadingIcon,
    required this.hinttext,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(leadingIcon),
          hintText: hinttext,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

Future<File?> pickAadhaarCard(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
  );
  if (result != null) {
    File file = File(result.files.single.path!);
    return file;
  } else {
    // ignore: use_build_context_synchronously
    Utils.showSnackBar(context: context, text: 'No file selected!');
    return null;
  }
}
