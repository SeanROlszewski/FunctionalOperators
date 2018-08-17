import XCTest
@testable import FunctionalOperators

class FunctionCompositionOperatorTests: XCTestCase {
    
    func test_itComposesFunctionsTogether() {
        
        let passBooleanThrough: (Bool) -> Bool = { $0 }
        let invertBoolean: (Bool) -> Bool = { !$0 }
        
        let composedFunction = passBooleanThrough &&& invertBoolean
        let anotherComposedFunction = passBooleanThrough &&& invertBoolean &&& invertBoolean
        
        XCTAssertFalse(composedFunction(true))
        XCTAssert(anotherComposedFunction(true))
        
        let passIntegerThrough: (Int) -> Int = { $0 }
        let incrementInteger: (Int) -> Int = { $0 + 1 }
        
        let increaseIntegerBy1 = passIntegerThrough &&& incrementInteger
        XCTAssertEqual(increaseIntegerBy1(0), 1)
        
        let increaseIntegerBy2 = passIntegerThrough &&& incrementInteger &&& incrementInteger
        XCTAssertEqual(increaseIntegerBy2(0), 2)
    }
}

class BooleanFunctionCompositionOperatorTests: XCTestCase {
    
    func test_itComposesFunctionsTogether() {
        
        let lengthChecker: (String) -> Bool = { $0.count == 3 ||  $0.count == 4 }
        let containsNumbers: (String) -> Bool = {
            return $0.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
        }
        
        XCTAssertEqual(containsNumbers("some!text"), false)
        XCTAssertEqual(containsNumbers("555"), true)
        
        let cvvChecker = lengthChecker &&~ containsNumbers
        XCTAssertEqual(cvvChecker("555"), true)
        XCTAssertEqual(cvvChecker("432"), true)
        XCTAssertEqual(cvvChecker("5555"), true)
        XCTAssertEqual(cvvChecker("1234"), true)
        
        XCTAssertEqual(cvvChecker(""), false)
        XCTAssertEqual(cvvChecker("5"), false)
        XCTAssertEqual(cvvChecker("55"), false)
        
    }
}
