import SwiftSyntax
import SwiftSyntaxMacros

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
