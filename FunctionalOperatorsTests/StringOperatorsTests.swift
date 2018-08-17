import XCTest
@testable import FunctionalOperators

class StringOperatorsTests: XCTestCase {
    
    func test_withLengthOfFunction_returnsFalseWhenTheLengthParameterIsNotMet() {
        var lengthFunction = withLengthOf(5)
        XCTAssertEqual(lengthFunction("1234"), false)
        XCTAssertEqual(lengthFunction("123456"), false)
        
        lengthFunction = withLengthOf(4)
        XCTAssertEqual(lengthFunction("123"), false)
        XCTAssertEqual(lengthFunction("12345"), false)
        
        lengthFunction = withLengthOf(3)
        XCTAssertEqual(lengthFunction("12"), false)
        XCTAssertEqual(lengthFunction("1234"), false)
    }
    
    func test_withLengthOfFunction_returnsTrueWhenTheLengthParameterIsMet() {
        var lengthFunction = withLengthOf(5)
        XCTAssertEqual(lengthFunction("12345"), true)
        
        lengthFunction = withLengthOf(4)
        XCTAssertEqual(lengthFunction("1234"), true)
        
        lengthFunction = withLengthOf(3)
        XCTAssertEqual(lengthFunction("123"), true)
    }
    
    func test_matchingRegularExpression_returnsTrueWhenTheRegularExpressionIsMet() {
        let containsOnlyDigits = try! NSRegularExpression(pattern: "^[0-9]*$",
                                                          options: .anchorsMatchLines)
        let regularExpressionFunction = matchingRegularExpression(containsOnlyDigits)
        
        XCTAssertEqual(regularExpressionFunction("12345"), true)
        XCTAssertEqual(regularExpressionFunction("600908000000"), true)
        XCTAssertEqual(regularExpressionFunction("3"), true)
        XCTAssertEqual(regularExpressionFunction("999"), true)
    }
    
    func test_matchingRegularExpression_returnsFalseWhenTheRegularExpressionIsNotMet()
    {
        let containsOnlyDigits = try! NSRegularExpression(pattern: "^[0-9]*$",
                                                          options: .anchorsMatchLines)
        let regularExpressionFunction = matchingRegularExpression(containsOnlyDigits)

        XCTAssertEqual(regularExpressionFunction("a12345"), false)
        XCTAssertEqual(regularExpressionFunction("a"), false)
        XCTAssertEqual(regularExpressionFunction("!"), false)
        XCTAssertEqual(regularExpressionFunction("a!"), false)
        XCTAssertEqual(regularExpressionFunction("space"), false)
        XCTAssertEqual(regularExpressionFunction(" "), false)
    }
}
