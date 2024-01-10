
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
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class UserTaxPage extends StatelessWidget {
  const UserTaxPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> taxCountry = [];
    var tidNumber = TextEditingController();
    CountriesConstants.nationality.forEach((element) {
      taxCountry.add(element["label"].toString());
    });

    void setUserTaxesForBackend(UserTaxController userTaxController) {
      PrimaryTaxResidence primaryTaxResidence =
          PrimaryTaxResidence(country: "AM", id: "1029");
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
                  // setUserTaxesForBackend(userTaxController);
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (context) {
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        child: Column(
                          children: [
                            BigText(
                              text: "Personal Information",
                              fontWeight: FontWeight.w600,
                              size: Dimensions.font20,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            userTaxController.counter <= 1
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                          text: "Financial Information",
                                          fontWeight: FontWeight.w600,
                                          size: Dimensions.font20),
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
                                        items: CountriesConstants.nationality
                                            .map((e) => e["label"])
                                            .toList(),
                                        onChanged: (value) {
                                          print("this is the value$value");
                                          var num;
                                          num = CountriesConstants.nationality
                                              .where(
                                                (element) =>
                                                    element["label"] == value,
                                              )
                                              .toList();
                                          print(
                                              "This is the country code${num}");
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
                                        text:
                                            "TAX IDENTIFICATION NUMBER (IF NOT APPLICABLE INSERT N/A)*",
                                        size: Dimensions.font16,
                                        color: AppColor.mainBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      AppTextField(
                                        textController: tidNumber,
                                        hintText: "1234567890 or N/A",
                                      )
                                    ],
                                  )
                                : MediaQuery.removePadding(
                                    removeTop: true,
                                    context: context,
                                    child: Expanded(
                                      child: ListView.builder(
                                        itemBuilder: (context, index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              BigText(
                                                  text: "Financial Information",
                                                  fontWeight: FontWeight.w600,
                                                  size: Dimensions.font20),
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
                                                items: CountriesConstants
                                                    .nationality
                                                    .map((e) => e["label"])
                                                    .toList(),
                                                onChanged: (value) {
                                                  print(
                                                      "this is the value$value");
                                                  var num;
                                                  num = CountriesConstants
                                                      .nationality
                                                      .where(
                                                        (element) =>
                                                            element["label"] ==
                                                            value,
                                                      )
                                                      .toList();
                                                  print(
                                                      "This is the country code${num}");
                                                },
                                                dropdownDecoratorProps:
                                                    DropDownDecoratorProps(
                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                                    hintText: "Please Select",
                                                    alignLabelWithHint: true,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: Dimensions
                                                                .width10),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radius10),
                                                      borderSide:
                                                          const BorderSide(
                                                        width: 1.0,
                                                        color:
                                                            AppColor.textColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10,
                                              ),
                                              SmallText(
                                                text:
                                                    "TAX IDENTIFICATION NUMBER (IF NOT APPLICABLE INSERT N/A)*",
                                                size: Dimensions.font16,
                                                color: AppColor.mainBlackColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10,
                                              ),
                                              AppTextField(
                                                textController: tidNumber,
                                                hintText: "1234567890 or N/A",
                                              )
                                            ],
                                          );
                                        },
                                        itemCount: userTaxController.counter,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      );
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
                    color: AppColor.mainColor,
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
