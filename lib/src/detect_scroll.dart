import "package:flutter/material.dart";

/// The [DetectScroll] has 2 uses:
///
/// 1) It can detect if its subtree is scrolled, and inform its descendants.
/// This is useful for showing/hiding widget only when the content is scrolled (ot not
/// scrolled).
///
/// 2) It can detect if a scrollbar is likely visible, and provide the width of the
/// scrollbar. This is useful for positioning widgets relative to the scrollbar,
/// so that the scrollbar doesn't overlap them. This can be important when the scrollbar
/// is permanently visible, usually on the Web and desktop.
///
/// Note it will only detect the scrolling of its **closest** scrollable descendant
/// (a scrollable is a `SingleChildScrollView`, `ListView`, `GridView` etc).
/// Usually, you would wrap the scrollable you care about directly with a [DetectScroll].
/// For example:
///
/// ```dart
/// DetectScrollbar(
///  child: SingleChildScrollView(
///     child: Column( ...
///  ...
/// );
/// ```
///
/// To get the current scroll state and scrollbar width, descendants can call:
/// ```dart
/// bool isScrolled = DetectScrollable.of(context).isScrolled;
/// double width = DetectScrollable.of(context).scrollbarWidth;
/// ```
///
/// ## Example
///
/// Suppose you want to add a help button to the top-right corner of a
/// scrollable, and account for the scrollbar width only if it's visible:
///
/// ```dart
/// bool isScrollbarPresent = DetectScrollbar.of(context).isScrolled;
/// double width = DetectScrollbar.of(context).scrollbarWidth;
///
/// return Stack(
///   children: [
///      child,
///      Positioned(
///         right: isScrollbarPresent ? width : 0,
///         top: 0,
///         child: HelpButton(),
///      ),
///   ],
/// );
/// ```
///
/// # In more detaiL:
///
/// The [DetectScroll] actually detects if its subtree is scrolled, which means its
/// closes descendant Scrollable is not at its zero position (not at the top),
/// and then informs its descendants about this fact.
///
/// Note this doesn't mean there is actually a scrollbar visible, but only that the
/// content is scrolled. For this reason, you should use to detect scrollbars only when
/// you know there will be a fixed scrollbar (like on the web or desktop), or when
/// you're using a custom scrollbar that is always visible.
///
/// Regarding the width of the scrollbar provided by [DetectScroll], this information
/// is calculated from the current **theme** at the [DetectScroll]. For this reason,
/// if you use this width, make sure the scrollbar is actually using this same theme.
///
class DetectScroll extends StatefulWidget {
  final Widget child;

  /// The [DetectScroll] has 2 uses:
  ///
  /// 1) It can detect if its subtree is scrolled, and inform its descendants.
  /// This is useful for showing/hiding widget only when the content is scrolled (ot not
  /// scrolled).
  ///
  /// 2) It can detect if a scrollbar is likely visible, and provide the width of the
  /// scrollbar. This is useful for positioning widgets relative to the scrollbar,
  /// so that the scrollbar doesn't overlap them. This can be important when the
  /// scrollbar is permanently visible, usually on the Web and desktop.
  ///
  /// Note it will only detect the scrolling of its **closest** scrollable descendant
  /// (a scrollable is a `SingleChildScrollView`, `ListView`, `GridView` etc).
  /// Usually, you would wrap the scrollable you care about directly with
  /// a [DetectScroll]. For example:
  ///
  /// ```dart
  /// DetectScrollbar(
  ///  child: SingleChildScrollView(
  ///     child: Column( ...
  ///  ...
  /// );
  /// ```
  ///
  /// To get the current scroll state and scrollbar width, descendants can call:
  /// 
  /// ```dart
  /// bool isScrolled = DetectScrollable.of(context).isScrolled;
  /// double width = DetectScrollable.of(context).scrollbarWidth;
  /// ```
  ///
  /// ## Example
  ///
  /// Suppose you want to add a help button to the top-right corner of a
  /// scrollable, and account for the scrollbar width only if it's visible:
  ///
  /// ```dart
  /// bool isScrollbarPresent = DetectScrollbar.of(context).isScrolled;
  /// double width = DetectScrollbar.of(context).scrollbarWidth;
  ///
  /// return Stack(
  ///   children: [
  ///      child,
  ///      Positioned(
  ///         right: isScrollbarPresent ? width : 0,
  ///         top: 0,
  ///         child: HelpButton(),
  ///      ),
  ///   ],
  /// );
  /// ```
  ///
  /// # In more detaiL:
  ///
  /// The [DetectScroll] actually detects if its subtree is scrolled, which means its
  /// closes descendant Scrollable is not at its zero position (not at the top),
  /// and then informs its descendants about this fact.
  ///
  /// Note this doesn't mean there is actually a scrollbar visible, but only that the
  /// content is scrolled. For this reason, you should use to detect scrollbars only when
  /// you know there will be a fixed scrollbar (like on the web or desktop), or when
  /// you're using a custom scrollbar that is always visible.
  ///
  /// Regarding the width of the scrollbar provided by [DetectScroll], this information
  /// is calculated from the current **theme** at the [DetectScroll]. For this reason,
  /// if you use this width, make sure the scrollbar is actually using this same theme.
  ///
  const DetectScroll({
    Key? key,
    required this.child,
  }) : super(key: key);

  /// Allows descendants to get the scroll state.
  /// Example:
  /// ```
  /// bool isPresent = DetectScrollable.of(context).isScrolled;
  /// double width = DetectScrollable.of(context).scrollbarWidth;
  /// ```
  static _DetectScrollableInherited of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<_DetectScrollableInherited>();

    assert(inherited != null, 'No DetectScrollable found in context');
    return inherited!;
  }

  @override
  State<DetectScroll> createState() => _DetectScrollState();
}

class _DetectScrollState extends State<DetectScroll> {
  late ValueNotifier<bool> canScrollNotifier;

  @override
  void initState() {
    super.initState();
    canScrollNotifier = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    canScrollNotifier.dispose();
    super.dispose();
  }

  /// If you're using the Material Scrollbar (or a theme that sets its thickness),
  /// this reads it from the current ScrollbarTheme. If you're NOT using Material,
  /// or if thickness is not set, return the default value (8.0 here).
  double get _materialScrollbarWidth {
    final scrollbarTheme = ScrollbarTheme.of(context);

    bool thumbVisibility =
        scrollbarTheme.thumbVisibility?.resolve(<WidgetState>{}) ?? true;
    bool trackVisibility =
        scrollbarTheme.trackVisibility?.resolve(<WidgetState>{}) ?? false;
    double thickness = scrollbarTheme.thickness?.resolve(<WidgetState>{}) ?? 8.0;
    double crossAxisMargin = scrollbarTheme.crossAxisMargin ?? 0.0;

    if (thumbVisibility == false)
      return 0.0;
    else
      return thickness + crossAxisMargin + (trackVisibility ? crossAxisMargin : 0);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        canScrollNotifier.value =
            metrics.hasContentDimensions && metrics.maxScrollExtent > 0;
        return true;
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: canScrollNotifier,
        builder: (_, _isScrolled, __) {
          return _DetectScrollableInherited(
            isScrolled: _isScrolled,
            scrollbarWidth: _materialScrollbarWidth,
            child: widget.child,
          );
        },
      ),
    );
  }
}

class _DetectScrollableInherited extends InheritedWidget {
  final bool isScrolled;
  final double scrollbarWidth;

  const _DetectScrollableInherited({
    Key? key,
    required Widget child,
    required this.isScrolled,
    required this.scrollbarWidth,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_DetectScrollableInherited oldWidget) {
    return oldWidget.isScrolled != isScrolled ||
        oldWidget.scrollbarWidth != scrollbarWidth;
  }
}
