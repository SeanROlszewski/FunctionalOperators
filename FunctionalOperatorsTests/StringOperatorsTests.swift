import XCTest
@testable import functional_forms

class StringOperatorsTests: XCTestCase {
    
    
    func test_withLengthOfFunction() {
        let lengthFunction = withLengthOf(5)
        XCTAssertEqual(lengthFunction("1234"), false)
    }
    

}
