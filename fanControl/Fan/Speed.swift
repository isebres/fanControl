import Foundation

struct Speed {
    private var key: String
    
    init(key: String) {
        self.key = key
    }
    
    public func get() -> Int {
        let bytes = Smc.i.read(key: self.key)
        return Fpe2(bytes: (bytes[0], bytes[1])).integer
    }
    
    public func set(rpm:Int) {
        let fpe = Fpe2(integer: rpm)
        
        let bytes = Bytes(bytes: [fpe.fpe2.0, fpe.fpe2.1])
        
        _ = Smc.i.write(key: self.key, bytes: bytes)
    }
}
