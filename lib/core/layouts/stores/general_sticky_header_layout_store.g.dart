// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_sticky_header_layout_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GeneralStickyHeaderLayoutStore
    on _GeneralStickyHeaderLayoutStoreBase, Store {
  late final _$centerContainerHeightAtom = Atom(
      name: '_GeneralStickyHeaderLayoutStoreBase.centerContainerHeight',
      context: context);

  @override
  double get centerContainerHeight {
    _$centerContainerHeightAtom.reportRead();
    return super.centerContainerHeight;
  }

  @override
  set centerContainerHeight(double value) {
    _$centerContainerHeightAtom.reportWrite(value, super.centerContainerHeight,
        () {
      super.centerContainerHeight = value;
    });
  }

  late final _$headerContainerHeightAtom = Atom(
      name: '_GeneralStickyHeaderLayoutStoreBase.headerContainerHeight',
      context: context);

  @override
  double get headerContainerHeight {
    _$headerContainerHeightAtom.reportRead();
    return super.headerContainerHeight;
  }

  @override
  set headerContainerHeight(double value) {
    _$headerContainerHeightAtom.reportWrite(value, super.headerContainerHeight,
        () {
      super.headerContainerHeight = value;
    });
  }

  late final _$expandedHeightAtom = Atom(
      name: '_GeneralStickyHeaderLayoutStoreBase.expandedHeight',
      context: context);

  @override
  double get expandedHeight {
    _$expandedHeightAtom.reportRead();
    return super.expandedHeight;
  }

  @override
  set expandedHeight(double value) {
    _$expandedHeightAtom.reportWrite(value, super.expandedHeight, () {
      super.expandedHeight = value;
    });
  }

  late final _$titleHeightAtom = Atom(
      name: '_GeneralStickyHeaderLayoutStoreBase.titleHeight',
      context: context);

  @override
  double get titleHeight {
    _$titleHeightAtom.reportRead();
    return super.titleHeight;
  }

  @override
  set titleHeight(double value) {
    _$titleHeightAtom.reportWrite(value, super.titleHeight, () {
      super.titleHeight = value;
    });
  }

  late final _$depthAtom =
      Atom(name: '_GeneralStickyHeaderLayoutStoreBase.depth', context: context);

  @override
  double get depth {
    _$depthAtom.reportRead();
    return super.depth;
  }

  @override
  set depth(double value) {
    _$depthAtom.reportWrite(value, super.depth, () {
      super.depth = value;
    });
  }

  late final _$isAppBarExpandedAtom = Atom(
      name: '_GeneralStickyHeaderLayoutStoreBase.isAppBarExpanded',
      context: context);

  @override
  bool get isAppBarExpanded {
    _$isAppBarExpandedAtom.reportRead();
    return super.isAppBarExpanded;
  }

  @override
  set isAppBarExpanded(bool value) {
    _$isAppBarExpandedAtom.reportWrite(value, super.isAppBarExpanded, () {
      super.isAppBarExpanded = value;
    });
  }

  @override
  String toString() {
    return '''
centerContainerHeight: ${centerContainerHeight},
headerContainerHeight: ${headerContainerHeight},
expandedHeight: ${expandedHeight},
titleHeight: ${titleHeight},
depth: ${depth},
isAppBarExpanded: ${isAppBarExpanded}
    ''';
  }
}
