import Foundation

struct Fpe2 {
    public var fpe2 = (UInt8(0), UInt8(0))
    public var integer = 0
    
    init (bytes: (UInt8, UInt8)) {
        self.fpe2 = bytes
        self.integer = Int(bytes.0) << 6 + Int(bytes.1) >> 2
    }

    init(integer: Int) {
        self.fpe2 = (UInt8(integer >> 6), UInt8((integer << 2) ^ ((integer >> 6) << 8)))
        self.integer = integer
    }
}
