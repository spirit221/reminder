import Foundation
class StringEditor {
    func takeAndCut(str: String, separated: Int, offset: Int) -> String {
        var token = str.components(separatedBy: "=")[separated]
        let endIndex = token.index((token.endIndex), offsetBy: offset)
        token = String(token[..<endIndex])
        return token
    }
    func removeSpases(str: String, offset: Int) -> String {
        let strOff = str.replacingOccurrences(of: " ", with: "+")
        let strIndex = strOff.index((strOff.endIndex), offsetBy: offset)
        let strFinal = String(strOff[..<strIndex])
        return strFinal
    }
}
