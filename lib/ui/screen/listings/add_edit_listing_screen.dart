import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pets/ui/widget/category_selector.dart';
import 'package:pets/ui/widget/custom_action_button.dart';
import 'package:pets/ui/widget/custom_alert_dialog.dart';
import 'package:pets/ui/widget/custom_button.dart';
import 'package:pets/ui/widget/custom_card.dart';
import 'package:pets/ui/widget/gender_selector.dart';
import 'package:pets/util/custom_file_picker.dart';
import 'package:pets/util/value_validators.dart';

import '../../../blocs/manage_listings/manage_listings_bloc.dart';

class AddEditListingScreen extends StatefulWidget {
  final Map<String, dynamic>? listingDetails;
  final ManageListingsBloc manageListingsBloc;
  const AddEditListingScreen({
    super.key,
    this.listingDetails,
    required this.manageListingsBloc,
  });

  @override
  State<AddEditListingScreen> createState() => _AddEditListingScreenState();
}

class _AddEditListingScreenState extends State<AddEditListingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
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
  int selectedCategoryId = 0;

  @override
  void initState() {
    if (widget.listingDetails != null) {
      _titleController.text = widget.listingDetails!['title'];
      _addressController.text = widget.listingDetails!['address_line'];
      _phoneNumberController.text = widget.listingDetails!['phone'];
      _placeController.text = widget.listingDetails!['place'];
      _districtController.text = widget.listingDetails!['district'];
      _stateController.text = widget.listingDetails!['state'];
      _descriptionController.text = widget.listingDetails!['description'];
      _priceController.text = widget.listingDetails!['price'].toString();
      _discountedPriceController.text =
          widget.listingDetails!['discounted_price'].toString();
      _ageController.text = widget.listingDetails!['age'];
      _pinCodeController.text = widget.listingDetails!['pin_code'].toString();
      _gender = widget.listingDetails!['gender'];
      selectedCategoryId = widget.listingDetails!['category_id'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                if (widget.listingDetails == null)
                  CategoriesSelector(
                    onSelect: (id) {
                      selectedCategoryId = id;
                    },
                    label: 'Select Category',
                  ),
                if (widget.listingDetails == null)
                  const SizedBox(
                    height: 10,
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
                    validator: alphaNumericValidator,
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
                    minLines: 3,
                    maxLines: 5,
                    controller: _descriptionController,
                    validator: alphaNumericValidator,
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
                    validator: alphaNumericValidator,
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
                              validator: numericValidator,
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
                              validator: numericValidator,
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
                    validator: alphaNumericValidator,
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
                              validator: phoneValidator,
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
                            'Place',
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
                              controller: _placeController,
                              validator: alphaNumericValidator,
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
                              validator: alphaNumericValidator,
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
                              validator: alphaNumericValidator,
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
                        validator: numericValidator,
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
                if (widget.listingDetails == null)
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
                if (widget.listingDetails == null)
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
                      if (selectedCategoryId != 0) {
                        if (widget.listingDetails != null) {
                          widget.manageListingsBloc.add(
                            EditListingsEvent(
                              listingId: widget.listingDetails!['id'],
                              title: _titleController.text.trim(),
                              description: _descriptionController.text.trim(),
                              age: _ageController.text.trim(),
                              gender: _gender,
                              address: _addressController.text.trim(),
                              phone: _phoneNumberController.text.trim(),
                              place: _placeController.text.trim(),
                              district: _districtController.text.trim(),
                              state: _stateController.text.trim(),
                              pin: _pinCodeController.text.trim(),
                              price: int.parse(_priceController.text.trim()),
                              discountedPrice: int.parse(
                                  _discountedPriceController.text.trim()),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          if (selectedFile != null) {
                            widget.manageListingsBloc.add(
                              AddListingsEvent(
                                image: selectedFile!,
                                title: _titleController.text.trim(),
                                description: _descriptionController.text.trim(),
                                age: _ageController.text.trim(),
                                gender: _gender,
                                address: _addressController.text.trim(),
                                phone: _phoneNumberController.text.trim(),
                                place: _placeController.text.trim(),
                                district: _districtController.text.trim(),
                                state: _stateController.text.trim(),
                                pin: _pinCodeController.text.trim(),
                                price: int.parse(_priceController.text.trim()),
                                discountedPrice: int.parse(
                                    _discountedPriceController.text.trim()),
                                categoryId: selectedCategoryId,
                              ),
                            );
                            Navigator.pop(context);
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => const CustomAlertDialog(
                                title: 'Select Image',
                                message: 'Please select an image to continue',
                                primaryButtonLabel: 'Ok',
                              ),
                            );
                          }
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => const CustomAlertDialog(
                            title: 'Select Category',
                            message: 'Please select a category to continue',
                            primaryButtonLabel: 'Ok',
                          ),
                        );
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
