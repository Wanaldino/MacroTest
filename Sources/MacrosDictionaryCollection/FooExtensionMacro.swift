import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxBuilder

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
