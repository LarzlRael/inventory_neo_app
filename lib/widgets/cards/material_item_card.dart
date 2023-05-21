part of '../widgets.dart';

class MaterialItemCard extends StatelessWidget {
  final TagsModel tag;
  const MaterialItemCard({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              'https://images.ctfassets.net/hrltx12pl8hq/3j5RylRv1ZdswxcBaMi0y7/b84fa97296bd2350db6ea194c0dce7db/Music_Icon.jpg',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            tag.name.toCapitalize(),
            style: textTheme.bodyMedium,
          ),
          subtitle: tag.description.isNotEmpty
              ? SimpleText(
                  text: tag.description.length > 75
                      ? '${tag.description.substring(0, 75)}...'
                      : tag.description,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                )
              : null),
    );
  }
}
