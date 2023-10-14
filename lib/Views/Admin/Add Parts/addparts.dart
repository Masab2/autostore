// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/res/components/AddProductsComponents/bottomsheetContainer.dart';
import 'package:autostore/res/components/AddProductsComponents/partsdetail.dart';
import 'package:autostore/res/components/AddProductsComponents/pickImagewidget.dart';
import 'package:autostore/res/components/BackRow/backRow.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Utility/Colors/AppColor.dart';
import '../../../ViewModel/Admin/addPartsController/addpartsViewModel.dart';

class AddParts extends StatefulWidget {
  const AddParts({super.key});

  @override
  State<AddParts> createState() => _AddPartsState();
}

class _AddPartsState extends State<AddParts> {
  final addpartController = Get.put(AddPartsViewModel());
  final titlecontroller = TextEditingController();
  final categorycontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  final descripcontroller = TextEditingController();
  final quancontroller = TextEditingController();
  @override
  void dispose() {
    //implement dispose
    super.dispose();
    addpartController.dispose();
    titlecontroller.dispose();
    categorycontroller.dispose();
    pricecontroller.dispose();
    descripcontroller.dispose();
    quancontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            0.05.ph,
            BackGroundRow(
              page: RoutesNames.publishedPartsScreen,
              title: 'Sell Auto Parts',
            ),
            0.04.ph,
            Obx(
              () => addpartController.imagePath.isEmpty
                  ? PickImageWidget(
                      ontap: () {
                        Get.bottomSheet(BottomSheetContainer(
                          ongallery: () {
                            addpartController
                                .getImageFromgallery(ImageSource.gallery);
                          },
                          oncamera: () {
                            addpartController
                                .getImageFromgallery(ImageSource.camera);
                          },
                        ));
                      },
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                          height: Get.height * 0.20,
                          width: Get.width * 0.40,
                          fit: BoxFit.cover,
                          image: FileImage(
                              File(addpartController.imagePath.toString()))),
                    ),
            ),
            0.03.ph,
            Column(
              children: [
                PartsDetail(
                  title: 'Title',
                  icon: FontAwesomeIcons.clapperboard,
                  controller: titlecontroller,
                  hint: 'Title',
                ),
                PartsDetail(
                  title: 'Category',
                  icon: Icons.category,
                  controller: categorycontroller,
                  hint: 'Rims,brakePads,etc',
                ),
                PartsDetail(
                  title: 'Price',
                  icon: FontAwesomeIcons.tags,
                  controller: pricecontroller,
                  hint: '0RS',
                ),
                PartsDetail(
                  title: 'Quantity',
                  icon: Icons.production_quantity_limits,
                  controller: quancontroller,
                  hint: '0RS',
                ),
                PartsDetail(
                  title: 'Description',
                  maxlines: 2,
                  hint: 'Details',
                  icon: FontAwesomeIcons.addressBook,
                  controller: descripcontroller,
                ),
              ],
            ),
            0.02.ph,
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              height: Get.height * 0.06,
              minWidth: Get.width * 0.80,
              color: AppColor.redColor,
              onPressed: () {
                addpartController.addProduct(
                    titlecontroller,
                    categorycontroller,
                    pricecontroller,
                    quancontroller,
                    descripcontroller);
              },
              child: Text(
                'Confirm',
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            0.03.ph
          ],
        ),
      ),
    );
  }
}
