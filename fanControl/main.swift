import Foundation

func parseArguments(arguments: [String]) -> (Int, Int, Int)? {
    let patterns = [
        "^-id=(\\d{1,2})$",
        "^-rpm=(\\d{3,4})-(\\d{3,4})$"
    ]
    
    var id = 0
    var minSpeed = 0
    var maxSpeed = 0
    
    for argument in CommandLine.arguments {
        let nsString = argument as NSString
        
        for pattern in patterns {
            let regex = try! NSRegularExpression(pattern: pattern)
            let results = regex.matches(in: argument, range: NSRange(location: 0, length: nsString.length))
            
            for result in results {
                if (result.numberOfRanges == 2) {
                    id = Int(nsString.substring(with: result.range(at: 1)))!
                }
                
                if (result.numberOfRanges == 3) {
                    minSpeed = Int(nsString.substring(with: result.range(at: 1)))!
                    maxSpeed = Int(nsString.substring(with: result.range(at: 2)))!
                }
            }
            
        }
    }
    
    if (minSpeed != 0 && maxSpeed != 0) {
        return (id, minSpeed, maxSpeed)
    }
    
    return nil
}

func show(params: Array<String>) {
    var s = "   "
    
    for var parameter in params {
        while parameter.count < 10 {
            parameter.append(" ")
        }
        s.append(parameter)
    }
    
    print(s)
}

Smc.i.open()

if let parsed = parseArguments(arguments: CommandLine.arguments) {
    let fan = Fan(id: parsed.0)
    
    let old = (fan.min.get(), fan.max.get())
    
    fan.min.set(rpm: parsed.1)
    fan.max.set(rpm: parsed.2)
    
    let new = (fan.min.get(), fan.max.get())
    
    print("\(fan.name()) fan (ID:\(parsed.0)):")
    if (old != new) {
        print("    RPM successfully changed from \(old.0)-\(old.1) to \(new.0)-\(new.1)")
    } else {
        print("    RPM NOT changed (in case lack of privileges try 'sudo')")
    }
}

print("Fan speeds (RPM):")
show(params: ["ID", "Name", "Min", "Cur", "Max"])
let bytes = Smc.i.read(key: "FNum")
let num = Int(bytes[0])
for id in 0...num - 1 {
    let fan = Fan(id: id)
    show(params: [String(id), fan.name(), String(fan.min.get()), String(fan.cur.get()), String(fan.max.get())])
}

print("Temperatures (°C):")
for (name, _) in Temperature.known_keys {
    let temperature = Temperature(name: name)
    if (temperature.value > 0) {
        show(params: [temperature.name, String(temperature.value)])
    }
}

Smc.i.close()
