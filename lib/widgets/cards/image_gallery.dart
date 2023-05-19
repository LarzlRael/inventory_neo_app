part of '../widgets.dart';

class ImageGallery extends StatelessWidget {
  final List<String> images;
  /* final Function(String image) deleteImage; */
  const ImageGallery({
    super.key,
    required this.images,
    /* required this.deleteImage, */
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Image.asset(
          'assets/images/no-image.jpg',
          fit: BoxFit.cover,
        ),
      );
    }
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(viewportFraction: 0.7),
      children: images.map((image) {
        late ImageProvider imageProvider;
        if (image.contains('http')) {
          imageProvider = NetworkImage(image);
        } else {
          imageProvider = FileImage(File(image));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: FadeInImage(
                  image: imageProvider,
                  placeholder:
                      const AssetImage('assets/loaders/bottle-loader.gif'),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                    onPressed: () {
                      /* deleteImage(image); */
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.grey[300],
                      size: 30,
                    )),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
