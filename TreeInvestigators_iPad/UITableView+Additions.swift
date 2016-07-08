//
//  File.swift
//  TreeInvestigators_iPad
//
//  Created by Steve Schaeffer on 7/7/16.
//  Copyright © 2016 Zach Fuller. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    
    override var screenshot : UIImage? {
        return self.screenshotExcludingHeadersAtSections(nil, excludingFootersAtSections:nil, excludingRowsAtIndexPaths:nil)
    }
    
    func screenshotOfCellAtIndexPath(indexPath:NSIndexPath) -> UIImage? {
        var cellScreenshot:UIImage?
        
        let currTableViewOffset = self.contentOffset
        
        self.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: false)
        
        cellScreenshot = self.cellForRowAtIndexPath(indexPath)?.screenshot
        
        self.setContentOffset(currTableViewOffset, animated: false)
        
        return cellScreenshot;
    }
    
    var screenshotOfHeaderView : UIImage? {
        let originalOffset = self.contentOffset
        if let headerRect = self.tableHeaderView?.frame {
            self.scrollRectToVisible(headerRect, animated: false)
            let headerScreenshot = self.screenshotForCroppingRect(headerRect)
            self.setContentOffset(originalOffset, animated: false)
            
            return headerScreenshot;
        }
        return nil
    }
    
    var screenshotOfFooterView : UIImage? {
        let originalOffset = self.contentOffset
        if let footerRect = self.tableFooterView?.frame {
            self.scrollRectToVisible(footerRect, animated: false)
            let footerScreenshot = self.screenshotForCroppingRect(footerRect)
            self.setContentOffset(originalOffset, animated: false)
            
            return footerScreenshot;
        }
        return nil
    }
    
    func screenshotOfHeaderViewAtSection(section:Int) -> UIImage? {
        let originalOffset = self.contentOffset
        let headerRect = self.rectForHeaderInSection(section)
        
        self.scrollRectToVisible(headerRect, animated: false)
        let headerScreenshot = self.screenshotForCroppingRect(headerRect)
        self.setContentOffset(originalOffset, animated: false)
        
        return headerScreenshot;
    }
    
    func screenshotOfFooterViewAtSection(section:Int) -> UIImage? {
        let originalOffset = self.contentOffset
        let footerRect = self.rectForFooterInSection(section)
        
        self.scrollRectToVisible(footerRect, animated: false)
        let footerScreenshot = self.screenshotForCroppingRect(footerRect)
        self.setContentOffset(originalOffset, animated: false)
        
        return footerScreenshot;
    }
    
    
    func screenshotExcludingAllHeaders(withoutHeaders:Bool, excludingAllFooters:Bool, excludingAllRows:Bool) -> UIImage? {
        
        var excludedHeadersOrFootersSections:[Int]?
        
        if withoutHeaders || excludingAllFooters {
            excludedHeadersOrFootersSections = self.allSectionsIndexes
        }
        
        var excludedRows:[NSIndexPath]?
        
        if excludingAllRows {
            excludedRows = self.allRowsIndexPaths
        }
        
        return self.screenshotExcludingHeadersAtSections( withoutHeaders ? NSSet(array: excludedHeadersOrFootersSections!) : nil,
                                                          excludingFootersAtSections:excludingAllFooters ? NSSet(array:excludedHeadersOrFootersSections!) : nil, excludingRowsAtIndexPaths:excludingAllRows ? NSSet(array:excludedRows!) : nil)
    }
    
    func screenshotExcludingHeadersAtSections(excludedHeaderSections:NSSet?, excludingFootersAtSections:NSSet?,
                                              excludingRowsAtIndexPaths:NSSet?) -> UIImage? {
        var screenshots = [UIImage]()
        
        if let headerScreenshot = self.screenshotOfHeaderView {
            screenshots.append(headerScreenshot)
        }
        
        for section in 0..<self.numberOfSections {
            if let headerScreenshot = self.screenshotOfHeaderViewAtSection(section, excludedHeaderSections: excludedHeaderSections) {
                screenshots.append(headerScreenshot)
            }
            
            for row in 0..<self.numberOfRowsInSection(section) {
                let cellIndexPath = NSIndexPath(forRow: row, inSection: section)
                if let cellScreenshot = self.screenshotOfCellAtIndexPath(cellIndexPath) {
                    screenshots.append(cellScreenshot)
                }
                
            }
            
            if let footerScreenshot = self.screenshotOfFooterViewAtSection(section, excludedFooterSections:excludingFootersAtSections) {
                screenshots.append(footerScreenshot)
            }
        }
        
        
        if let footerScreenshot = self.screenshotOfFooterView {
            screenshots.append(footerScreenshot)
        }
        
        return UIImage.verticalImageFromArray(screenshots)
        
    }
    
    func screenshotOfHeadersAtSections(includedHeaderSection:NSSet, footersAtSections:NSSet?, rowsAtIndexPaths:NSSet?) -> UIImage? {
        var screenshots = [UIImage]()
        
        for section in 0..<self.numberOfSections {
            if let headerScreenshot = self.screenshotOfHeaderViewAtSection(section, includedHeaderSections: includedHeaderSection) {
                screenshots.append(headerScreenshot)
            }
            
            for row in 0..<self.numberOfRowsInSection(section) {
                if let cellScreenshot = self.screenshotOfCellAtIndexPath(NSIndexPath(forRow: row, inSection: section), includedIndexPaths: rowsAtIndexPaths) {
                    screenshots.append(cellScreenshot)
                }
            }
            
            if let footerScreenshot = self.screenshotOfFooterViewAtSection(section, includedFooterSections: footersAtSections) {
                screenshots.append(footerScreenshot)
            }
        }
        
        return UIImage.verticalImageFromArray(screenshots)
    }
    
    func screenshotOfCellAtIndexPath(indexPath:NSIndexPath, excludedIndexPaths:NSSet?) -> UIImage? {
        if excludedIndexPaths == nil || !excludedIndexPaths!.containsObject(indexPath) {
            return nil
        }
        return self.screenshotOfCellAtIndexPath(indexPath)
    }
    
    func screenshotOfHeaderViewAtSection(section:Int, excludedHeaderSections:NSSet?) -> UIImage? {
        if excludedHeaderSections != nil && !excludedHeaderSections!.containsObject(section) {
            return nil
        }
        
        var sectionScreenshot = self.screenshotOfHeaderViewAtSection(section)
        if sectionScreenshot == nil {
            sectionScreenshot = self.blankScreenshotOfHeaderAtSection(section)
        }
        return sectionScreenshot;
    }
    
    func screenshotOfFooterViewAtSection(section:Int, excludedFooterSections:NSSet?) -> UIImage? {
        if excludedFooterSections != nil && !excludedFooterSections!.containsObject(section) {
            return nil
        }
        
        var sectionScreenshot = self.screenshotOfFooterViewAtSection(section)
        if sectionScreenshot == nil {
            sectionScreenshot = self.blankScreenshotOfFooterAtSection(section)
        }
        return sectionScreenshot;
    }
    
    func screenshotOfCellAtIndexPath(indexPath:NSIndexPath, includedIndexPaths:NSSet?) -> UIImage? {
        if includedIndexPaths != nil && !includedIndexPaths!.containsObject(indexPath) {
            return nil
        }
        return self.screenshotOfCellAtIndexPath(indexPath)
    }
    
    func screenshotOfHeaderViewAtSection(section:Int, includedHeaderSections:NSSet?) -> UIImage? {
        if includedHeaderSections != nil && !includedHeaderSections!.containsObject(section) {
            return nil
        }
        
        var sectionScreenshot = self.screenshotOfHeaderViewAtSection(section)
        if sectionScreenshot == nil {
            sectionScreenshot = self.blankScreenshotOfHeaderAtSection(section)
        }
        return sectionScreenshot;
    }
    
    func screenshotOfFooterViewAtSection(section:Int, includedFooterSections:NSSet?)
        -> UIImage? {
            if includedFooterSections != nil && !includedFooterSections!.containsObject(section) {
                return nil
            }
            var sectionScreenshot = self.screenshotOfFooterViewAtSection(section)
            if sectionScreenshot == nil {
                sectionScreenshot = self.blankScreenshotOfFooterAtSection(section)
            }
            return sectionScreenshot;
    }
    
    func blankScreenshotOfHeaderAtSection(section:Int) -> UIImage? {
        
        let headerRectSize = CGSizeMake(self.bounds.size.width, self.rectForHeaderInSection(section).size.height)
        
        return UIImage.imageWithColor(UIColor.clearColor(), size:headerRectSize)
    }
    
    func blankScreenshotOfFooterAtSection(section:Int) -> UIImage? {
        let footerRectSize = CGSizeMake(self.bounds.size.width, self.rectForFooterInSection(section).size.height)
        return UIImage.imageWithColor(UIColor.clearColor(), size:footerRectSize)
    }
    
    var allSectionsIndexes : [Int]
    {
        let numSections = self.numberOfSections
        
        var allSectionsIndexes = [Int]()
        
        for section in 0..<numSections {
            allSectionsIndexes.append(section)
        }
        return allSectionsIndexes
    }
    
    
    var allRowsIndexPaths : [NSIndexPath] {
        var allRowsIndexPaths = [NSIndexPath]()
        for sectionIdx in self.allSectionsIndexes {
            for rowNum in 0..<self.numberOfRowsInSection(sectionIdx) {
                let indexPath = NSIndexPath(forRow: rowNum, inSection: sectionIdx)
                allRowsIndexPaths.append(indexPath)
            }
        }
        return allRowsIndexPaths;
    }
    
}



public extension UIImage {
    
    class func imageWithColor(color:UIColor, size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.mainScreen().scale)
        let context = UIGraphicsGetCurrentContext()
        if context == nil {
            return nil
        }
        color.set()
        CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

public extension UIImage {
    
    class func verticalAppendedTotalImageSizeFromImagesArray(imagesArray:[UIImage]) -> CGSize {
        var totalSize = CGSizeZero
        for im in imagesArray {
            let imSize = im.size
            totalSize.height += imSize.height
            totalSize.width = max(totalSize.width, imSize.width)
        }
        return totalSize
    }
    
    
    class func verticalImageFromArray(imagesArray:[UIImage]) -> UIImage? {
        
        var unifiedImage:UIImage?
        let totalImageSize = self.verticalAppendedTotalImageSizeFromImagesArray(imagesArray)
        
        UIGraphicsBeginImageContextWithOptions(totalImageSize,false, 0)
        
        var imageOffsetFactor:CGFloat = 0
        
        for img in imagesArray {
            img.drawAtPoint(CGPointMake(0, imageOffsetFactor))
            imageOffsetFactor += img.size.height;
        }
        unifiedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return unifiedImage
    }
}

public extension UIScrollView {
    
    var screenshotOfVisibleContent : UIImage? {
        var croppingRect = self.bounds
        croppingRect.origin = self.contentOffset
        return self.screenshotForCroppingRect(croppingRect)
    }
    
}

public extension UIView {
    func screenshotForCroppingRect(croppingRect:CGRect) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(croppingRect.size, false, UIScreen.mainScreen().scale);
        
        let context = UIGraphicsGetCurrentContext()
        if context == nil {
            return nil;
        }
        
        CGContextTranslateCTM(context, -croppingRect.origin.x, -croppingRect.origin.y)
        self.layoutIfNeeded()
        self.layer.renderInContext(context!)
        
        let screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }
    
    var screenshot : UIImage? {
        return self.screenshotForCroppingRect(self.bounds)
    }
}