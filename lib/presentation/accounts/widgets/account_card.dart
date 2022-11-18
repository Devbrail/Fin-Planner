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

  late final Animation<Offset> _positionAnimation = Tween<Offset>(
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
      breakpoints: const ScreenBreakpoints(
        tablet: 600,
        desktop: 700,
        watch: 300,
      ),
      mobile: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            SlideTransition(
              position: _positionAnimation,
              child: GradientCircle(
                width: 100,
                height: 100,
                colo1: Theme.of(context).colorScheme.primary,
                color2: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: GradientCircle(
                  width: 200,
                  height: 200,
                  colo1: Theme.of(context).colorScheme.secondary,
                  color2: Theme.of(context).colorScheme.primaryContainer,
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
                  child: Stack(
                    children: [
                      Padding(
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
                                    TextSpan(
                                        text: widget.cardNumber.isEmpty
                                            ? '----'
                                            : widget.cardNumber)
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of(context)!
                                            .cardholderLabel
                                            .toUpperCase(),
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      tablet: Stack(
        children: [
          SlideTransition(
            position: _positionAnimation,
            child: GradientCircle(
              width: 100,
              height: 100,
              colo1: Theme.of(context).colorScheme.primary,
              color2: Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: GradientCircle(
                width: 150,
                height: 150,
                colo1: Theme.of(context).colorScheme.primary,
                color2: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: widget.onTap,
              child: GlassmorphicContainer(
                height: 500,
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
                            widget.bankName,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Icon(widget.cardType.icon, size: 32),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          text: '**** ',
                          style: GoogleFonts.jetBrainsMono(
                            textStyle: Theme.of(context).textTheme.subtitle1,
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
                            AppLocalizations.of(context)!
                                .cardholderLabel
                                .toUpperCase(),
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(),
                          ),
                          Text(
                            widget.cardHolder.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
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
          ),
        ],
      ),
      desktop: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            SlideTransition(
              position: _positionAnimation,
              child: GradientCircle(
                width: 200,
                height: 200,
                colo1: Theme.of(context).colorScheme.primary,
                color2: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: GradientCircle(
                  width: 300,
                  height: 300,
                  colo1: Theme.of(context).colorScheme.primary,
                  color2: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: widget.onTap,
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
                              AppLocalizations.of(context)!
                                  .cardholderLabel
                                  .toUpperCase(),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
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
            ),
          ],
        ),
      ),
    );
  }
}

class GradientCircle extends StatelessWidget {
  const GradientCircle({
    super.key,
    required this.width,
    required this.height,
    required this.colo1,
    required this.color2,
  });
  final double width;
  final double height;
  final Color colo1, color2;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height / 2),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colo1,
            color2,
          ],
        ),
      ),
    );
  }
}
