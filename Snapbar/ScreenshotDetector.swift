// Updated from https://gist.github.com/ts95/300c5a815393087c72cc

import Foundation

typealias NewFileCallback = (_: NSURL) -> Void

class ScreenshotDetector: NSObject, NSMetadataQueryDelegate {
    
    let query = NSMetadataQuery()
    
    var newFileCallback: NewFileCallback?

    override init() {
        super.init()
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(queryUpdated(_:)), name: NSNotification.Name.NSMetadataQueryDidStartGathering, object: query)
        center.addObserver(self, selector: #selector(queryUpdated(_:)), name: NSNotification.Name.NSMetadataQueryDidUpdate, object: query)
        center.addObserver(self, selector: #selector(queryUpdated(_:)), name: NSNotification.Name.NSMetadataQueryDidFinishGathering, object: query)
        
        query.delegate = self
        query.predicate = NSPredicate(format: "kMDItemIsScreenCapture = 1")
        query.start()
    }
    
    deinit {
        query.stop()
    }
    
    @objc func queryUpdated(_ notification: NSNotification) {
        print("queryUpdated")
        print(notification)
        if let userInfo = notification.userInfo {
            print(userInfo)
            for v in userInfo.values {
                let items = v as! [NSMetadataItem]
                if items.count > 0 {
                    let item = items[0]
                    if let filename = item.value(forAttribute: "kMDItemFSName") as? String {
                        let filenameWithPath = NSString(string: "~/Desktop/" + filename).expandingTildeInPath
                        let url = NSURL(fileURLWithPath: filenameWithPath, isDirectory: false)
                        if let cb = self.newFileCallback {
                            cb(url)
                        }
                    }
                }
            }
        }
    }
}

////////////////////////////
// Usage                  //
////////////////////////////
// Because this object is observing events it should stay
// in memory for the duration of its usage.
// In a view controller for instance it should be allocated
// in the class scope. If its reference is stored inside
// a method it will be deallocated automatically when the
// method returns and consequently stop obsering any events.
// let detector = ScreenshotDetector()
//
//// The actual callback can be assigned anywhere there's
//// a reference to the instance.
//detector.newFileCallback = { fileURL in
//  // fileURL is an NSURL instance of the screenshot file.
//}
