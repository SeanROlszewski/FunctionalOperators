import Quick
import Nimble
@testable import FunctionalOperators

class StringOperatorsTests: QuickSpec {
    override func spec() {
        describe("withLengthOf") {
            it("returns false when validating a string that doesn't match the length argument") {
                var lengthFunction = withLengthOf(5)
                expect(lengthFunction("1234")).to(equal(false))
                expect(lengthFunction("123456")).to(equal(false))
                
                lengthFunction = withLengthOf(4)
                expect(lengthFunction("123")).to(equal(false))
                expect(lengthFunction("12345")).to(equal(false))
                
                lengthFunction = withLengthOf(3)
                expect(lengthFunction("12")).to(equal(false))
                expect(lengthFunction("1234")).to(equal(false))
            }
            
            it("returns true only when validating a string that matches the length argument") {
                var lengthFunction = withLengthOf(5)
                expect(lengthFunction("12345")).to(equal(true))
                
                lengthFunction = withLengthOf(4)
                expect(lengthFunction("1234")).to(equal(true))
                
                lengthFunction = withLengthOf(3)
                expect(lengthFunction("123")).to(equal(true))
            }
        }
        describe("matchingRegularExpression") {
            
            let containsOnlyDigits = try! NSRegularExpression(pattern: "^[0-9]*$",
                                                              options: .anchorsMatchLines)
            let regularExpressionFunction = matchingRegularExpression(containsOnlyDigits)
            
            it("returns true when the regular expression matches 1 instance") {
                expect(regularExpressionFunction("12345")).to(equal(true))
                expect(regularExpressionFunction("600908000000")).to(equal(true))
                expect(regularExpressionFunction("3")).to(equal(true))
                expect(regularExpressionFunction("999")).to(equal(true))
            }
            
            it("returns false only when the regular expression doesn't pattern match anything") {
                expect(regularExpressionFunction("a12345")).to(equal(false))
                expect(regularExpressionFunction("a")).to(equal(false))
                expect(regularExpressionFunction("!")).to(equal(false))
                expect(regularExpressionFunction("a!")).to(equal(false))
                expect(regularExpressionFunction("space")).to(equal(false))
                expect(regularExpressionFunction(" ")).to(equal(false))
            }
        }
    }
}
