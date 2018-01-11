import Foundation

struct Key {
    public var string:String = ""
    public var integer:UInt32 = 0
    
    init(integer: UInt32) {
        let chars = [
            integer >> 24,
            integer >> 16,
            integer >> 8,
            integer
        ]
        
        self.string = chars.reduce(self.string) { string, char in
            return string + String(describing: UnicodeScalar(char & 0xff)!)
        }

        self.integer = integer
    }
    
    init(key: String) {
        if (key.count == 4) {
            self.string = key
            self.integer = key.utf8.reduce(self.integer) { sum, character in
                return sum << 8 | UInt32(character)
            }
        }
    }
}
