import Quick
import Nimble
@testable import FunctionalOperators

class OperatorTests: QuickSpec {
    override func spec() {
        describe("the &&& operator") {
            it("composes functions") {
                
                let passBooleanThrough: (Bool) -> Bool = { $0 }
                let invertBoolean: (Bool) -> Bool = { !$0 }
                
                let composedFunction = passBooleanThrough &&& invertBoolean
                let anotherComposedFunction = passBooleanThrough &&& invertBoolean &&& invertBoolean
                
                expect(composedFunction(true)).to(beFalse())
                expect(anotherComposedFunction(true)).to(beTrue())
                
                let passIntegerThrough: (Int) -> Int = { $0 }
                let incrementInteger: (Int) -> Int = { $0 + 1 }
                
                let increaseIntegerBy1 = passIntegerThrough &&& incrementInteger
                expect(increaseIntegerBy1(0)).to(equal(1))
                
                let increaseIntegerBy2 = passIntegerThrough &&& incrementInteger &&& incrementInteger
                expect(increaseIntegerBy2(0)).to(equal(2))
            }
        }
        
        describe("the &&~ operator") {
            it("composes functions expecting one type and which return a boolean") {
                
                let lengthChecker: (String) -> Bool = { $0.count == 3 ||  $0.count == 4 }
                let containsNumbers: (String) -> Bool = {
                    return $0.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
                }
                expect(containsNumbers("some!text")).to(equal(false))
                expect(containsNumbers("555")).to(equal(true))
                
                let cvvChecker = lengthChecker &&~ containsNumbers
                expect(cvvChecker("555")).to(equal(true))
                expect(cvvChecker("432")).to(equal(true))
                expect(cvvChecker("5555")).to(equal(true))
                expect(cvvChecker("1234")).to(equal(true))
                
                expect(cvvChecker("")).to(equal(false))
                expect(cvvChecker("5")).to(equal(false))
                expect(cvvChecker("55")).to(equal(false))
            }
        }
    }
}
