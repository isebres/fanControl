import Foundation

struct Bytes {    
    typealias SmcBytes = (
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8
    )
    
    public var array: [UInt8] = []
    
    var tuple: SmcBytes
    var dataSize = UInt32(32)
    
    init(bytes: [UInt8] = []) {
        while (self.array.count < self.dataSize) {
            self.array.append(0)
        }
        
        if (bytes.count > 0) {
            for index in 0...bytes.count - 1 {
                self.array[index] = bytes[index]
            }
            self.dataSize = UInt32(bytes.count)
        }
        
        self.tuple = (
            self.array[0],
            self.array[1],
            self.array[2],
            self.array[3],
            self.array[4],
            self.array[5],
            self.array[6],
            self.array[7],
            self.array[8],
            self.array[9],
            self.array[10],
            self.array[11],
            self.array[12],
            self.array[13],
            self.array[14],
            self.array[15],
            self.array[16],
            self.array[17],
            self.array[18],
            self.array[19],
            self.array[20],
            self.array[21],
            self.array[22],
            self.array[23],
            self.array[24],
            self.array[25],
            self.array[26],
            self.array[27],
            self.array[28],
            self.array[29],
            self.array[30],
            self.array[31]
        )
    }
    
    init(tuple: SmcBytes) {
        self.tuple = tuple
        self.array = [
            tuple.0,
            tuple.1,
            tuple.2,
            tuple.3,
            tuple.4,
            tuple.5,
            tuple.6,
            tuple.7,
            tuple.8,
            tuple.9,
            tuple.10,
            tuple.11,
            tuple.12,
            tuple.13,
            tuple.14,
            tuple.15,
            tuple.16,
            tuple.17,
            tuple.18,
            tuple.19,
            tuple.20,
            tuple.21,
            tuple.22,
            tuple.23,
            tuple.24,
            tuple.25,
            tuple.26,
            tuple.27,
            tuple.28,
            tuple.29,
            tuple.30,
            tuple.31
        ]
    }
}
