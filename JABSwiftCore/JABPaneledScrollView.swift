//
//  JABPaneledScrollView.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/19/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

public class JABPaneledScrollView: JABView, JABPanelChangeSubscriber {

    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    
    // MARK: State
    public var scrollEnabled = true
    
    var panels = [JABPanel]() {
        didSet {
            for panel in panels {
                if !panel.subscriberIsAlreadySubscribed(self) {
                    panel.addSubscriber(self)
                }
                
                drawPanels()
            }
        }
    }
    public var numberOfPanels: Int {
        get {
            return panels.count
        }
    }
    var columns = [[JABPanel]]()
    
    // MARK: UI
    let scrollView = UIScrollView()
    
    // MARK: Parameters
    public var numberOfColumns = 1 {
        didSet {
            if numberOfColumns < 1 {
                print("numberOfColumns of \(self) was set to \(numberOfColumns) but may not be less than 1. Setting to 1...")
                numberOfColumns = 1
            }
            
            if oldValue != numberOfColumns {
                drawPanels()
            }
        }
    }
    
    
    public var betweenBufferForColumns = CGFloat(0);
    public var betweenBufferForRows = CGFloat(0);
    public var sideBuffer = CGFloat(0);
    public var topBuffer = CGFloat(0);
    
    var widthOfPanels = CGFloat(0)
    
    
    
    
    
    // **********************************************************************************************************************
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK:
    // MARK: Init
    // MARK:
    
    public override init () {
        super.init()
        
        
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        
        super.init()
        print("Should not be initializing from coder \(self)")
    }
    
    
    
    
    
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    
    // MARK: All
    override public func addAllUI() {
        
        addScrollView()
        
    }
    
    override public func updateAllUI() {
        
        configureScrollView()
        positionScrollView()
        
    }
    
    
    
    // MARK: Adding
    func addScrollView () {
        addSubview(scrollView)
    }
    
    
    // MARK: Scroll View
    func configureScrollView () {
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollEnabled = scrollEnabled
        
    }
    
    func positionScrollView () {
        
        if scrollView.frame != relativeFrame {
            scrollView.frame = relativeFrame
            drawPanels()
        }
        
    }
    
    
    
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    // MARK:
    // MARK: Panels
    // MARK:
    
    // MARK: Public
    public func loadWithPanels(panels: [JABPanel]) {
        
        deleteAllPanels()
        self.panels = panels
        
    }
    
    public func addPanel(panel: JABPanel) {
        
        insertPanel(panel, atIndex: 0)
        drawPanels()
        
    }
    
    public func addPanel(panel: JABPanel, toColumn column: Int) {
        
        if column < numberOfColumns {
            panels.insert(panel, atIndex: column)
            drawPanels()
        }
        
    }
    
    public func insertPanel(panel: JABPanel, atIndex index: Int) {
        
        for i in 0..<panels.count {
            let preexistingPanel = panels[i]
            if preexistingPanel == panel {
                panels.removeAtIndex(i)
            }
        }
        
        if panels.count > index {
            panels.insert(panel, atIndex: index)
        } else {
            panels.append(panel)
        }
        
        panel.addSubscriber(self)
        drawPanels()
        
    }
    
    public func removeAllPanels () {
        for subview in scrollView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    public func deleteAllPanels () {
        removeAllPanels()
        panels.removeAll(keepCapacity: true)
    }
    
    public func frameOfNegativePanelWithHeightToWidthRatio (heightToWidthRatio: CGFloat, staticAdditionToHeight: CGFloat, forColumn column: Int) -> CGRect {
        
        var hypotheticalFrame = CGRectZero;
        hypotheticalFrame.size.width = widthOfPanels;
        hypotheticalFrame.size.height = (hypotheticalFrame.size.width * heightToWidthRatio) + staticAdditionToHeight;
        
        hypotheticalFrame.origin.x = sideBuffer + (CGFloat(column) * (widthOfPanels + betweenBufferForColumns));
        hypotheticalFrame.origin.y = -hypotheticalFrame.size.height;
        
        return hypotheticalFrame;
        
    }
    
    public func frameOfPanelRelativeToScrollView (panel: JABPanel?) -> CGRect? {
        
        if let verifiedPanel = panel {
            if indexOfPanel(verifiedPanel) != nil {
                
                var returnFrame = verifiedPanel.frame
                returnFrame.origin.x -= scrollView.contentOffset.x
                returnFrame.origin.y -= scrollView.contentOffset.y
                
                return returnFrame
                
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    public func panelAtIndex (index: Int?) -> JABPanel? {
        
        if let verifiedIndex = index {
            if panels.count > verifiedIndex && verifiedIndex >= 0 {
                return panels[verifiedIndex]
            } else {
                return nil
            }
        } else {
            return nil
        }
        
    }
    
    public func indexOfPanel (panel: JABPanel?) -> Int? {
        
        for i in 0..<panels.count {
            if panels[i] === panel {
                return i
            }
        }
        
        return nil
        
    }
    
    
    public func bringPanelToFront (panel: JABPanel?) {
        if panel != nil {
            scrollView.bringSubviewToFront(panel!)
        }
    }
    
    
    
    // MARK: Private
    func drawPanels () {
        
        for panel in panels {
            if !scrollView.subviews.contains({ $0 === panel } ) {
                scrollView.addSubview(panel)
            }
        }
        
        updateWidthOfPanels()
        assignColumns()
        
        for i in 0..<numberOfColumns {
            drawColumn(i)
        }
        
        adjustContentSize()
        
    }
    
    func updateWidthOfPanels () {
        
        let emptyHorizontalSpace = (2*sideBuffer) + (CGFloat((numberOfColumns - 1)) * betweenBufferForColumns)
        widthOfPanels = (width - emptyHorizontalSpace)/CGFloat(numberOfColumns)
        
    }
    
    func assignColumns () {
        
        columns.removeAll(keepCapacity: true)
        for i in 0..<numberOfColumns {
            columns.append([JABPanel]())
        }
        
        for i in 0..<panels.count {
            columns[i%numberOfColumns].append(panels[i])
        }
        
    }
    
    func drawColumn (column: Int) {
        
        let columnArray = columns[column]
        
        for i in 0..<columnArray.count {
            let currentPanel = columnArray[i]
            
            var newFrame = CGRectZero
            
            newFrame.origin.x = sideBuffer + (CGFloat(column) * (widthOfPanels + betweenBufferForColumns))
            
            if i == 0 {
                newFrame.origin.y = topBuffer
            } else {
                newFrame.origin.y = columnArray[i-1].bottom + betweenBufferForRows
            }
            
            newFrame.size.width = widthOfPanels
            newFrame.size.height = (newFrame.size.width * currentPanel.heightToWidthRatio) + currentPanel.staticAdditionToHeight
            
            currentPanel.frame = newFrame
        }
        
    }
    
    func adjustContentSize () {
        
        var lowestPoint = CGFloat(0);
        for column in columns {
            let locallyLowestFrame = column.last?.frame
            if locallyLowestFrame != nil {
                if locallyLowestFrame!.bottom > lowestPoint {
                    lowestPoint = locallyLowestFrame!.bottom
                }
            }
        }
        
        if scrollView.height > lowestPoint {
            scrollView.contentSize = CGSize(width: scrollView.width, height: scrollView.height + 10)
        } else {
            scrollView.contentSize = CGSize(width: scrollView.width, height: lowestPoint + 100)
        }
        
    }
    
    
    
    
    // MARK:
    // MARK: Subscriptions
    // MARK:
    
    // MARK: Panels
    public func panelContentsDidChange(panel: JABPanel) {
        
    }
}
