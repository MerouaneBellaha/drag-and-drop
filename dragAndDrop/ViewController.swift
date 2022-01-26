//
//  ViewController.swift
//  dragAndDrop
//
//  Created by Merouane Bellaha on 26/01/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mySecondView: UIView!

    private let myView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.backgroundColor = .red
        view.isUserInteractionEnabled = true
        return view
    }()

    private var isDragging = false
    private var targetedView: UIView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myView.center = view.center
    }
}

// MARK: - Touch management

extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        targetTouchedView(touch: touch, views: view.subviews.reversed())
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDragging,
              let touch = touches.first else {
            return
        }
        let location = touch.location(in: view)
        targetedView?.center = location
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDragging = false
    }

    private func targetTouchedView(touch: UITouch, views: [UIView]) {
        for view in views {
            let location = touch.location(in: view)
            if view.bounds.contains(location) {
                isDragging = true
                targetedView = view
                return
            }
        }
    }
}
