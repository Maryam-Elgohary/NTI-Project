import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forth_session/core/services/get_it.dart';
import 'package:forth_session/features/home/domain/repos/product_repo.dart';
import 'package:forth_session/features/home/presentation/cubit/get_products/get_products_cubit.dart';
import 'package:forth_session/features/home/presentation/views/widgets/best_selling_row.dart';
import 'package:forth_session/features/home/presentation/views/widgets/hello_notify_row.dart';
import 'package:forth_session/features/home/presentation/views/widgets/products_gridview_builder.dart';
import 'package:forth_session/features/home/presentation/views/widgets/search_field.dart';

class Homeview extends StatelessWidget {
  Homeview({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) =>
            GetProductsCubit(getIt<ProductRepo>())..getProducts(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                spacing: 30,
                children: [
                  HelloNotifyRow(),
                  SearchField(),
                  //    OffersListView(),
                  Most_Row(),
                  productsGridViewBuilder(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



  //  BlocProvider(
    //   create: (context) => SignoutCubit(getIt<AuthRepo>()),
    //   child: Scaffold(
    //     body: BlocConsumer<SignoutCubit, SignoutState>(
    //       listener: (context, state) {
    //         if (state is SignoutSuccess) {
    //           BuildSnackBar(context, 'تم تسجيل الخروج');
    //           Navigator.pop(context);
    //         }
    //         if (state is SignoutFailed) {
    //           BuildSnackBar(context, state.errMessage);
    //         }
    //       },
    //       builder: (context, state) {
    //         return Center(
    //           child: ElevatedButton(
    //             onPressed: () {
    //               context.read<SignoutCubit>().signOut();
    //             },
    //             child: Text("Sign Out"),
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );