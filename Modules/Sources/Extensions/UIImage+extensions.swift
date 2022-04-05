import UIKit

public extension UIImage {

 var sfSymbolName: String? {
        guard let strSeq = "\(String(describing: self))".split(separator: ")").first else { return nil }
        let str = String(strSeq)
        guard let name = str.split(separator: ":").last else { return nil }
        return String(name)
    }
}
