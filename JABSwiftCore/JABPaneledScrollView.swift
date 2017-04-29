//
//  JABPaneledScrollView.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/19/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

open class JABPaneledScrollView: JABView, JABPanelChangeSubscriber, JABPanelDelegate {

    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    open var delegate: JABPaneledScrollViewDelegate?
    
    // MARK: State
    open var scrollEnabled = true
    
    fileprivate var panels = [JABPanel]() {
        didSet {
            for panel in panels {
                if !panel.subscriberIsAlreadySubscribed(self) {
                    panel.addSubscriber(self)
                }
                panel.panelDelegate = self
                
                drawPanels()
            }
        }
    }
    
    open var numberOfPanels: Int {
        get {
            return panels.count
        }
    }
    fileprivate var columns = [[JABPanel]]()
    
    open var topView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            if let newValue = topView {
                
                scrollView.addSubview(newValue)
                
                drawPanels()
            }
        }
    }
    open var bottomView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            if let newValue = bottomView {
                
                scrollView.addSubview(newValue)
                
                drawPanels()
            }
        }
    }
    
    // MARK: UI
    fileprivate let scrollView = UIScrollView()
    
    // MARK: Parameters
    open var numberOfColumns = 1 {
        didSet {
            if numberOfColumns < 1 {
                print("numberOfColumns of \(self) was set to \(numberOfColumns) but may not be less than 1. Setting to 1...", terminator: "")
                numberOfColumns = 1
            }
            
            if oldValue != numberOfColumns {
                drawPanels()
            }
        }
    }
    
    
    open var betweenBufferForColumns = CGFloat(0) {
        didSet {
            if oldValue != betweenBufferForColumns {
                drawPanels()
            }
        }
    }
    open var betweenBufferForRows = CGFloat(0) {
        didSet {
            if oldValue != betweenBufferForRows {
                drawPanels()
            }
        }
    }
    open var sideBuffer = CGFloat(0) {
        didSet {
            if oldValue != sideBuffer {
                drawPanels()
            }
        }
    }
    open var topBuffer = CGFloat(0) {
        didSet {
            if oldValue != topBuffer {
                drawPanels()
            }
        }
    }
    
    fileprivate var widthOfPanels = CGFloat(0)
    
    
    
    
    
    // **********************************************************************************************************************
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK:
    // MARK: Init
    // MARK:
    
    override public init (frame: CGRect = CGRect.zero, shouldAddAllUI: Bool = true) {
        super.init(frame: frame, shouldAddAllUI: shouldAddAllUI)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Should not be initializing from coder \(self)", terminator: "")
    }
    
    
    
    
    
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    
    // MARK: All
    override open func addAllUI() {
        
        addScrollView()
        
    }
    
    override open func updateAllUI() {
        
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
        scrollView.isScrollEnabled = scrollEnabled
        
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
    open func loadWithPanels(_ panels: [JABPanel]) {
        
        deleteAllPanels()
        self.panels = panels
        
    }
    
    open func addPanel(_ panel: JABPanel) {
        
        insertPanel(panel, atIndex: 0)
        drawPanels()
        
    }
    
    open func addPanel(_ panel: JABPanel, toColumn column: Int) {
        
        if column < numberOfColumns {
            panels.insert(panel, at: column)
            drawPanels()
        }
        
    }
    
    open func insertPanel(_ panel: JABPanel, atIndex index: Int) {
        
        for i in 0..<panels.count {
            let preexistingPanel = panels[i]
            if preexistingPanel == panel {
                panels.remove(at: i)
            }
        }
        
        if panels.count > index {
            panels.insert(panel, at: index)
        } else {
            panels.append(panel)
        }
        
        panel.addSubscriber(self)
        drawPanels()
        
    }
    
    open func removeAllPanels () {
        for subview in scrollView.subviews {
            if subview != topView && subview != bottomView {
                subview.removeFromSuperview()
            }
        }
    }
    
    open func deleteAllPanels () {
        removeAllPanels()
        panels.removeAll(keepingCapacity: true)
    }
    
    open func frameOfNegativePanelWithHeightToWidthRatio (_ heightToWidthRatio: CGFloat, staticAdditionToHeight: CGFloat, forColumn column: Int) -> CGRect {
        
        var hypotheticalFrame = CGRect.zero;
        hypotheticalFrame.size.width = widthOfPanels;
        hypotheticalFrame.size.height = (hypotheticalFrame.size.width * heightToWidthRatio) + staticAdditionToHeight;
        
        hypotheticalFrame.origin.x = sideBuffer + (CGFloat(column) * (widthOfPanels + betweenBufferForColumns));
        hypotheticalFrame.origin.y = -hypotheticalFrame.size.height;
        
        return hypotheticalFrame;
        
    }
    
    open func frameOfPanelRelativeToScrollView (_ panel: JABPanel?) -> CGRect? {
        
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
    
    open func panelAtIndex (_ index: Int?) -> JABPanel? {
        
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
    
    open func indexOfPanel (_ panel: JABPanel?) -> Int? {
        
        for i in 0..<panels.count {
            if panels[i] === panel {
                return i
            }
        }
        
        return nil
        
    }
    
    
    open func bringPanelToFront (_ panel: JABPanel?) {
        if panel != nil {
            scrollView.bringSubview(toFront: panel!)
        }
    }
    
    
    
    // MARK: Private
    fileprivate func drawPanels () {
        
        for panel in panels {
            if !scrollView.subviews.contains(panel as UIView) {
                scrollView.addSubview(panel)
            }
        }
        
        updateWidthOfPanels()
        assignColumns()
        
        positionTopView()
        
        for i in 0..<numberOfColumns {
            drawColumn(i)
        }
        
        positionBottomView()
        
        adjustContentSize()
        
    }
    
    fileprivate func positionTopView () {
        
        if topView != nil {
            topView!.x = (width - topView!.width)/2
            topView!.y = topBuffer
        }
    }
    
    fileprivate func positionBottomView () {
        
        if bottomView != nil {
            bottomView!.x = (width - bottomView!.width)/2
            if let lastPanel = panels.last {
                bottomView!.y = lastPanel.bottom
            }
        }
    }
    
    fileprivate func updateWidthOfPanels () {
        
        let emptyHorizontalSpace = (2*sideBuffer) + (CGFloat((numberOfColumns - 1)) * betweenBufferForColumns)
        widthOfPanels = (width - emptyHorizontalSpace)/CGFloat(numberOfColumns)
        
    }
    
    fileprivate func assignColumns () {
        
        columns.removeAll(keepingCapacity: true)
        for _ in 0..<numberOfColumns {
            columns.append([JABPanel]())
        }
        
        for i in 0..<panels.count {
            columns[i%numberOfColumns].append(panels[i])
        }
        
    }
    
    fileprivate func drawColumn (_ column: Int) {
        
        let columnArray = columns[column]
        
        for i in 0..<columnArray.count {
            let currentPanel = columnArray[i]
            
            var newFrame = CGRect.zero
            
            newFrame.origin.x = sideBuffer + (CGFloat(column) * (widthOfPanels + betweenBufferForColumns))
            
            if i == 0 {
                if topView != nil {
                    newFrame.origin.y = (2 * topBuffer) + topView!.height
                } else {
                    newFrame.origin.y = topBuffer
                }
            } else {
                newFrame.origin.y = columnArray[i-1].bottom + betweenBufferForRows
            }
            
            newFrame.size.width = widthOfPanels
            newFrame.size.height = (newFrame.size.width * currentPanel.heightToWidthRatio) + currentPanel.staticAdditionToHeight
            
            currentPanel.frame = newFrame
        }
        
    }
    
    fileprivate func adjustContentSize () {
        
        var lowestPoint = CGFloat(0)
        
        if bottomView != nil {
            lowestPoint = bottomView!.bottom
        } else {
            for column in columns {
                let locallyLowestFrame = column.last?.frame
                if locallyLowestFrame != nil {
                    if locallyLowestFrame!.bottom > lowestPoint {
                        lowestPoint = locallyLowestFrame!.bottom
                    }
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
    // MARK: Delegate
    // MARK:
    
    // MARK: Panel
    open func panelWasTapped(_ panel: JABPanel) {
        for i in 0 ..< panels.count {
            if panels[i] === panel {
                delegate?.paneledScrollViewPanelWasTapped(self, panel: panel, panelIndex: i)
            }
        }
    }
    
    open func panelWasLongPressed(_ panel: JABPanel) {
        
        for i in 0 ..< panels.count {
            if panels[i] === panel {
                delegate?.paneledScrollViewPanelWasLongPressed(self, panel: panel, panelIndex: i)
            }
        }
        
    }
    
    
    
    // MARK:
    // MARK: Subscriptions
    // MARK:
    
    // MARK: Panels
    open func panelContentsDidChange(_ panel: JABPanel) {
        
    }
}

public protocol JABPaneledScrollViewDelegate: class {
    func paneledScrollViewPanelWasTapped (_ paneledScrollView: JABPaneledScrollView, panel: JABPanel, panelIndex: Int)
    func paneledScrollViewPanelWasLongPressed (_ paneledScrollView: JABPaneledScrollView, panel: JABPanel, panelIndex: Int)
}
