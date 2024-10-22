import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../presentation/providers/providers.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({
    super.key,
    required this.cardState,
  });

  final CardState cardState;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 8,
      trackVisibility: true,
      radius: const Radius.circular(10),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 350,
                  width: 350,
                  child: _ImageGallery(
                    images: cardState.card!.cardImages.first.imageUrl,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CardInfo(
                cardState: cardState,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageGallery extends StatelessWidget {
  final String images;

  const _ImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Image.asset(
          'assets/imgs/no-image.jpg',
          fit: BoxFit.cover,
        ),
      );
    }

    return Image.network(
      images,
      scale: 1.0,
      fit: BoxFit.contain,
    );
  }
}

class CardInfo extends StatelessWidget {
  final CardState cardState;

  const CardInfo({super.key, required this.cardState});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          cardState.card!.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'YuGiOh',
            fontSize: 25,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GridInfoCard(cardState: cardState),
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          cardState.card!.desc,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

class GridInfoCard extends StatelessWidget {
  const GridInfoCard({
    super.key,
    required this.cardState,
  });

  final CardState cardState;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        childAspectRatio: 2,
      ),
      children: [
        GridTile(
          header: const Text(
            'Type',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.library_books_rounded,
              ),
              const SizedBox(width: 5),
              Text(
                cardState.card!.type,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        // Arquetipo (solo si existe)
        if (cardState.card!.archetype != null)
          GridTile(
            header: const Text(
              'Archetype',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            child: Row(
              children: [
                Image.network(
                  'https://images.ygoprodeck.com/images/cards/${cardState.card!.archetype}.jpg',
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                  scale: 1.0,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.science_rounded,
                    );
                  },
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    cardState.card!.archetype!,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        // Tipo/Raza
        GridTile(
          header: const Text(
            'Race/Type',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          child: Row(
            children: [
              Image.network(
                'https://images.ygoprodeck.com/images/cards/icons/race/${cardState.card!.race}.png',
                width: 30,
                scale: 1.0,
              ),
              const SizedBox(width: 5),
              Text(
                cardState.card!.race,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        // Atributo (solo si existe)
        if (cardState.card!.attribute != null)
          GridTile(
            header: const Text(
              'Attribute',
            ),
            child: Row(
              children: [
                Image.network(
                  'https://images.ygoprodeck.com/images/cards/${cardState.card!.attribute}.jpg',
                  width: 30,
                  height: 30,
                  scale: 1.0,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 5),
                Text(
                  cardState.card!.attribute!,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        // Level/Rank (solo si existe)
        if (cardState.card!.level != null)
          GridTile(
            header: const Text(
              'Level/Rank',
            ),
            child: Row(
              children: [
                Image.network(
                  'https://ygoprodeck.com/wp-content/uploads/2017/01/level.png',
                  width: 30,
                  height: 30,
                  scale: 1.0,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 5),
                Text(
                  '${cardState.card!.level}',
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
        // ATK (solo si existe)
        if (cardState.card!.atk != null)
          GridTile(
              header: const Text(
                'ATK',
              ),
              child: Row(
                children: [
                  StatWidget(
                    value: cardState.card!.atk!,
                    icon: Symbols.swords,
                    color: Colors.amber,
                  ),
                ],
              )),
        if (cardState.card!.def != null)
          GridTile(
            header: const Text(
              'DEF',
            ),
            child: Row(
              children: [
                StatWidget(
                  // label: 'DEF',
                  value: cardState.card!.def!,
                  icon: Symbols.shield_sharp,
                  color: Colors.amber,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class StatWidget extends StatelessWidget {
  final int value;
  final IconData icon;
  final Color? color;

  const StatWidget({
    super.key,
    required this.value,
    required this.icon,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(
          width: 5,
        ),
        const SizedBox(width: 10),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
