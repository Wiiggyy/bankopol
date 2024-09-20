import 'package:bankopol/constants/text_style.dart';
import 'package:bankopol/models/event_card.dart';
import 'package:bankopol/provider/game/game_provider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EventCardWidget extends HookConsumerWidget {
  final EventCard eventCard;

  const EventCardWidget({
    required this.eventCard,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final didFlip = useState(false);

    return AspectRatio(
      aspectRatio: 7 / 4,
      child: Card(
        elevation: 0.0,
        margin: const EdgeInsets.only(
          left: 32.0,
          right: 32.0,
          top: 20.0,
        ),
        color: const Color(0x00000000),
        child: FlipCard(
          speed: 1000,
          onFlip: () {
            if (!didFlip.value) {
              ref.read(gameStatePodProvider.notifier).activateEventCard();
              didFlip.value = true;
            } else {
              ref.read(gameStatePodProvider.notifier).removeCardFromScreen();
            }
          },
          onFlipDone: (status) {},
          front: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: darkGreen,
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              border: Border.all(color: Colors.grey),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      'assets/eventCard.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // const Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Icon(
                //       Icons.question_mark,
                //       size: 60,
                //       color: Colors.yellow,
                //       shadows: [
                //         Shadow(
                //           blurRadius: 20,
                //           color: Colors.black,
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          back: Container(
            // padding: const EdgeInsets.all(16),
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: primaryGreen,
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              border: Border.all(color: Colors.grey),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      'assets/eventCardB.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    color: Colors.white.withOpacity(0.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Spacer(),
                        Text(
                          eventCard.description,
                          style: eventCardTextStyle,
                        ),
                        if (eventCard.eventAction.amount != null)
                          Text(
                            '${eventCard.eventAction.amount!}st',
                            style: eventCardTextStyle,
                          ),
                        if (eventCard.eventAction.amountValue != null)
                          Text(
                            '${eventCard.eventAction.amountValue!}kr',
                            style: eventCardTextStyle,
                          ),
                        if (eventCard.eventAction.percentValue != null)
                          Text(
                            '${eventCard.eventAction.percentValue! * 100}%',
                            style: eventCardTextStyle,
                          ),
                        const Spacer(),
                        Text(
                          eventCard.eventAction.investmentType.typeName,
                          style: eventCardTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
