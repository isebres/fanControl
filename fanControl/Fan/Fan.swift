import Foundation

struct Fan {
    public var id: Int = 0
    
    public var min: Speed
    public var cur: Speed
    public var max: Speed
    
    init(id:Int) {
        self.id = id
        
        self.min = Speed(key: "F\(self.id)Mn")
        self.cur = Speed(key: "F\(self.id)Ac")
        self.max = Speed(key: "F\(self.id)Mx")
    }
    
    func name() -> String {
        let bytes = Smc.i.read(key: "F\(self.id)ID")
        
        var name = ""
        for byte in bytes[4...15] {
            if byte != 0 && byte != 32 {
                name.append(Character(UnicodeScalar(byte)))
            }
        }
        
        return name
    }
}
