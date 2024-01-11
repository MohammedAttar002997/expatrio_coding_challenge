import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../base/show_custom_snackbar.dart';
import '../../controllers/user_tax_controller.dart';
import '../../models/user_tax_model.dart';
import '../../shared/countries_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class UserTaxPage extends StatelessWidget {
  const UserTaxPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool checkNotUSCitizen = false;
    TextEditingController tidNumberController = TextEditingController();

    late Map<String, dynamic> countryCodeName;
    List<Map<String, dynamic>> countryCodeList = [];
    List<Map<String, dynamic>> tidNationality = CountriesConstants.nationality;

    void setUserTaxesForBackend(UserTaxController userTaxController) {
      PrimaryTaxResidence primaryTaxResidence = PrimaryTaxResidence(
        country: countryCodeName["code"],
        id:tidNumberController.text,
      );
      UserTaxModel userTaxModel = UserTaxModel(
          primaryTaxResidence: primaryTaxResidence,
          secondaryTaxResidence: [
            PrimaryTaxResidence(country: "GH", id: "2981"),
            PrimaryTaxResidence(country: "GR", id: "2763"),
          ]);
      userTaxController
          .setUserTaxes(
        userTaxModel,
      )
          .then(
        (status) {
          if (status.isSuccess) {
          } else {
            showCustomSnackBar(status.message);
          }
        },
      );
    }

    return Scaffold(
      body: GetBuilder<UserTaxController>(builder: (userTaxController) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/CryingGirl.svg"),
              BigText(
                text: "Uh-Oh!",
                size: Dimensions.font26,
                fontWeight: FontWeight.w600,
              ),
              Text(
                "We need your tax data in\n order to you to access\n your account",
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.mainBlackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: Dimensions.font20,
                ),
              ),
              SizedBox(
                height: Dimensions.screenHeight * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    isScrollControlled: true,
                    builder: (context) {
                      return GetBuilder<UserTaxController>(
                          builder: (userTaxController) {
                        return Container(
                          width: double.infinity,
                          height: Dimensions.screenHeight * 0.72,
                          margin: EdgeInsets.only(
                            left: Dimensions.width25,
                            right: Dimensions.width25,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                text: "Personal Information",
                                fontWeight: FontWeight.w600,
                                size: Dimensions.font20,
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              BigText(
                                text: "Financial Information",
                                fontWeight: FontWeight.w600,
                                size: Dimensions.font20,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        SmallText(
                                          text:
                                              "WHICH COUNTRY SERVES AS YOUR PRIMARY TAX RESIDENCE?*",
                                          size: Dimensions.font16,
                                          color: AppColor.mainBlackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        DropdownSearch(
                                          items: tidNationality
                                              .map((e) => e["label"])
                                              .toList(),
                                          onChanged: (value) {
                                            countryCodeName = CountriesConstants
                                                .nationality
                                                .firstWhere(
                                              (element) =>
                                                  element["label"] == value,
                                            );
                                            countryCodeList.add({
                                              "code": countryCodeName["code"]
                                            });
                                          },
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              hintText: "Please Select",
                                              alignLabelWithHint: true,
                                              contentPadding: EdgeInsets.only(
                                                  left: Dimensions.width10),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius10),
                                                borderSide: const BorderSide(
                                                  width: 1.0,
                                                  color: AppColor.textColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        SmallText(
                                          text: "TAX IDENTIFICATION NUMBER*",
                                          size: Dimensions.font16,
                                          color: AppColor.mainBlackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        TextField(
                                          onSubmitted: (changedValue) {
                                            countryCodeList
                                                .add({"TID": changedValue});
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Tax ID or N/A",
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15),
                                              borderSide: const BorderSide(
                                                width: 1.0,
                                                color: Colors.black12,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15),
                                              borderSide: const BorderSide(
                                                width: 1.0,
                                                color: Colors.black12,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15),
                                            ),
                                            contentPadding: EdgeInsets.all(
                                                Dimensions.height12),
                                            hintStyle: TextStyle(
                                              fontSize: Dimensions.font20,
                                            ),
                                          ),
                                          controller: tidNumberController,
                                        ),
                                      ],
                                    );
                                  },
                                  itemCount: userTaxController.counter,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      userTaxController.increaseCounterValue();
                                    },
                                    child: BigText(
                                      text: "+ Add Another",
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .cursorColor!,
                                      size: Dimensions.font20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  userTaxController.counter <= 1
                                      ? Container()
                                      : GestureDetector(
                                          onTap: () {
                                            userTaxController
                                                .decreaseCounterValue();
                                          },
                                          child: BigText(
                                            text: "- remove",
                                            color: Colors.red,
                                            size: Dimensions.font20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: userTaxController.isChecked,
                                    onChanged: (bool? value) {
                                      userTaxController.changeStatus(value!);
                                      // checkNotUSCitizen = value!;
                                    },
                                    activeColor: Theme.of(context)
                                        .textSelectionTheme
                                        .cursorColor!,
                                    checkColor: Theme.of(context)
                                        .textSelectionTheme
                                        .cursorColor!,
                                  ),
                                  Expanded(
                                    child: BigText(
                                      text: "I confirm above tax residency\n "
                                          "and US self-declaration is true "
                                          "and accurate",
                                      size: Dimensions.font16,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (userTaxController.isChecked) {
                                      setUserTaxesForBackend(userTaxController);
                                      Navigator.pop(context);
                                    } else if (countryCodeList.isEmpty) {
                                      showCustomSnackBar(
                                        "Please make sure you have filled everything correctly ",
                                        title: "Sorry!",
                                        isError: true,
                                      );
                                    } else {
                                      showCustomSnackBar(
                                        "Please check you are not US Citizen ",
                                        title: "Sorry!",
                                        isError: true,
                                      );
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10,
                                    ),
                                    height: Dimensions.screenHeight / 17,
                                    width: Dimensions.screenWidth,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radius30,
                                      ),
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .cursorColor!,
                                    ),
                                    child: Center(
                                      child: BigText(
                                        text: "SAVE",
                                        color: Colors.white,
                                        size: Dimensions.font20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width10, right: Dimensions.width10),
                  height: Dimensions.screenHeight / 17,
                  width: Dimensions.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.radius30,
                    ),
                    color: Theme.of(context).textSelectionTheme.cursorColor!,
                  ),
                  child: Center(
                    child: BigText(
                      text: "Upload your tax data",
                      color: Colors.white,
                      size: Dimensions.font20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
