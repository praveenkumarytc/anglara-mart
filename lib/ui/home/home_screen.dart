import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/custom%20widgets/progress_indicator.dart';
import 'package:ecommerce/data/repository/product_repo.dart';
import 'package:ecommerce/helper/route_method.dart';
import 'package:ecommerce/logic/cubit/category%20cubit/category_cubit.dart';
import 'package:ecommerce/logic/cubit/category%20cubit/category_state.dart';
import 'package:ecommerce/utils/asset_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../product/product_list_screen.dart';
import 'components/banner_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductRepo productRepo = ProductRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
        if (state is CategoryLoadedState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannersView(),
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.fromLTRB(25, 5, 10, 0),
                child: Text('Categories'),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: state.categories!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 1.02,
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) => CategoryCard(
                    title: state.categories?[index] ?? '',
                    image: 'https://picsum.photos/${200 * index}/${300 * index}',
                    onTap: () {
                      routeTo(context, ProductListScreen(categoryName: state.categories?[index] ?? ''));
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return const ProgressBar();
        }
      }),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint(image);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey.shade200, spreadRadius: 1, blurRadius: 5)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFFFFF),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(
                      Images.placeholder,
                      fit: BoxFit.cover,
                    ),
                    imageUrl: image,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                    errorWidget: (c, o, s) => Image.asset(Images.placeholder, height: 100, width: 100, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                title,
                style: poppinsRegular,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle poppinsRegular = const TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
);
