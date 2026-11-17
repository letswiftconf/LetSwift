// TEMP (Dynamic Type lab): tiles screenshots into one labelled contact sheet.
// usage: sheet <out.jpg> <cell width px> <columns> (<label> <image path>)...
import AppKit

let arguments = CommandLine.arguments
guard arguments.count >= 6, let cellWidth = Double(arguments[2]), let columns = Int(arguments[3]), columns > 0 else {
    FileHandle.standardError.write(Data("usage: sheet <out.jpg> <cell width> <columns> (<label> <image>)...\n".utf8))
    exit(64)
}

struct Cell {
    let label: String
    let image: NSBitmapImageRep?
}

let cells: [Cell] = stride(from: 4, to: arguments.count - 1, by: 2).map { index in
    let data = FileManager.default.contents(atPath: arguments[index + 1])
    return Cell(label: arguments[index], image: data.flatMap(NSBitmapImageRep.init(data:)))
}
guard let reference = cells.compactMap(\.image).first else {
    FileHandle.standardError.write(Data("no images for \(arguments[1])\n".utf8))
    exit(0)
}

let labelHeight = 30.0
let gap = 10.0
let cellHeight = (cellWidth * Double(reference.pixelsHigh) / Double(reference.pixelsWide)).rounded()
let rows = Int((Double(cells.count) / Double(columns)).rounded(.up))
let width = Int(Double(columns) * (cellWidth + gap) + gap)
let height = Int(Double(rows) * (cellHeight + labelHeight + gap) + gap)

guard let canvas = NSBitmapImageRep(
    bitmapDataPlanes: nil, pixelsWide: width, pixelsHigh: height,
    bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
    colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0
), let context = NSGraphicsContext(bitmapImageRep: canvas) else { exit(1) }

NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = context
context.imageInterpolation = .high
NSColor(white: 0.2, alpha: 1).setFill()
NSRect(x: 0, y: 0, width: width, height: height).fill()

let labelAttributes: [NSAttributedString.Key: Any] = [
    .font: NSFont.boldSystemFont(ofSize: 18),
    .foregroundColor: NSColor.white,
]
for (index, cell) in cells.enumerated() {
    let column = Double(index % columns)
    let row = Double(index / columns)
    let x = gap + column * (cellWidth + gap)
    // AppKit's origin is bottom-left; lay rows out from the top.
    let top = Double(height) - gap - row * (cellHeight + labelHeight + gap)
    cell.label.draw(at: NSPoint(x: x + 2, y: top - labelHeight + 5), withAttributes: labelAttributes)
    let frame = NSRect(x: x, y: top - labelHeight - cellHeight, width: cellWidth, height: cellHeight)
    if let image = cell.image {
        let scale = min(cellWidth / Double(image.pixelsWide), cellHeight / Double(image.pixelsHigh))
        let size = NSSize(width: Double(image.pixelsWide) * scale, height: Double(image.pixelsHigh) * scale)
        image.draw(in: NSRect(x: frame.minX, y: frame.maxY - size.height, width: size.width, height: size.height))
    } else {
        NSColor(white: 0.3, alpha: 1).setFill()
        frame.fill()
        "not captured".draw(at: NSPoint(x: frame.minX + 12, y: frame.maxY - 36), withAttributes: labelAttributes)
    }
}
NSGraphicsContext.restoreGraphicsState()

guard let jpeg = canvas.representation(using: .jpeg, properties: [.compressionFactor: 0.8]) else { exit(1) }
try jpeg.write(to: URL(fileURLWithPath: arguments[1]))
