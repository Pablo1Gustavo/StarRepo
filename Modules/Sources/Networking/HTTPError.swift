import Foundation

public enum HTTPError: Error {
    case error(String)
    case unprocessableEntity // 422
    case notModified // 304
    case serviceUnavailable // 503
}
