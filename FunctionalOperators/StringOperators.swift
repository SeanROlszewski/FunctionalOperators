import Foundation

func withLengthOf(_ length: Int) -> (String) -> (Bool) {
    return { $0.count == length }
}

func containingCharactersFrom(_ sets: CharacterSet...) -> (String) -> (Bool) {
    return { _ in false}
}

func notContainingCharactersFrom(_ sets: CharacterSet...) -> (String) -> (Bool) {
    return { _ in false}
}

func matchingRegularExpression(_ regex: NSRegularExpression) -> (String) -> (Bool) {
    return {
        regex.numberOfMatches(in: $0, options: .anchored, range: .init(location: 0, length: $0.count)) == 1
    }
}
