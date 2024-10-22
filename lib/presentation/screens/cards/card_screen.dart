import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_tecnica/presentation/providers/providers.dart';
import '../../../widgets/widgets.dart';

class CardScreen extends ConsumerWidget {
  final String cardId;
  const CardScreen({super.key, required this.cardId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardState = ref.watch(cardProvider(cardId));
    return Scaffold(
      backgroundColor: const Color(0xFFC2B4A7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC2B4A7),
      ),
      body: cardState.isLoading
          ? const FullScreenLoader()
          : CardDetails(cardState: cardState),
    );
  }
}
