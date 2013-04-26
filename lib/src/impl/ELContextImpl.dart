//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 24, 2012  12:31:05 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class ELContextImpl extends ELContext {
  static final ELResolver _DefaultResolver =
      new CompositeELResolver()
        ..add(new VarELResolver()) //issue3: resolve top level variable
        ..add(new MapELResolver())
        ..add(new ArrayELResolver())
        ..add(new BeanELResolver());

  final ELResolver _resolver;

  FunctionMapper _functionMapper;

  VariableMapper _variableMapper;

  Map _attrs;

  ELContextImpl([ELResolver resolver])
      : this._resolver = resolver == null ? getDefaultResolver() : resolver,
        super.init();

  //@Override
  ELResolver getELResolver() {
    return this._resolver;
  }

  //@Override
  FunctionMapper getFunctionMapper() {
    return this._functionMapper;
  }

  //@Override
  VariableMapper getVariableMapper() {
    if (this._variableMapper == null)
      this._variableMapper = new VariableMapperImpl();
    return this._variableMapper;
  }

  //20120928, henrichen: provide a general attribute carrier
  //@Override
  getAttribute(var key)
    => _attrs == null ? null : _attrs[key];

  //20120928, henrichen: provide a general attribute carrier
  //@Override
  setAttribute(var key, Object val) {
    if (_attrs == null)
      _attrs = new Map();
    var old = _attrs[key];
    _attrs[key] = val;

    return old;
  }

  void setFunctionMapper(FunctionMapper functionMapper) {
      this._functionMapper = functionMapper;
  }

  void setVariableMapper(VariableMapper variableMapper) {
      this._variableMapper = variableMapper;
  }

  static ELResolver getDefaultResolver() {
     return _DefaultResolver;
  }
}
