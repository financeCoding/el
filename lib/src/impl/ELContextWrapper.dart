//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 24, 2012  01:03:10 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class ELContextWrapper extends ELContextImpl implements ELContext {

    final ELContext _target;
    final FunctionMapper _fnMapper;

    ELContextWrapper(ELContext target, FunctionMapper fnMapper)
        : this._target = target,
          this._fnMapper = fnMapper;

    //@Override
    ELResolver get resolver => this._target.resolver;

    //@Override
    FunctionMapper get functionMapper {
        if (this._fnMapper != null) return this._fnMapper;
        return this._target.functionMapper;
    }

    //@Override
    VariableMapper get variableMapper {
        return this._target.variableMapper;
    }

    //@Override
    Object getContext(ClassMirror key) {
        return this._target.getContext(key);
    }

    //@Override
    String get locale => this._target.locale;


    //@Override
    bool get isPropertyResolved => this._target.isPropertyResolved;

    //@Override
    void putContext(ClassMirror key, Object contextObject) {
        this._target.putContext(key, contextObject);
    }

    //@Override
    void set locale(String locale) {
        this._target.locale = locale;
    }

    //@Override
    void set isPropertyResolved(bool resolved) {
        this._target.isPropertyResolved = resolved;
    }

}
