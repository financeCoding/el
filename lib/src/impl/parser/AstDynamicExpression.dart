//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  09:59:00 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstDynamicExpression extends SimpleNode {
    AstDynamicExpression(int id)
        : super(id);

    //@Override
    ClassMirror getType(EvaluationContext ctx) {
        return this.children_[0].getType(ctx);
    }

    //@Override
    getValue(EvaluationContext ctx) {
        return this.children_[0].getValue(ctx);
    }

    //@Override
    bool isReadOnly(EvaluationContext ctx) {
        return this.children_[0].isReadOnly(ctx);
    }

    //@Override
    void setValue(EvaluationContext ctx, value) {
        this.children_[0].setValue(ctx, value);
    }
}
