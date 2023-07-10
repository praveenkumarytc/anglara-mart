import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/utils/asset_images.dart';
import 'package:flutter/material.dart';

import '../../../utils/color_resources.dart';

class BannersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.only(top: 15, bottom: 5),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              disableCenter: true,
              onPageChanged: (index, reason) {},
            ),
            itemCount: 2,
            itemBuilder: (context, index, _) {
              return InkWell(
                hoverColor: Colors.transparent,
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      image: imageUrls[index],
                      placeholder: Images.placeholder,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageUrls.map((bnr) {
                return TabPageSelectorIndicator(
                  backgroundColor: ColorResources.WHITE,
                  borderColor: Theme.of(context).primaryColor,
                  size: 10,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<String> imageUrls = [
    'https://picsum.photos/500/800',
    'https://picsum.photos/489/780'
  ];
}
