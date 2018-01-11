import Foundation

enum Selector: UInt8 {
    case kSMCHandleYPCEvent = 2
    case kSMCReadKey = 5
    case kSMCWriteKey = 6
    case kSMCGetKeyFromIndex = 8
    case kSMCGetKeyInfo = 9
}

enum Result: UInt8 {
    case kSMCSuccess = 0
    case kSMCError = 1
    case kSMCKeyNotFound = 132
}

class Smc {
    static let i: Smc = Smc()
    
    var connection: io_connect_t = 0
    
    private init() {

    }
    
    public func open() {
        let smc = IOServiceMatching("AppleSMC")
        let service = IOServiceGetMatchingService(kIOMasterPortDefault, smc)
        IOServiceOpen(service, mach_task_self_, 0, &connection)
    }
    
    public func close() {
        IOServiceClose(connection)
    }
    
    public func info(_ index: Int) -> Array<UInt8> {
        return self.call(key: "", method: .kSMCGetKeyFromIndex, bytes: Bytes(), data: UInt32(index))
    }
    
    public func read(key: String) -> Array<UInt8> {
        return self.call(key: key)
    }
    
    public func write(key: String, bytes: Bytes = Bytes()) -> Array<UInt8> {
        return self.call(key: key, method: .kSMCWriteKey, bytes: bytes)
    }
    
    public func info(key: String) -> Array<UInt8> {
        return self.call(key: key, method: .kSMCGetKeyInfo)
    }
    
    public func call(key: String, method: Selector = .kSMCReadKey, bytes: Bytes = Bytes(), data: UInt32 = 0) -> Array<UInt8>  {
        var inputStruct = ParamStruct()
        inputStruct.bytes = bytes.tuple
        inputStruct.key = Key(key: key).integer
        inputStruct.keyInfo.dataSize = bytes.dataSize
        inputStruct.data8 = method.rawValue
        inputStruct.data32 = data

        var outputStruct = ParamStruct()
        
        let inputStructCnt = MemoryLayout<ParamStruct>.stride
        var outputStructCnt = MemoryLayout<ParamStruct>.stride
        
        IOConnectCallStructMethod(
            connection,
            UInt32(Selector.kSMCHandleYPCEvent.rawValue),
            &inputStruct,
            inputStructCnt,
            &outputStruct,
            &outputStructCnt
        )
        
        return Bytes(tuple: outputStruct.bytes).array
    }
}
