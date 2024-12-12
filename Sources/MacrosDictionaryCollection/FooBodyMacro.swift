import SwiftSyntax
import SwiftSyntaxMacros

struct FooBodyMacro: BodyMacro {
    static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingBodyFor declaration: some SwiftSyntax.DeclSyntaxProtocol & SwiftSyntax.WithOptionalCodeBlockSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.CodeBlockItemSyntax] {
        var list = declaration.body?.statements ?? CodeBlockItemListSyntax()
        list.append(CodeBlockItemSyntax("#FooExpression"))
        return Array(list)
    }
}
