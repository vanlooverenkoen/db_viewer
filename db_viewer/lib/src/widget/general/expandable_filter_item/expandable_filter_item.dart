import 'package:db_viewer/src/style/theme_colors.dart';
import 'package:db_viewer/src/style/theme_dimens.dart';
import 'package:db_viewer/src/style/theme_durations.dart';
import 'package:db_viewer/src/style/theme_text_styles.dart';
import 'package:db_viewer/src/widget/general/expandable_filter_item/db_viewer_list_tile.dart';
import 'package:flutter/material.dart';

class ExpandableFilterItem extends StatefulWidget {
  final Color backgroundColor;
  final Widget child;
  final String title;
  final String subtitle;

  const ExpandableFilterItem({
    required this.child,
    required this.title,
    required this.subtitle,
    this.backgroundColor = ThemeColors.white,
    Key? key,
  }) : super(key: key);

  @override
  _ExpandableFilterItemState createState() => _ExpandableFilterItemState();
}

class _ExpandableFilterItemState extends State<ExpandableFilterItem>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0, end: 0.5);

  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late Animation<Color?> _backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: ThemeDurations.shortAnimationDuration(), vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _backgroundColor =
        _controller.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded = PageStorage.of(context)?.readState(context) ?? false;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    final theme = Theme.of(context);
    _headerColorTween
      ..begin = theme.textTheme.subtitle1?.color
      ..end = theme.colorScheme.secondary;
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.colorScheme.secondary;
    _backgroundColorTween.end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: widget.child,
    );
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor.value ?? Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DbViewerListTile(
            onClick: _handleTap,
            trailing: RotationTransition(
              turns: _iconTurns,
              child: Icon(
                Icons.expand_more,
                color: theme.textTheme.bodyText1?.color ?? Colors.black,
              ),
            ),
            child: Wrap(
              children: [
                AnimatedDefaultTextStyle(
                  child: Text(widget.title),
                  style: _isExpanded
                      ? theme.textTheme.bodyText1 ??
                          ThemeTextStyles.expandableFilterTitleOpen
                      : theme.textTheme.bodyText1 ??
                          ThemeTextStyles.expandableFilterTitleClose,
                  duration: ThemeDurations.shortAnimationDuration(),
                ),
                Container(width: ThemeDimens.padding8),
                Text(
                  widget.subtitle,
                  style: theme.textTheme.subtitle2?.copyWith(fontSize: 11) ??
                      const TextStyle(color: ThemeColors.mediumGrey),
                ),
              ],
            ),
          ),
          ClipRect(
            child: Align(
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
  }
}
