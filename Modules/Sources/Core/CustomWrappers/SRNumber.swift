import Foundation

@propertyWrapper
/// SR - Prefix for StarRepo
public struct SRNumber {
    private let value: Int
    public var wrappedValue: NSNumber
    
    public init(wrappedValue: NSNumber) {
        self.wrappedValue = wrappedValue
        value = wrappedValue.intValue
    }
}

extension SRNumber: Decodable {
    public init(from decoder: Decoder) throws {
        value = try Int(from: decoder)
        wrappedValue = NSNumber(value: value)
    }
}

extension SRNumber: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue.intValue)
    }
}

extension SRNumber: Equatable {}
