//
//  ChartDataEntry.swift
//  Charts
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation

open class ChartDataEntry: ChartDataEntryBase, NSCopying
{
    /// the x value
    @objc open var x = 0.0

    /// 平滑过渡动画的起始 Y 值
    private var _fromY: Double = 0.0

    /// 是否启用平滑过渡动画
    private var _enableSmoothTransition: Bool = false

    public required init()
    {
        super.init()
    }
    
    /// An Entry represents one single entry in the chart.
    ///
    /// - Parameters:
    ///   - x: the x value
    ///   - y: the y value (the actual value of the entry)
    @objc public init(x: Double, y: Double)
    {
        super.init(y: y)
        self.x = x
    }
    
    /// An Entry represents one single entry in the chart.
    ///
    /// - Parameters:
    ///   - x: the x value
    ///   - y: the y value (the actual value of the entry)
    ///   - data: Space for additional data this Entry represents.
    
    @objc public convenience init(x: Double, y: Double, data: Any?)
    {
        self.init(x: x, y: y)
        self.data = data
    }
    
    /// An Entry represents one single entry in the chart.
    ///
    /// - Parameters:
    ///   - x: the x value
    ///   - y: the y value (the actual value of the entry)
    ///   - icon: icon image
    
    @objc public convenience init(x: Double, y: Double, icon: NSUIImage?)
    {
        self.init(x: x, y: y)
        self.icon = icon
    }
    
    /// An Entry represents one single entry in the chart.
    ///
    /// - Parameters:
    ///   - x: the x value
    ///   - y: the y value (the actual value of the entry)
    ///   - icon: icon image
    ///   - data: Space for additional data this Entry represents.
    
    @objc public convenience init(x: Double, y: Double, icon: NSUIImage?, data: Any?)
    {
        self.init(x: x, y: y)
        self.icon = icon
        self.data = data
    }
        
    // MARK: - Smooth Transition Animation

    /// 配置平滑过渡动画
    /// - Parameters:
    ///   - fromValue: 起始值（当前显示的值）
    ///   - toValue: 目标值（新的数据值）
    @objc open func configureSmoothTransition(from fromValue: Double, to toValue: Double) {
        self._fromY = fromValue
        self._enableSmoothTransition = true
        self.y = toValue
    }

    /// 禁用平滑过渡动画，回归默认动画
    @objc open func disableSmoothTransition() {
        self._enableSmoothTransition = false
        self._fromY = 0.0
    }

    /// 平滑过渡的起始值
    @objc open var fromY: Double {
        return _fromY
    }

    /// 是否启用平滑过渡动画
    @objc open var enableSmoothTransition: Bool {
        return _enableSmoothTransition
    }

    // MARK: NSObject

    open override var description: String
    {
        return "ChartDataEntry, x: \(x), y \(y)"
    }

    // MARK: NSCopying

    open func copy(with zone: NSZone? = nil) -> Any
    {
        let copy = type(of: self).init()

        copy.x = x
        copy.y = y
        copy.data = data
        copy._fromY = _fromY
        copy._enableSmoothTransition = _enableSmoothTransition

        return copy
    }
}

// MARK: Equatable
extension ChartDataEntry/*: Equatable*/ {
    open override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? ChartDataEntry else { return false }

        if self === object
        {
            return true
        }

        return y == object.y
            && x == object.x
    }
}
