import Cocoa

func art2binary(file: URL) -> Data {
    let image = NSImage(contentsOf: file)
    let img = NSBitmapImageRep(data: image!.tiffRepresentation!);
    let height = Int(img!.size.height)
    let width = Int(img!.size.width)
    var i = 0
    var byteString = ""
    var data: Data = Data()
    for y in (0..<height).reversed() {
        for x in 0..<width {
            let color = img!.colorAt(x: (x * 2), y: (y * 2) )
            if color != nil {
                if color == NSColor.white {
                    byteString += "0"
                }
                else if color == NSColor.black {
                    byteString += "1"
                }
                else if color == NSColor.red {
                    byteString += "2"
                }
                else if color == NSColor.green {
                    byteString += "3"
                }
                else if color == NSColor.blue {
                    byteString += "4"
                }
                else if color == NSColor.magenta {
                    byteString += "5"
                }
                else if color == NSColor.yellow {
                    byteString += "6"
                }
                else if color == NSColor.cyan {
                    byteString += "7"
                }
                else if color == NSColor.brown {
                    byteString += "8"
                }
                else if color == NSColor.orange {
                    byteString += "9"
                }
                else if color == NSColor.gray {
                    if byteString != "" {
                        data.append(UInt8(byteString)!)
                        print(UInt8(byteString)!)
                    }
                    byteString = ""
                }
                else if CGFloat(color!.redComponent) > 0.9 && CGFloat(color!.greenComponent) > 0.9 && CGFloat(color!.blueComponent) > 0.9 {  // white
                    byteString += "0"
                }
                else if CGFloat(color!.redComponent) < 0.1 && CGFloat(color!.greenComponent) < 0.1 && CGFloat(color!.blueComponent) < 0.1 {  // black
                    byteString += "1"
                }
                else if CGFloat(color!.redComponent) > 0.7 && CGFloat(color!.greenComponent) < 0.2 && CGFloat(color!.blueComponent) < 0.2 {  // red
                    byteString += "2"
                }
                else if CGFloat(color!.redComponent) < 0.6 && CGFloat(color!.greenComponent) > 0.9 && CGFloat(color!.blueComponent) < 0.3 {  // green
                    byteString += "3"
                }
                else if CGFloat(color!.redComponent) < 0.1 && CGFloat(color!.greenComponent) < 0.2 && CGFloat(color!.blueComponent) > 0.9 {  // blue
                    byteString += "4"
                }
                else if CGFloat(color!.redComponent) > 0.9 && CGFloat(color!.greenComponent) < 0.3 && CGFloat(color!.blueComponent) > 0.9 {  // magenta
                    byteString += "5"
                }
                else if CGFloat(color!.redComponent) > 0.9 && CGFloat(color!.greenComponent) > 0.9 && CGFloat(color!.blueComponent) < 0.4 {  // yellow
                    byteString += "6"
                }
                else if CGFloat(color!.redComponent) < 0.6 && CGFloat(color!.greenComponent) > 0.9 && CGFloat(color!.blueComponent) > 0.9 && CGFloat(color!.redComponent) > 0.4 {  // cyan
                    byteString += "7"
                }
                else if CGFloat(color!.redComponent) < 0.6 && CGFloat(color!.greenComponent) < 0.5 && CGFloat(color!.blueComponent) < 0.3 && CGFloat(color!.redComponent) > 0.5 && CGFloat(color!.greenComponent) >= 0.4 && CGFloat(color!.blueComponent) > 0.2 {  // brown
                    byteString += "8"
                }
                else if CGFloat(color!.redComponent) > 0.9 && CGFloat(color!.greenComponent) < 0.6 && CGFloat(color!.blueComponent) < 0.2 && CGFloat(color!.greenComponent) > 0.5 {  // orange
                    byteString += "9"
                }
                else if CGFloat(color!.redComponent) < 0.6 && CGFloat(color!.greenComponent) < 0.6 && CGFloat(color!.blueComponent) < 0.6 && CGFloat(color!.redComponent) > 0.4 && CGFloat(color!.greenComponent) > 0.4 && CGFloat(color!.blueComponent) > 0.4 {  // gray
                    if byteString != "" {
                        data.append(UInt8(byteString)!)
                        print(UInt8(byteString)!)
                    }
                    byteString = ""
                }
                else {
                    print("Red: \(color!.redComponent)")
                    print("Green: \(color!.greenComponent)")
                    print("Blue: \(color!.blueComponent)")
                }
                i += 1
            }
        }
    }
    return data
}

let input = CommandLine.arguments[1]
let output = CommandLine.arguments[2]

let inputFile = URL(fileURLWithPath: input)
var outputFile = URL(fileURLWithPath: output)

let data = art2binary(file: inputFile)

let string = String(decoding: data, as: UTF8.self)
try data.write(to: outputFile)

print("File Saved to: \(outputFile)")
