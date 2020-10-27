import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:domain/domain.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:external_module/external_module.dart';
import 'package:data/data.dart';
import '../bloc/get_list_restaurant_event.dart';
import '../bloc/get_list_restaurant_state.dart';
import '../widget/card/restaurant_card.dart';
import '../widget/error/custom_error_widget.dart';
import '../widget/loading/custom_loading_progress.dart';
import '../bloc/get_list_restaurant_bloc.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return BlocProvider(
      create: (context) => GetListRestaurantBloc(
        getListRestaurantUseCase: GetListRestaurantUseCaseImpl(
          restaurantRepository: RestaurantRepositoryIml(
            remoteDataSource: RemoteDataSourceImpl(
              dio: Dio(
                BaseOptions(
                  baseUrl: ApiConstant.baseUrl,
                ),
              ),
            ),
          ),
        ),
      )..add(GetListRestaurant()),
      child: Scaffold(
        backgroundColor: CustomColors.yellow,
        appBar: AppBar(
          backgroundColor: CustomColors.yellow,
          elevation: 0.0,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Restaurant",
                style: TextStyle(color: CustomColors.white, fontSize: 20.sp),
              ),
              Text(
                "Recommendation restaurant for you!",
                style: TextStyle(color: CustomColors.white, fontSize: 12.sp),
              )
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: CustomColors.white,
              ),
            ),
          ],
        ),
        body: BlocBuilder<GetListRestaurantBloc, GetListRestaurantState>(
          builder: (context, state) {
            if (state is GetListRestaurantLoadedState) {
              if (state.listRestaurant.isEmpty) {
                return Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: CustomColors.lightYellow,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: CustomErrorWidget(
                    errorImage: ImageStrings.empty,
                    errorMessage: "Restaurant data is empty",
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Container(
                      margin: EdgeInsets.only(top: 16.w),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: CustomColors.lightYellow,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.listRestaurant.length,
                          itemBuilder: (context, index) {
                            return RestaurantCard(
                                restaurantEntity: state.listRestaurant[index]);
                          })),
                );
              }
            } else if (state is GetListRestaurantFailedState) {
              return Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: CustomColors.lightYellow,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: CustomErrorWidget(
                  errorImage: ImageStrings.error,
                  errorMessage: "An error occurred please try again later",
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: CustomColors.lightYellow,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: CustomLoadingProgress(),
              );
            }
          },
        ),
      ),
    );
  }
}