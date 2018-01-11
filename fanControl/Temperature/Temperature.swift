import Foundation

struct Temperature {
    static let known_keys = [
        "CPU" : ["TC0F", "TC0D", "TC0H", "TC0P"],
        "GPU" : ["TG0D", "TG0H", "TG0P"],
        "HDD" : ["TH0P"],
        "HSK" : ["Th0H", "Th1H", "Th2H"],
        "MEM" : ["TM0S", "TM0P"],
        "NRB" : ["TN0H", "TN0D", "TN0P"],
        "TBT" : ["TI0P", "TI1P"],
        "ENC" : ["TB0T", "TB1T", "TB2T", "TB3T"]
    ]
        
    var name = ""
    var value = 0.0
    
    init(name: String) {
        self.name = name
        
        var values: Array<Double> = []
        
        if let keys = Temperature.known_keys[name] {
            for key in keys {
                let bytes = Smc.i.read(key: key)
                let value = Sp78(bytes: (bytes[0], bytes[1]))
                values.append(value.double)
            }
        }
        
        if let max = values.max() {
            self.value = max
        }
    }
}
