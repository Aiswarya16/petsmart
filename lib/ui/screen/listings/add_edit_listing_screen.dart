import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pets/ui/widget/custom_action_button.dart';
import 'package:pets/ui/widget/custom_button.dart';
import 'package:pets/ui/widget/custom_card.dart';
import 'package:pets/ui/widget/gender_selector.dart';
import 'package:pets/util/custom_file_picker.dart';

class AddEditListingScreen extends StatefulWidget {
  final Map<String, dynamic>? listingDetails;
  const AddEditListingScreen({
    super.key,
    this.listingDetails,
  });

  @override
  State<AddEditListingScreen> createState() => _AddEditListingScreenState();
}

class _AddEditListingScreenState extends State<AddEditListingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _discountedPriceController =
      TextEditingController();

  String _gender = 'male';
  PlatformFile? selectedFile;

  @override
  void initState() {
    if (widget.listingDetails != null) {
      _titleController.text = widget.listingDetails!['title'];
      _addressController.text = widget.listingDetails!['address'];
      _phoneNumberController.text = widget.listingDetails!['phone'];
      _cityController.text = widget.listingDetails!['city'];
      _districtController.text = widget.listingDetails!['district'];
      _stateController.text = widget.listingDetails!['state'];
      _descriptionController.text = widget.listingDetails!['description'];
      _priceController.text = widget.listingDetails!['price'].toString();
      _discountedPriceController.text =
          widget.listingDetails!['discounted_price'].toString();
      _ageController.text = widget.listingDetails!['age'];
      _pinCodeController.text = widget.listingDetails!['pin'].toString();
      _gender = widget.listingDetails!['gender'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.pink,
          ),
        ),
        title: Text(
          widget.listingDetails != null ? 'Edit Listing' : 'Add Listing',
          style: GoogleFonts.piazzolla(
            textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Title',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Please enter title';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'eg.Dog for sale',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    maxLines: 2,
                    controller: _descriptionController,
                    validator: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Please enter description';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'eg.Decription of the pet',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Age',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    controller: _ageController,
                    validator: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Please enter age';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'eg.6 months',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Gender',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                GenderSelector(
                  selected: _gender,
                  onSelect: (gender) {
                    _gender = gender;
                  },
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          CustomCard(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _priceController,
                              validator: (value) {
                                if (value != null && value.trim().isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Please enter price';
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Price in rupees',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Discounted Price',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          CustomCard(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _discountedPriceController,
                              validator: (value) {
                                if ((value != null &&
                                        value.trim().isNotEmpty) ||
                                    widget.listingDetails != null) {
                                  return null;
                                } else {
                                  return 'Please enter discounted price';
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Price in rupees',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Address',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    maxLines: 2,
                    controller: _addressController,
                    validator: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Please enter address';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'address line 1, address line 2',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone Number',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          CustomCard(
                            child: TextFormField(
                              controller: _phoneNumberController,
                              validator: (value) {
                                if (value != null && value.trim().isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Please enter Phone';
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'eg. 9876543210',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'City',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          CustomCard(
                            child: TextFormField(
                              controller: _cityController,
                              validator: (value) {
                                if ((value != null &&
                                        value.trim().isNotEmpty) ||
                                    widget.listingDetails != null) {
                                  return null;
                                } else {
                                  return 'Please enter your city';
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Kannur',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'District',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          CustomCard(
                            child: TextFormField(
                              controller: _districtController,
                              validator: (value) {
                                if (value != null && value.trim().isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Please enter your district';
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Kannur',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'State',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          CustomCard(
                            child: TextFormField(
                              controller: _stateController,
                              validator: (value) {
                                if ((value != null &&
                                        value.trim().isNotEmpty) ||
                                    widget.listingDetails != null) {
                                  return null;
                                } else {
                                  return 'Please enter your state';
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Kerala',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pin Code',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 5),
                    CustomCard(
                      child: TextFormField(
                        controller: _pinCodeController,
                        validator: (value) {
                          if ((value != null && value.trim().isNotEmpty) ||
                              widget.listingDetails != null) {
                            return null;
                          } else {
                            return 'Please enter pin code';
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'eg.123456',
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                CustomActionButton(
                  iconData: selectedFile != null
                      ? Icons.check_box_outlined
                      : Icons.upload_outlined,
                  color:
                      selectedFile != null ? Colors.green : Colors.grey[400]!,
                  onPressed: () async {
                    PlatformFile? file = await pickFile();
                    if (file != null) {
                      selectedFile = file;
                      setState(() {});
                    }
                  },
                  label: selectedFile != null ? 'Selected' : 'Upload Image',
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                CustomActionButton(
                  iconData: Icons.map_outlined,
                  color: Colors.purple[200]!,
                  onPressed: () {},
                  label: 'Select Location from Map',
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                CustomButton(
                  buttonColor: Colors.pink,
                  labelColor: Colors.white,
                  label: widget.listingDetails != null ? 'Save' : 'Add',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.listingDetails != null) {
                        // BlocProvider.of<PatientBloc>(context).add(
                        //   EditPatientEvent(
                        //     patientId: widget.patientDetails!['id'],
                        //     name: _nameController.text.trim(),
                        //     phone: _phoneNumberController.text.trim(),
                        //     address: _addressController.text.trim(),
                        //     city: _cityController.text.trim(),
                        //     district: _districtController.text.trim(),
                        //     dob: _dob!,
                        //     gender: _gender,
                        //     state: _stateController.text.trim(),
                        //   ),
                        // );
                      } else {
                        // BlocProvider.of<PatientBloc>(context).add(
                        //   AddPatientEvent(
                        //     name: _nameController.text.trim(),
                        //     phone: _phoneNumberController.text.trim(),
                        //     address: _addressController.text.trim(),
                        //     city: _cityController.text.trim(),
                        //     district: _districtController.text.trim(),
                        //     dob: _dob!,
                        //     gender: _gender,
                        //     state: _stateController.text.trim(),
                        //   ),
                        // );
                      }

                      Navigator.pop(context);
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
