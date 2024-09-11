import 'package:bankopol/constants/colors.dart';
import 'package:bankopol/models/event_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class EventCardWidget extends StatelessWidget {
  final EventCard eventCard;
  final void Function() onFlip;

  const EventCardWidget({
    required this.eventCard,
    required this.onFlip,
    super.key,
  });

  _renderBg() {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
    );
  }

  _renderContent(context) {
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.only(
          left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
      color: const Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        side: CardSide.FRONT,
        speed: 1000,
        onFlip: onFlip,
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
                      Text(
                        eventCard.description,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      if (eventCard.eventAction.amount != null)
                        Text(
                          eventCard.eventAction.amount!.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      if (eventCard.eventAction.amountValue != null)
                        Text(
                          eventCard.eventAction.amountValue!.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      if (eventCard.eventAction.percentValue != null)
                        Text(
                          eventCard.eventAction.percentValue!.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // _renderBg(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: _renderContent(context),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        )
      ],
    );
  }
}
