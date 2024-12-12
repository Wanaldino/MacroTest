import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct MacrosDictionaryPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        FooExpressionMacro.self,
        FooDeclarationMacro.self,
        FooPeerMacro.self,
        FooAccessorMacro.self,
        FooMemberMacro.self,
        FooMemberAttributeMacro.self,
        FooExtensionMacro.self,
        FooBodyMacro.self
    ]
}
