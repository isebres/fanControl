import Foundation

struct Sp78 {
    public var sp78 = (UInt8(0), UInt8(0))
    public var double: Double = 0
    
    init(bytes: (UInt8, UInt8)) {
        self.sp78 = bytes
        self.double = Double(bytes.0 & 0x7F)
        
        var divider = 10.0
        if (bytes.1 > 99) {
            divider = 100.0
        }
      
        self.double += round(Double(bytes.1) / divider) / 10
        
        if (bytes.0 & 0x80 != 0) {
            self.double *= -1
        }
    }
}
