import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';

class AutoCompleteLink {
  final LayerLink _link = LayerLink();

  _AutoCompleteFieldState? _field;
  _AutoCompleteListState? _list;

  bool get isLinked => _field != null && _list != null;

  void showList() {
    assert(isLinked);
    if (isLinked) {
      _list!._show();
    }
  }

  void hideList() {
    assert(isLinked);
    if (isLinked) {
      _list!._hide();
    }
  }

  void toggleList() {
    assert(isLinked);
    if (isLinked) {
      _list!._toggle();
    }
  }

  void updateList(String value) {
    assert(isLinked);
    if (isLinked) {
      _list!._updateList(value);
    }
  }

  void _linkField(_AutoCompleteFieldState field) {
    _field = field;
  }

  void _linkList(_AutoCompleteListState list) {
    _list = list;
  }

  void dispose() {
    _field = null;
    _list = null;
  }
}

class AutoCompleteField extends StatefulWidget {
  AutoCompleteField({super.key, required this.link, TextEditingController? textEditingController}) {
    this.textEditingController = textEditingController ?? TextEditingController();
  }

  final AutoCompleteLink link;
  late final TextEditingController textEditingController;

  @override
  State<AutoCompleteField> createState() => _AutoCompleteFieldState();
}

class _AutoCompleteFieldState extends State<AutoCompleteField> {
  @override
  void initState() {
    super.initState();
    widget.link._linkField(this);
  }

  @override
  void dispose() {
    super.dispose();
    widget.link.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: widget.link._link,
      child: TextField(
        controller: widget.textEditingController,
        onTap: () => widget.link.showList(),
        onChanged: (val) => widget.link.showList(),
        onEditingComplete: () => widget.link.hideList(),
        onSubmitted: (val) => widget.link.hideList(),
        onTapOutside: (event) => widget.link.hideList(),
      ),
    );
  }
}

class AutoCompleteValue<T> extends StatelessWidget {
  const AutoCompleteValue({super.key, required this.value, required this.child});

  final T value;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class AutoCompleteList<T> extends StatefulWidget {
  const AutoCompleteList({super.key, required this.link, required this.optionsSupplier, required this.optionBuilder, required this.onSelect});

  final AutoCompleteLink link;
  final Iterable<T> Function(String) optionsSupplier;
  final Widget Function(T) optionBuilder;
  final void Function(T, TextEditingController) onSelect;

  @override
  State<AutoCompleteList<T>> createState() => _AutoCompleteListState<T>();
}

class _AutoCompleteListState<T> extends State<AutoCompleteList<T>> {

  bool _shown = false;
  Iterable<T> options = Iterable.empty();

  void _show() {
    if (_shown) return;
    setState(() {
      _shown = true;
    });
  }

  void _hide() {
    if (!_shown) return;
    setState(() {
      _shown = false;
    });
  }

  void _toggle() {
    setState(() {
      _shown = !_shown;
    });
  }

  void _updateList(String input) {
    setState(() {
      _shown = true;
      options = widget.optionsSupplier.call(input);
    });
  }

  @override
  void initState() {
    super.initState();
    widget.link._linkList(this);
  }

  @override
  void dispose() {
    super.dispose();
    widget.link.dispose();
  }

  List<Widget> _buildList() {
    List<Widget> widgets = [];
    for (T t in options) {
      widgets.add(InkWell(onTap: () {
        widget.onSelect.call(t, widget.link._field!.widget.textEditingController);
      }, child: AutoCompleteValue(value: t, child: widget.optionBuilder.call(t))));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 300,
      child: ListView(
        children: _buildList(),
      )
    );
  }
}
