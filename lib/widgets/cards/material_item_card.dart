part of '../widgets.dart';

class MaterialItemCard extends StatelessWidget {
  final TagModel tag;
  final void Function(TagModel tagModel)? onTap;
  const MaterialItemCard({super.key, required this.tag, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
          onTap: () {
            /* context.push('/material_add_edit_page', extra: tag); */
            if (onTap != null) {
              onTap!(tag);
            }
          },
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
              ? Text(
                  tag.description.length > 75
                      ? '${tag.description.substring(0, 75)}...'
                      : tag.description,
                  style: textTheme.bodySmall!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                  ))
              : null),
    );
  }
}
