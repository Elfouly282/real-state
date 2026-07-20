import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/core/utils/app_styles.dart';

class PropertyImages extends StatefulWidget {
  final List<String> images;

  PropertyImages({super.key, required this.images});

  @override
  State<PropertyImages> createState() => _PropertyImagesState();
}

class _PropertyImagesState extends State<PropertyImages> {
  late PageController pageController;
  late PhotoViewController photoViewController;
  int currentImage = 0;
  double scale = 1.0;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    photoViewController = PhotoViewController();
  }

  @override
  void dispose() {
    pageController.dispose();
    photoViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                currentImage = index;
                scale = 1.0;
              });
              photoViewController.scale = 1.0;
            },
            builder: ((context, index) {
              return PhotoViewGalleryPageOptions(
                controller: photoViewController,
                imageProvider: NetworkImage(widget.images[index]),
                minScale: PhotoViewComputedScale.covered,
                maxScale: PhotoViewComputedScale.covered * 4,
                initialScale: PhotoViewComputedScale.covered,
                tightMode: true,
                basePosition: Alignment.center,
              );
            }),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Images View',
                  style: getMediumStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) {
                    final selector = currentImage == index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: GestureDetector(
                        onTap: () {
                          pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: 90,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selector
                                ? AppColors.primaryColor
                                : Colors.white.withOpacity(.9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Image ${index + 1}',
                            textAlign: TextAlign.center,
                            style: getMediumStyle(
                              fontSize: 14,
                              color: selector ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 30,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'plus',
                  mini: true,
                  onPressed: () {
                    scale += .5;
                    photoViewController.scale = scale;
                  },
                  child: Icon(Icons.add, color: Colors.white),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'minus',
                  mini: true,
                  onPressed: () {
                    if (scale > 1) {
                      scale -= .5;
                    }
                    photoViewController.scale = scale;
                  },
                  child: Icon(Icons.minimize, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
