import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/enum/card_type.dart';

class AccountCard extends StatefulWidget {
  const AccountCard({
    Key? key,
    required this.cardNumber,
    required this.cardHolder,
    required this.bankName,
    required this.cardType,
    this.onDelete,
    this.onTap,
  }) : super(key: key);

  final String cardNumber;
  final String cardHolder;
  final String bankName;
  final CardType cardType;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  )..repeat(reverse: true);

  late final Animation<Offset> _posititionAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.3, 0.4),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInQuart,
    ),
  );
  late final Animation<double> _scaleAnimation =
      Tween<double>(begin: 0.7, end: 1.0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    ),
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            SlideTransition(
              position: _posititionAnimation,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.shade400,
                      Colors.purpleAccent.shade700,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.green.shade400,
                        Colors.orangeAccent.shade700,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: widget.onTap,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GlassmorphicContainer(
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  borderRadius: 16,
                  blur: 10,
                  alignment: Alignment.bottomCenter,
                  border: 2,
                  linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .color!
                          .withOpacity(0.1),
                      Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .color!
                          .withOpacity(0.05),
                    ],
                    stops: const [0.1, 1],
                  ),
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .color!
                          .withOpacity(0.5),
                      Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .color!
                          .withOpacity(0.5),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.bankName.toUpperCase(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Icon(widget.cardType.icon),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: RichText(
                            text: TextSpan(
                              text: '**** ',
                              style: GoogleFonts.jetBrainsMono(
                                textStyle:
                                    Theme.of(context).textTheme.headline5,
                              ),
                              children: [
                                const TextSpan(text: '**** '),
                                const TextSpan(text: '**** '),
                                TextSpan(text: widget.cardNumber)
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'CARDHOLDER',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .color!
                                            .withOpacity(0.5),
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.cardHolder.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  )
                                ],
                              ),
                            ),
                            widget.onDelete != null
                                ? IconButton(
                                    onPressed: widget.onDelete,
                                    icon: const Icon(Icons.delete),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      tablet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            SlideTransition(
              position: _posititionAnimation,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.shade400,
                      Colors.purpleAccent.shade700,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.green.shade400,
                        Colors.orangeAccent.shade700,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GlassmorphicContainer(
                height: 350,
                width: MediaQuery.of(context).size.width,
                borderRadius: 16,
                blur: 10,
                alignment: Alignment.bottomCenter,
                border: 2,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .color!
                        .withOpacity(0.1),
                    Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .color!
                        .withOpacity(0.05),
                  ],
                  stops: const [0.1, 1],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .color!
                        .withOpacity(0.5),
                    Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .color!
                        .withOpacity(0.5),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.bankName,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Icon(widget.cardType.icon, size: 32),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          text: '**** ',
                          style: GoogleFonts.jetBrainsMono(
                            textStyle: Theme.of(context).textTheme.headline4,
                          ),
                          children: [
                            const TextSpan(text: '**** '),
                            const TextSpan(text: '**** '),
                            TextSpan(text: widget.cardNumber)
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)!.successAddCategory,
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .color!
                                          .withOpacity(0.5),
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            widget.cardHolder.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
