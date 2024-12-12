import SwiftSyntax
import SwiftSyntaxMacros

struct FooDeclarationMacro: DeclarationMacro {
    public static func expansion(
        of node: some SwiftSyntax.FreestandingMacroExpansionSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        ["public struct Foo {}"]
    }
}
