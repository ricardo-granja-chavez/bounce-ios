//
//  PlaneEntity.swift
//  bounce
//
//  Created by Ricardo Granja Chávez on 20/01/24.
//

import UIKit

let screenWidth: CGFloat = UIScreen.main.bounds.width
let screenHeight: CGFloat = UIScreen.main.bounds.height

class BallModel {
    enum HorizontalDirection: CaseIterable {
        case left
        case right
    }
    
    enum VerticalDirection: CaseIterable {
        case up
        case down
    }
    
    lazy var ballView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: CGFloat(arc4random()) / CGFloat(UInt32.max),
                                       green: CGFloat(arc4random()) / CGFloat(UInt32.max),
                                       blue: CGFloat(arc4random()) / CGFloat(UInt32.max),
                                       alpha: 1.0)
        view.layer.cornerRadius = self.size / 2
        return view
    }()
    
    private let id: UUID = UUID()
    private let size: CGFloat = 50.0
    private var minX: CGFloat = .zero { didSet { self.setPosition(x: self.minX, y: self.minY) } }
    private var maxX: CGFloat = .zero
    private var minY: CGFloat = .zero { didSet { self.setPosition(x: self.minX, y: self.minY) } }
    private var maxY: CGFloat = .zero
    
    private var horizontal: HorizontalDirection = .right
    private var vertical: VerticalDirection = .up
    
    private var timer: Timer?
    private var timeInterval: Double = 0.0001
    private var workItem: DispatchWorkItem?
    
    init() {
        self.minX = CGFloat.random(in: 0..<screenWidth)
        self.minY = CGFloat.random(in: 0..<screenHeight)
        
        if let random = HorizontalDirection.allCases.randomElement() {
            self.horizontal = random
        }
        if let random = VerticalDirection.allCases.randomElement() {
            self.vertical = random
        }
        ballView.frame = CGRect(x: self.minX, y: self.minY, width: self.size, height: self.size)
    }
    
    func start() {
        self.workItem = DispatchWorkItem {
            self.timerAction()
        }
        
        if let workItem = self.workItem {
            DispatchQueue.global(qos: .background).async(execute: workItem)
        }
    }
    
    private func setPosition(x: CGFloat, y: CGFloat) {
        DispatchQueue.main.async {
            self.maxX = x + self.size
            self.maxY = y + self.size
            self.ballView.frame.origin = CGPoint(x: x, y: y)
        }
    }
    
    @objc private func timerAction() {
        let value: CGFloat = 1
        
        while true {
            if self.horizontal == .right && self.vertical == .up {
                self.minX += value
                self.minY -= value
            } else if self.horizontal == .right && self.vertical == .down {
                self.minX += value
                self.minY += value
            } else if self.horizontal == .left && self.vertical == .up {
                self.minX -= value
                self.minY -= value
            } else if self.horizontal == .left && self.vertical == .down {
                self.minX -= value
                self.minY += value
            }
            
            if self.maxX >= screenWidth {
                self.horizontal = .left
            } else if self.minX <= .zero {
                self.horizontal = .right
            }
            
            if self.maxY >= screenHeight {
                self.vertical = .up
            } else if self.minY <= .zero {
                self.vertical = .down
            }
            
            usleep(500)
        }
    }
}
