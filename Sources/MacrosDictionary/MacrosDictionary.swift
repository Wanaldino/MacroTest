@freestanding(expression)
public macro FooExpression() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooExpressionMacro")

@freestanding(declaration, names: named(Foo))
public macro FooDeclaration() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooDeclarationMacro")

@attached(peer, names: named(foo))
public macro FooPeer() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooPeerMacro")

@attached(accessor)
public macro FooAccessor() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooAccessorMacro")

@attached(member, names: arbitrary)
public macro FooMember() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooMemberMacro")

@attached(memberAttribute)
public macro FooMemberAttribute() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooMemberAttributeMacro")

@attached(extension, names: arbitrary)
public macro FooExtension() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooExtensionMacro")

@attached(body)
public macro FooBody() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooBodyMacro")
