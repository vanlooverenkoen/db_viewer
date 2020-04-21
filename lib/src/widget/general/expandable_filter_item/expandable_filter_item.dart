import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moor_db_viewer/src/style/theme_colors.dart';
import 'package:moor_db_viewer/src/style/theme_durations.dart';
import 'package:moor_db_viewer/src/style/theme_text_styles.dart';
import 'package:moor_db_viewer/src/widget/general/expandable_filter_item/db_viewer_list_tile.dart';

class ExpandableFilterItem extends StatefulWidget {
  final Color backgroundColor;
  final Widget child;
  final ValueChanged<bool> onEnabledChanged;
  final String title;
  final bool enabled;

  const ExpandableFilterItem({
    @required this.child,
    @required this.title,
    @required this.onEnabledChanged,
    @required this.enabled,
    this.backgroundColor = ThemeColors.white,
    Key key,
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

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;
  Animation<Color> _backgroundColor;

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
      ..begin = theme.textTheme.subhead.color
      ..end = theme.accentColor;
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.accentColor;
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

  Widget _buildChildren(BuildContext context, Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor.value ?? Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DbViewerListTile(
            onClick: _handleTap,
            leading: RotationTransition(
              turns: _iconTurns,
              child: const Icon(
                Icons.expand_more,
                color: ThemeColors.black,
              ),
            ),
            trailing: Switch.adaptive(
              value: widget.enabled,
              onChanged: widget.onEnabledChanged,
              activeColor: Theme.of(context).accentColor,
            ),
            child: AnimatedDefaultTextStyle(
              child: Text(widget.title),
              style: _isExpanded
                  ? ThemeTextStyles.expandableFilterTitleOpen
                  : ThemeTextStyles.expandableFilterTitleClose,
              duration: ThemeDurations.shortAnimationDuration(),
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
