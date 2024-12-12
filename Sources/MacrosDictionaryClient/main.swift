import MacrosDictionary
import Foundation

// MARK: FooExpression
#FooExpression







// MARK: FooDeclaration
#FooDeclaration
class FooDeclarationExample {
    #FooDeclaration
}
print("FooDeclarationExample: ", FooDeclarationExample.Foo())







// MARK: FooPeer
class FooPeerExample {
    @FooPeer
    private func _foo() {
        #FooExpression
    }
}
FooPeerExample().foo()







// MARK: FooAccessor
class FooAccessorExample {
    private var _foo = 1
    @FooAccessor
    var foo: Int
}
let fooAccessorExample = FooAccessorExample()
print("FooAccessorExample: ", fooAccessorExample.foo)
fooAccessorExample.foo = 2
print("FooAccessorExample: ", fooAccessorExample.foo)







// MARK: FooMemberAttribute
@FooMemberAttribute
class FooMemberAttributeExample {
    let foo = 1
}
print("FooMemberAttributeExample: ", FooMemberAttributeExample().foo)







// MARK: FooMember
@FooMember
class FooMemberExample {
}
print(FooMemberExample().foo)







// MARK: FooExtension
@FooExtension
class FooExtensionExample {}
print("FooExtensionExample: ", FooExtensionExample().foo)







// MARK: FooBody
@FooBody
func foo() {
    print("Hola")
}

foo()
