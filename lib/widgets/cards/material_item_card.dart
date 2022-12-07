part of '../widgets.dart';

class MaterialItemCard extends StatelessWidget {
  final TagsModel tag;
  const MaterialItemCard({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              'https://images.ctfassets.net/hrltx12pl8hq/3j5RylRv1ZdswxcBaMi0y7/b84fa97296bd2350db6ea194c0dce7db/Music_Icon.jpg',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SimpleText(
                  text: tag.name,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  bottom: 5,
                ),
                tag.description.isNotEmpty
                    ? SimpleText(
                        text: tag.description.length > 75
                            ? '${tag.description.substring(0, 75)}...'
                            : tag.description,
                        fontSize: 14,
                        fontWeight: FontWeight.w300)
                    : const SizedBox(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
