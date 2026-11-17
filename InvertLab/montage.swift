// TEMPORARY helper: tiles screenshots side by side into one JPEG, with the file name under each.
// Usage: montage <out.jpg> <tileWidthPx> <image>...
import AppKit
import CoreGraphics
import Foundation
import ImageIO

let arguments = CommandLine.arguments
guard arguments.count >= 4, let tileWidth = Double(arguments[2]) else {
    FileHandle.standardError.write(Data("usage: montage <out.jpg> <tileWidthPx> <image>...\n".utf8))
    exit(2)
}
let output = arguments[1]
let paths = Array(arguments[3...])

func load(_ path: String) -> CGImage? {
    guard let source = CGImageSourceCreateWithURL(URL(fileURLWithPath: path) as CFURL, nil) else { return nil }
    return CGImageSourceCreateImageAtIndex(source, 0, nil)
}

let images = paths.map(load)
let gap = 14.0
let labelHeight = 40.0
let tileHeight = images.compactMap { $0 }
    .map { Double($0.height) * tileWidth / Double($0.width) }
    .max() ?? tileWidth * 2
let width = Int(Double(paths.count) * tileWidth + Double(paths.count + 1) * gap)
let height = Int(tileHeight + labelHeight + 2 * gap)

guard let context = CGContext(
    data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0,
    space: CGColorSpace(name: CGColorSpace.sRGB)!,
    bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
) else { exit(1) }

// Mid gray, so light and dark screenshots both stand out.
context.setFillColor(CGColor(gray: 0.5, alpha: 1))
context.fill(CGRect(x: 0, y: 0, width: width, height: height))
context.interpolationQuality = .high
NSGraphicsContext.current = NSGraphicsContext(cgContext: context, flipped: false)

for (index, path) in paths.enumerated() {
    let x = gap + Double(index) * (tileWidth + gap)
    if let image = images[index] {
        let scaledHeight = Double(image.height) * tileWidth / Double(image.width)
        // Origin is bottom-left: labels go on top, screenshots hang below them.
        context.draw(image, in: CGRect(x: x, y: gap + (tileHeight - scaledHeight), width: tileWidth, height: scaledHeight))
    }
    let label = URL(fileURLWithPath: path).deletingPathExtension().lastPathComponent
        + (images[index] == nil ? " (missing)" : "")
    (label as NSString).draw(
        at: NSPoint(x: x, y: gap + tileHeight + 8),
        withAttributes: [.font: NSFont.boldSystemFont(ofSize: 22), .foregroundColor: NSColor.white]
    )
}

guard let result = context.makeImage(),
      let data = NSBitmapImageRep(cgImage: result).representation(using: .jpeg, properties: [.compressionFactor: 0.85])
else { exit(1) }
do {
    try data.write(to: URL(fileURLWithPath: output))
} catch {
    FileHandle.standardError.write(Data("montage: \(error)\n".utf8))
    exit(1)
}
