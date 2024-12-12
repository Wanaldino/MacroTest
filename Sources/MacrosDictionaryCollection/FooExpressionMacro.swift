import SwiftSyntax
import SwiftSyntaxMacros

public struct FooExpressionMacro: ExpressionMacro {
    public static func expansion(
        of node: some SwiftSyntax.FreestandingMacroExpansionSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> SwiftSyntax.ExprSyntax {
        "print(\"Hello foo\")"
    }
}
