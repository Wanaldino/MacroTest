# Macros

## Types:

### Freestanding

#### Expression
Creates a piece of code that returns a value.

```swift
@freestanding(expression)
public macro FooExpression() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooExpressionMacro")
```
> names: Not accepted

```swift
public struct FooExpressionMacro: ExpressionMacro {
    public static func expansion(
        of node: some SwiftSyntax.FreestandingMacroExpansionSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> SwiftSyntax.ExprSyntax {
        "print(\"Hello foo\")"
    }
}
```

```swift
#FooExpression
---
print("Hello foo")
```

#### Declaration
Creates one or more declarations.

```swift
@freestanding(declaration, names: named(Foo))
public macro FooDeclaration() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooDeclarationMacro")
```
| names: optional |    Allowed    |
| -------------   |:-------------:|
| named(name)     |       ✅      |
| overloaded      |       ✅      |
| prefixed(prefix)|       ✅      |
| suffixed(suffix)|       ✅      |
| arbitrary       |       ⚠️      |
> arbitrary is not allowed at global scope

```swift
public struct FooDeclarationMacro: DeclarationMacro {
    public static func expansion(
        of node: some SwiftSyntax.FreestandingMacroExpansionSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        ["public struct Foo {}"]
    }
}
```

```swift
#FooDeclaration
---
public struct Foo {
}
```

### Attached

#### Peer
Adds new declarations alongside the declaration it’s applied to.

```swift
@attached(peer, names: named(foo))
public macro FooPeer() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooPeerMacro")
```
| names: required |    Allowed    |
| -------------   |:-------------:|
| named(name)     |       ✅      |
| overloaded      |       ✅      |
| prefixed(prefix)|       ✅      |
| suffixed(suffix)|       ✅      |
| arbitrary       |       ⚠️      |
> arbitrary is not allowed at global scope

```swift
public struct FooPeerMacro: PeerMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        ["func foo() { #FooExpression }"]
    }
}
```

```swift
@FooPeer
private func _foo() {}
---
func foo() {
    _foo()
}
```

#### Accessor
Accessor macros allow a macro to add accessors to a property, turning a stored property into a computed property.

```swift
@attached(accessor, names: arbitrary)
public macro FooAccessor() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooAccessorMacro")
```
| names: optional |    Allowed    |
| -------------   |:-------------:|
| named(name)     |       ✅      |
| overloaded      |       ✅      |
| prefixed(prefix)|       ✅      |
| suffixed(suffix)|       ✅      |
| arbitrary       |       ⚠️      |
> arbitrary is not allowed at global scope

```swift
public struct FooAccessorMacro: AccessorMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingAccessorsOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.AccessorDeclSyntax] {
        [
            "get { _foo }", 
            "set { _foo = newValue }"
        ]
    }
}
```

```swift
private var _foo = 1
@FooAccessor
var foo: Int
---
{
    get {
        _foo
    }
    set {
        _foo = newValue
    }
}
```

#### Member
Adds new declarations inside the type/extension it’s applied to.

```swift
@attached(member, names: arbitrary)
public macro FooMember() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooMemberMacro")
```
| names: required |    Allowed    |
| -------------   |:-------------:|
| named(name)     |       ✅      |
| overloaded      |       ✅      |
| prefixed(prefix)|       ✅      |
| suffixed(suffix)|       ✅      |
| arbitrary       |       ⚠️      |
> arbitrary is not allowed at global scope

```swift
public struct FooMemberMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        ["let foo = 1"]
    }
}
```

```swift
@FooMember
class FooMemberExample {
}
---
@FooMember
class FooMemberExample {
    let foo = 1
}
```

#### Member attribute
Adds attributes to the declarations in the type/extension it’s applied to.

```swift
@attached(memberAttribute)
public macro FooMemberAttribute() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooMemberAttributeMacro")
```
> names: Not accepted

```swift
public struct FooMemberAttributeMacro: MemberAttributeMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
        providingAttributesFor member: some SwiftSyntax.DeclSyntaxProtocol,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.AttributeSyntax] {
        ["@objc"]
    }
}
```

```swift
@FooMemberAttribute
class FooMemberAttributeExample {
    let foo = 1
}
---
@FooMemberAttribute
class FooMemberAttributeExample {
    @objc
    let foo = 1
}
```

#### Extension
Adds an extension to the attached type

```swift
@attached(extension, names: arbitrary)
public macro FooExtension() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooExtensionMacro")
```
| names: required |    Allowed    |
| -------------   |:-------------:|
| named(name)     |       ✅      |
| overloaded      |       ✅      |
| prefixed(prefix)|       ✅      |
| suffixed(suffix)|       ✅      |
| arbitrary       |       ⚠️      |
> arbitrary is not allowed at global scope

```swift
public struct FooExtensionMacro: ExtensionMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
        providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
        conformingTo protocols: [SwiftSyntax.TypeSyntax],
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        let declaration = """
            extension \(type.trimmed) {
                var foo: Int { 1 }
            }
            """

        return [try ExtensionDeclSyntax(SyntaxNodeString(stringLiteral: declaration))]
    }
}
```

```swift
@FooExtension
class FooExtensionExample {}
---
extension FooExtensionExample {
    var foo: Int {
        1
    }
}
```

#### Conformance
Adds conformances to protocols.

```swift
@attached(conformance)
public macro FooConformance() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooConformanceMacro")
```
> Deprecated: Conformance macros are replaced by extension macros

#### Body
Describes the body for a function that has or not

```swift
@attached(body)
public macro FooBody() = #externalMacro(module: "MacrosDictionaryCollection", type: "FooBodyMacro")
```
> names: Not accepted

```swift
struct FooBodyMacro: BodyMacro {
    static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingBodyFor declaration: some SwiftSyntax.DeclSyntaxProtocol & SwiftSyntax.WithOptionalCodeBlockSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.CodeBlockItemSyntax] {
        ["#FooExpression"]
    }
}
```

```swift
@FooBody
func foo() 
---
{
    #FooExpression
}
```
