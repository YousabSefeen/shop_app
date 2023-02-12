import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Business%20Logic%20Layer/cubits/cubit_theme_bottom_na.dart';
import '../../Business%20Logic%20Layer/cubits/cubit_search.dart';

import '../../Business%20Logic%20Layer/states/state_search.dart';

import '../../presentation%20layer/widgets/custom_text_field.dart';
import '../widgets/search_product.dart';

class SearchScreen extends StatelessWidget {
  static const route = 'SearchScreen';

  SearchScreen({Key? key}) : super(key: key);

  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SearchCubit cubit = SearchCubit.getObject(context);
        bool isDark = ThemeAndBNCubit.getObject(context).tm == ThemeMode.dark;

        Size deviceSize = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding:   EdgeInsets.only(
                  top:15.h,left: 15.w),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 25.h,
                  color: isDark ? Colors.grey : Colors.black,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  SizedBox(height: deviceSize.height * 0.03),
                  CustomTextField(
                    obscureText: false,
                    hint: 'search',
                    prefixIcon: Icons.search,
                    radius: 20.r,
                    textInputType: TextInputType.text,
                    onFieldSubmitted: (valueSearch) {
                      cubit.search(valueSearch);
                    },
                  ),
                  SizedBox(height: deviceSize.height * 0.04),
                  if (state is SearchLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cubit.searchModel!.searchData!.data.length,
                        itemBuilder: (context, index) => SearchProduct(
                          cubit.searchModel!.searchData!.data[index],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
