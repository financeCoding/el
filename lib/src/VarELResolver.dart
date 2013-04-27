//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Sat, Sep 29, 2012  04:08:11 PM
// Author: hernichen

part of rikulo_el;

//issue3: resolve top level variable
class VarELResolver implements ELResolver {
  final bool _readOnly;

  VarELResolver([bool readOnly = false])
      : this._readOnly = readOnly;

  //@Override
  Object getValue(ELContext context, Object base, Object property) {
    if (context == null)
      throw new ArgumentError("context: null");

    if (base != null || property == null)
      return null;

    VariableMirror vm = _getVar(property);
    if (vm == null)
      return null;

    context.isPropertyResolved = true;
    return _getLib().getField(property).reflectee;
  }

  //@Override
  TypeMirror getType(ELContext context, Object base, Object property) {
    if (context == null)
      throw new ArgumentError("context: null");

    if (base != null || property == null)
      return null;

    VariableMirror vm = _getVar(property);
    if (vm == null)
      return null;

    context.isPropertyResolved = true;
    return vm.type;
  }

  //@Override
  void setValue(ELContext context, Object base, Object property, Object value) {
    if (context == null) {
      throw new ArgumentError("context: null");
    }
    if (base != null || property == null) {
      return;
    }

    VariableMirror vm = _getVar(property);
    if (vm == null)
      return;

    context.isPropertyResolved = true;

    if (this._readOnly)
      throw new PropertyNotWritableException(message(context,
               "resolverNotWriteable", [property]));

    _getLib().setField(property, value);
  }

  //@Override
  bool isReadOnly(ELContext context, Object base, Object property) {
    if (context == null)
      throw new ArgumentError("context: null");

    if (base != null || property == null)
      return false;

    VariableMirror vm = _getVar(property);
    if (vm == null)
      return false;

    context.isPropertyResolved = true;
    return this._readOnly || vm.isFinal;
  }

  //@Override
  ClassMirror getCommonPropertyType(ELContext context, Object base) {
    if (context == null)
      throw new ArgumentError("context: null");

    return base == null ? OBJECT_MIRROR : null;
  }

  //@Override
  Object invoke(ELContext context, Object base, Object method,
                List params, [Map<String, Object> namedArgs]) => null;

  LibraryMirror _getLib() {
    return currentMirrorSystem().isolate.rootLibrary;
  }

  VariableMirror _getVar(Object property) {
    LibraryMirror lm = currentMirrorSystem().isolate.rootLibrary;
    return lm != null ? lm.variables[new Symbol(property)] : null;
  }
}
