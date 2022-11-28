import 'package:cnubot_app/app/4_view/0_constant/enum/cafeteria_type.dart';
import 'package:cnubot_app/app/4_view/1_component/1_layout/header/go_to_home_button.dart';
import 'package:cnubot_app/app/4_view/1_component/1_layout/header/top_circle.dart';
import 'package:cnubot_app/app/4_view/1_component/1_layout/header/top_logo.dart';
import 'package:cnubot_app/app/4_view/1_component/1_layout/header/top_text.dart';
import 'package:cnubot_app/app/4_view/2_screen/6_food/component/cafeteria_listview.dart';
import 'package:cnubot_app/app/4_view/2_screen/6_food/component/day_list_view.dart';
import 'package:cnubot_app/app/4_view/2_screen/6_food/component/food_list_view.dart';
import 'package:cnubot_app/app/4_view/2_screen/6_food/component/operation_time.dart';
import 'package:cnubot_app/app/4_view/2_screen/6_food/food_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FoodScreen extends GetView<FoodController> {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.getFoodModelList(refresh: true);
        return Future.value();
      },
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned(
                            right: -7.w,
                            top: 37.h,
                            child: const GoToHomeButton(),
                          ),
                          Positioned(
                            top: -66.h,
                            child: const TopCircle(),
                          ),
                          Positioned(
                            top: 96.h,
                            child: const TopLogo(),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0.w, 142.h, 0, 0),
                            child: Column(
                              children: [
                                const TopText(
                                  text: '학식',
                                ),
                                Obx(
                                  () => Column(
                                    children: [
                                      CafeteriaListView(
                                        currentType:
                                            controller.cafeteriaType.value,
                                        updateBoardType:
                                            controller.updateCafeteriaType,
                                      ),
                                      controller.cafeteriaType.value ==
                                              CafeteriaType.studentHall1
                                          ? FoodListView(
                                              currentType:
                                                  controller.foodType.value,
                                              updateFoodType:
                                                  controller.updateFoodType,
                                            )
                                          : DayListView(
                                              currentType:
                                                  controller.dayType.value,
                                              updateDayType:
                                                  controller.updateDayType,
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      // 운영시간
                      Obx(
                        () => OperationTime(
                          cafeteriaType: controller.cafeteriaType.value,
                          foodType: controller.foodType.value,
                        ),
                      ),

                      // 소식 게시글
                      // Obx(
                      //   () => ListView.builder(
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     itemCount: controller.noticeModelList.length,
                      //     padding: EdgeInsets.fromLTRB(0, 31.h, 0, 0),
                      //     shrinkWrap: true,
                      //     itemBuilder: (context, index) {
                      //       return NoticeCard(
                      //         noticeModel: controller.noticeModelList[index],
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
