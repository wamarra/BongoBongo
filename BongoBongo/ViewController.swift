//
//  ViewController.swift
//  BongoBongo
//
//  Created by Wesley Marra on 14/10/21.
//

import UIKit

class
ViewController: UIViewController {

    private var timer: Timer?
    private var animator: UIDynamicAnimator?
    private var behavior: SquareBehavior?
    private var squares = [UIView]()
    
    @IBOutlet weak var board: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
            board.isUserInteractionEnabled = true
            board.addGestureRecognizer(tap)
            animator = UIDynamicAnimator(referenceView: board)
            behavior = SquareBehavior()
            animator?.addBehavior(behavior!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTimerForExplode()
    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer) {
        let pointTapped = sender.location(in: board)
        createSquare(at: pointTapped)
    }
    
    @objc func createExplode() {
        guard squares.count > 0 else { return }
        
        squares.forEach({behavior?.removeItem($0)})
        
        UIView.animate(withDuration: 1) {
            self.explodeSquares()
        } completion: { finished in
            self.squares.forEach({self.behavior?.removeItem($0)})
            self.squares.forEach({$0.removeFromSuperview()})
            self.squares.removeAll()
        }
    }
    
    private func explodeSquares() {
        for sq in self.squares {
            let x = arc4random() % UInt32(self.board.bounds.size.width * 5)
            let y = self.board.bounds.size.height
            sq.center = CGPoint(x: CGFloat(x), y: -y)
        }
    }
    
    private func createTimerForExplode() {
        if timer == nil {
            let timer = Timer.scheduledTimer(
                timeInterval: 10,
                target: self,
                selector: #selector(createExplode),
                userInfo: nil,
                repeats: true)
            
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
            self.timer = timer
        }
    }
    
    private func createSquare(at point: CGPoint) {
        let frame = CGRect(origin: point, size: CGSize(width: 30, height: 30))
                
        let square = UIView(frame: frame)
        square.backgroundColor = UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1)
        
        board.addSubview(square)
        squares.append(square)
        behavior?.addItem(square)
    }
    
    @IBAction func onSquare(_ sender: UIButton) {
        let x = arc4random() % UInt32(board.bounds.size.width)
        let point = CGPoint(x: Int(x), y: 0)
        createSquare(at: point)
    }
    
    @IBAction func onExplode(_ sender: UIButton) {
        createExplode()
    }
}

