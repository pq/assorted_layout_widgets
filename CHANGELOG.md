Sponsored by [MyText.ai](https://mytext.ai)

[![](./example/SponsoredByMyTextAi.png)](https://mytext.ai)

## 11.0.0

* Breaking change: The signature of the builders of `TimeBuilder` have been changed.
  They all now use **named** parameters, and also get a new `initialTime` parameter that
  was not present before. Migration should be straightforward, Refer to the README for
  more information.

## 10.7.0

* The `ScrollShadow` widget adds a shadow at the top and/or bottom, to scrollables like
  `SingleChildScrollView` or `ListView` etc., when the content doesn't fit the
  scrollable's viewport. As the shadow appears only if there is content outside the
  viewable area, this gives the user an indication if there is more content to be seen
  or not.

## 10.6.1

* The `DetectScroll` widget can detect if the content of a Scrollable is larger than the
  Scrollable itself, which means that the content can be scrolled, and that a scrollbar
  is likely visible. It can also tell you the probable width of that scrollbar.

  This is useful for positioning widgets relative to the scrollbar, so that the
  scrollbar doesn't overlap them. This can be important when the scrollbar is
  permanently visible, usually on the Web and desktop.

  Note that `DetectScroll` will only detect the scrolling of its **closest** scrollable
  descendant (a scrollable is a `SingleChildScrollView`, `ListView`, `GridView` etc).
  Usually, you'd wrap the scrollable you care about directly with a `DetectScroll`.
  For example:

  ```
  DetectScroll(
   child: SingleChildScrollView(
      child: Column( ...
   ...
  );
  ```

  To get the current scroll state and the scrollbar width, descendants can call:

  ```
  bool canScroll = DetectScroll.of(context).canScroll;
  double scrollbarWidth = DetectScroll.of(context).scrollbarWidth;
  ```

  For example, suppose you want to add a help button to the top-right corner of a
  scrollable, and account for the scrollbar width only if it's visible:

  ```
  bool canScroll = DetectScroll.of(context).canScroll;
  double scrollbarWidth = DetectScroll.of(context).scrollbarWidth;
  
  return Stack(
    children: [
       child,
       Positioned(
          right: canScroll ? scrollbarWidth : 0,
          top: 0,
          child: HelpButton(),
       ),
    ],
  );
  ```

  Another alternative is using the optional `onChange` callback of the `DetectScroll`:

  ```
  DetectScroll(
     onChange: ({
        required bool canScroll,
        required double scrollbarWidth,
     }) {
        // Do something.
     }
     child: ...
  ),
  ```     

## 10.5.0

* The `SideBySide` widget now has a `mainAxisSize` property the determines whether it
  will occupy the full available width (`MainAxisSize.max`) or only as much as it
  needs (`MainAxisSize.min`).

## 10.3.0

* `CircleButton` now accepts an optional custom builder function to modify the button's
  child widget. This can be used to animate the button when the button is tapped,
  or when the mouse is over it. For example:

  ```
  CircleButton(
     icon: Icon(Icons.shopping_cart),     
     builder: ({
        required bool isHover,
        required bool isPressed,
        required Widget child,
     }) =>
         AnimatedScale(
            scale: isPressed ? 0.85 : 1.0,
            duration: const Duration(milliseconds: 50),
            child: child,
       ),
     );
  ```  

  Try running
  the [example](https://github.com/marcglasberg/assorted_layout_widgets/blob/master/example/lib/main_button_and_circle_button.dart).

## 10.2.4

* `SideBySide` widget now allows for any number of children, not just two. Example:

  ```
  SideBySide(
     children: [
       Text("Hello!", textWidthBasis: TextWidthBasis.longestLine),
       Text("How are you?", textWidthBasis: TextWidthBasis.longestLine),
       Text("I'm good, thank you.", textWidthBasis: TextWidthBasis.longestLine),
     ],
     gaps: [8.0, 12.0],
  );
  ```

  The `SideBySide` widget achieves layouts that are not possible with `Row` or `RowSuper`
  widgets. Read the documentation for more information.

  **Deprecated usage:** The `startChild` and `endChild` parameters are deprecated.
  Use the `children` parameter instead. The `innerDistance` parameter is also deprecated.
  Use the `gaps` parameter instead.

  For example, this deprecated code:

  ```
  return SideBySide(
    startChild: Text("Hello!", textWidthBasis: TextWidthBasis.longestLine),
    endChild: Text("How are you?", textWidthBasis: TextWidthBasis.longestLine),
    innerDistance: 8.0,
  );
  ```

  Should be replaced with:

  ```
  return SideBySide(
    children: [
      Text("Hello!", textWidthBasis: TextWidthBasis.longestLine),
      Text("How are you?", textWidthBasis: TextWidthBasis.longestLine),
    ],
    gaps: [8.0],
  );
  ```

## 10.1.2

* The `Box` widget can now have a `decoration`, as well as a `decorationPosition`.
  Previously, if a `Container` had a decoration you could not replace it with a `Box`,
  but now you can. Note the `Box` is a little more flexible than the `Container` when you
  define a `color` and a `BoxDecoration` or a `ShapeDecoration` at the same time, as
  the `Box` will only throw an error if the `color` is defined twice.

* You can use `Box.gap()` to create a small gap between widgets:

  ```
  Column(
    children: [
      Text('A'),
      const Box.gap(8), // 8.0 pixel gap
      Text('B'),
    ]);
  ```

## 10.0.4

* Fixed `GestureDetector` ordering issue for `RowSuper` and `ColumnSuper` when
  the `invert` param is `true`.

## 10.0.3

* Removed `KeyboardDismiss` dependency on `dart:io` to make it compatible with platform
  web.

* Now `CircleButton` can specify `hoverColor` (default is no color),
  and `cursor` (the default is `SystemMouseCursors.click`, but you can pass `null` to
  set it as `MouseCursor.defer`.

## 9.0.2

* Added `Pad.addValues` and `Pad.subtractValues`.

## 9.0.1

* Flutter 3.16.0 compatible.

## 8.0.5

* const WrapSuper.

## 8.0.4

* Removed deprecated `TextOneLineEllipsisWithFade` widget. Please use `TextOneLine`
  instead.

## 7.0.1

* Fixed letter-spacing for TextOneLine, whe the style is defined inline.

## 7.0.0

* Flutter 3.3.0 (Dart 2.18.0).

* `TextOneLineEllipsisWithFade` deprecated. Please use `TextOneLine` instead.

## 6.1.1

* `KeyboardDismiss`.

## 6.0.0

* Flutter 3.0.

## 5.8.5

* `NonUniformOutlineInputBorder` and `NonUniformRoundedRectangleBorder` widgets.

## 5.7.1

* `CaptureGestures` widget.

## 5.6.1

* `Button` and `CircleButton` widgets.

## 5.5.0

* `SideBySide` widget.

## 5.4.1

* `MaskFunctionTextInputFormatter` input formatter (for `Text` widgets).

## 5.3.0-dev0

* `ColumnSuper` parameter: `removeChildrenWithNoHeight`.
  See <a href="https://github.com/marcglasberg/assorted_layout_widgets/blob/master/example/lib/main_column_removing_zero_height.dart">
  this example</a>.

## 5.2.1

* `GlobalValueKey` and `GlobalStringKey`.

## 5.1.3

* Upgrade to Flutter 2.5.1

## 5.1.1

* Fixed alignment bug in `RowSuper` when `fill: true` and `MainAxisSize.max` and
  `Alignment.center`.

## 5.1.0

* `TimeBuilder` widget.

## 5.0.3

* `Box.copyWith()` method.

* Now `Box` can be changed by using the `operator +`. For example, to hide the
  box: `Box(...) + false;`. To change the box color: `Box(...) + Colors.green;`. To change
  the box
  padding: `Box(...) + Pad(all: 10);`. To substitute the box child:
  `Box(...) + Text('abc');`. To
  put a box inside of another: `Box(...) + Box(...);`.

## 5.0.2

* Now `TextOneLine` is more similar to the native `Text` widget, in preparation for when
  https://github.com/flutter/flutter/issues/18761 is fixed. You probably won't notice the
  difference
  and may continue using it as usual.

## 5.0.1

* `showCupertinoDialogSuper`.

* The `onDismissed` callback parameter for `showDialogSuper` is called when the dialog is
  dismissed.
  That's still the case, but now that callback gets the `result` of the dialog, when the
  dialog is
  popped by `Navigator.of(context).pop(result)`. That way you can differentiate between
  the dialog
  being dismissed by an Ok or a Cancel button, for example. Note `result` is `null` when
  the dialog
  is dismissed by tapping the barrier or pressing BACK in Android. Example:

  ```                                                                             
  showDialogSuper<int>(
  ...
    actions: [
      ElevatedButton( onPressed: (){Navigator.pop(context, 1);}, child: const Text("OK"),
      ElevatedButton( onPressed: (){Navigator.pop(context, 2);}, child: const Text("CANCEL"),        
    ]
    ...
    onDismissed: (int? result) {
      if (result == 1) print("Pressed the OK button.");
      else if (result == 2) print("Pressed the CANCEL button.");
      else if (result == null) print("Dismissed with BACK or tapping the barrier.");  
    });  
  ```

## 4.0.10

* Fixed bug in `WrapSuper` intrinsic height.

## 4.0.9

* `showDialogSuper` method is identical to the native `showDialog`, except that it lets
  you define a
  callback for when the dialog is dismissed.

## 4.0.8

* Fixed important bug in `FitHorizontally` widget (and `RowSuper` when using the
  `fitHorizontally`
  parameter).

## 4.0.7

* `NormalizedOverflowBox` widget.

## 4.0.5

* `WrapSuper.wrapFit` parameter.
* `ButtonBarSuper` parameter.
* New examples:
  <a href="https://github.com/marcglasberg/assorted_layout_widgets/blob/master/example/lib/main_wrap_super_fit.dart">
  WrapSuper WrapFit Example</a>
  and
  <a href="https://github.com/marcglasberg/assorted_layout_widgets/blob/master/example/lib/main_button_bar_super.dart">
  ButtonBarSuper Example</a>

## 4.0.2

* `Pad.copyWith()`.

## 4.0.1

* Fixed NNBD problem: `TextOneLine` as child of an intrinsic size widget.

## 4.0.0

* Nullsafety.
* `RowSuper` horizontal alignment now applied when there are no `RowSpacer`s and
  `MainAxisSize`
  is `max`.

## 3.0.1

* Breaking change: The `Box` widget now has a `padding` parameter. I recommend you use it
  with the
  new `Pad` class. For example: `Box(padding: Pad(top: 4.0))`. The `Pad` class solves the
  verbosity
  problem, and having a `padding` parameter makes `Box` more compatible with `Container` (
  remember `Box` is like a `Container` which can be made `const`, so it's best if their
  parameters
  are not too different).

* The debugging constructors of the `Box` widget are now marked as deprecated so that you
  don't
  forget to remove them (they are not really deprecated).

## 2.0.1

* `Pad` class.

## 2.0.0

* Support for Flutter 1.22.

## 1.3.6

* Docs improvement.
* Fixed edge case for `RowSuper`.

## 1.3.4

* Docs improvement.

## 1.3.3

* RowSuper: `fill` parameter.

## 1.3.2

* `Delayed` widget.

## 1.2.0

* Breaking Change: `ColumnSuper` width is now the max intrinsic width of its children,
  just like a
  regular `Column`. To restore old
  behavior: `Container(width: double.infinity, child: ColumnSuper(...))`.
* Breaking Change: `RowSuper` height is now the max intrinsic height of its children, just
  like a
  regular `Row`. To restore old behavior:
  `Container(height: double.infinity, child: RowSuper(...))`
  .
* New examples:
  <a href="https://github.com/marcglasberg/assorted_layout_widgets/blob/master/example/lib/main_column_super_playground.dart">
  ColumnSuper Playground</a>
  and
  <a href="https://github.com/marcglasberg/assorted_layout_widgets/blob/master/example/lib/main_row_super_playground.dart">
  RowSuper Playground</a>.

## 1.1.4

* Fix: `ColumnSuper` intrinsic height, and `RowSuper` intrinsic width.

## 1.1.3

* Fix: `WrapSuper` minimum raggedness algorithm now uses the correct
  JavaScript's `Number.MAX_SAFE_INTEGER`.
* Fix: Divide by zero conditions.

## 1.1.1

* Docs improvement.

## 1.1.0

* Upgraded to Flutter 1.17.

## 1.0.18

* `WrapSuper`.

## 1.0.15

* Box now has `vertical` and `horizontal` as constructor parameters.

## 1.0.14

* `TextOneLine` that fixes https://github.com/flutter/flutter/issues/18761.

## 1.0.13

* Alignment fix.

## 1.0.12

* `Box`.

## 1.0.10

* `FitHorizontally` widget.
* `RowSpacer` widget.

## 1.0.0

* `RowSuper` and `ColumnSuper` widgets.
