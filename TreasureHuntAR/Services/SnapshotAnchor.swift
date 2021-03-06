//
//  SnapshotAnchor.swift
//  TreasureHuntAR
//
//  Created by MacBook on 09/05/22.
//

import ARKit
import RealityKit

/// - Tag: SnapshotAnchor
class StartPointSnapshot {
    
    let imageData: Data
    let image = CIImage(cvPixelBuffer: frame.capturedImage)
    let orientation = CGImagePropertyOrientation(rawValue: UInt32(UIDevice.current.orientation.rawValue))
    
    let context = CIContext(options: [.useSoftwareRenderer: false])
    guard let data = context.jpegRepresentation(of: image.oriented(orientation),
                                                colorSpace: CGColorSpaceCreateDeviceRGB(),
                                                options: [kCGImageDestinationLossyCompressionQuality as CIImageRepresentationOption: 0.7])
    else { return nil }
    
    self.init(imageData: data, transform: frame.camera.transform)
}

init(imageData: Data, transform: float4x4) {
    self.imageData = imageData
    super.init(name: "snapshot", transform: transform)
}

required init(anchor: ARAnchor) {
    self.imageData = (anchor as! SnapshotAnchor).imageData
    super.init(anchor: anchor)
}

override class var supportsSecureCoding: Bool {
    return true
}

required init?(coder aDecoder: NSCoder) {
    if let snapshot = aDecoder.decodeObject(forKey: "snapshot") as? Data {
        self.imageData = snapshot
    } else {
        return nil
    }
    
    super.init(coder: aDecoder)
}

override func encode(with aCoder: NSCoder) {
    super.encode(with: aCoder)
    aCoder.encode(imageData, forKey: "snapshot")
}

}
}

