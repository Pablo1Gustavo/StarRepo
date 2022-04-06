import Foundation

public enum HTTPError: Error {
    case unprocessableEntity // 422
    case notModified // 304
    case serviceUnavailable // 503
}
