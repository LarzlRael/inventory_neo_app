part of './widgets.dart';

class BannerLogin extends StatelessWidget {
  const BannerLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const Slideshow(
      primaryColor: Colors.blue,
      secondaryColor: Colors.blueGrey,
      primaryBullet: 12.5,
      secondaryBullet: 7.5,
      slides: [
        SlideBannerItem(
            assetImage:
                'https://www.financialfortunemedia.com/wp-content/uploads/2021/06/Image-to-Text.png',
            title: "¿Bloqueado y con muchas prácticas?",
            subtitle:
                "En nivel de dificultad no es un problema en subastareas"),
        SlideBannerItem(
            assetImage:
                'https://www.financialfortunemedia.com/wp-content/uploads/2021/06/Image-to-Text.png',
            title: "¿Sabes la respuesta?",
            subtitle: "Ayuda con la tarea propuesta y gana dinero por ello"),
        SlideBannerItem(
            assetImage:
                'https://www.financialfortunemedia.com/wp-content/uploads/2021/06/Image-to-Text.png',
            title: "Tareas de todas las materias",
            subtitle: "Porque enseñar también es una manera de aprender"),
      ],
    );
  }
}
