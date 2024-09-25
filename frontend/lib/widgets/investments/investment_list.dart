import 'package:bankopol/models/investment.dart';
import 'package:bankopol/models/player.dart';
import 'package:bankopol/widgets/investments/investment_item.dart';
import 'package:bankopol/widgets/investments/investment_item_header.dart';
import 'package:diffutil_dart/diffutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InvestmentList extends StatefulHookWidget {
  final Player player;

  const InvestmentList({
    required this.player,
    super.key,
  });

  @override
  State<InvestmentList> createState() => _InvestmentListState();
}

class _InvestmentListState extends State<InvestmentList> {
  final _listKey = GlobalKey<SliverAnimatedListState>();

  SliverAnimatedListState get animatedList => _listKey.currentState!;

  late List<Investment> investmentList;

  @override
  void initState() {
    investmentList = widget.player.investments.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        final diff = calculateListDiff(
          investmentList,
          widget.player.investments,
          equalityChecker: (o, n) => o.investmentType == n.investmentType,
        );

        for (final update in diff.getUpdates()) {
          switch (update) {
            case Insert(:final position, :final count):
              animatedList.insertAllItems(position, count);
            case Remove(:final position, :final count):
              for (var i = position + count; i > position; i--) {
                final investmentToRemove = investmentList[i - 1];
                animatedList.removeItem(
                  i - 1,
                  duration: const Duration(seconds: 1),
                  (
                    context,
                    animation,
                  ) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (_, child) {
                        final slideOffset = Tween<Offset>(
                          begin: const Offset(
                            1,
                            0,
                          ),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: const Interval(
                              0.5,
                              1,
                              curve: Curves.bounceIn,
                            ),
                          ),
                        );

                        // Calculate the scale factor
                        final scaleFactor = Tween<double>(
                          begin: 0,
                          end: 1.0,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: const Interval(
                              0,
                              0.5,
                              curve: Curves.bounceIn,
                            ),
                          ),
                        );

                        return SlideTransition(
                          position: slideOffset,
                          child: SizeTransition(
                            sizeFactor: scaleFactor,
                            child: child,
                          ),
                        );
                      },
                      child: InvestmentItem(investment: investmentToRemove),
                    );
                  },
                );
              }
            case Move(:final from, :final to):
            // TODO: Maybe add somehow?
            case Change():
              break;
          }
        }

        investmentList = widget.player.investments.toList();

        return null;
      },
      widget.player.investments,
    );

    return SliverMainAxisGroup(
      slivers: [
        const SliverToBoxAdapter(child: InvestmentItemHeader()),
        SliverAnimatedList(
          key: _listKey,
          initialItemCount: investmentList.length,
          // separatorBuilder: (_, index) {
          //   return const Divider(
          //     height: 1,
          //     color: Colors.grey,
          //   );
          // },
          itemBuilder: (_, index, __) {
            return InvestmentItem(investment: investmentList[index]);
          },
        ),
      ],
    );
  }
}
