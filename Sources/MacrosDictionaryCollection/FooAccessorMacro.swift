import SwiftSyntax
import SwiftSyntaxMacros

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
