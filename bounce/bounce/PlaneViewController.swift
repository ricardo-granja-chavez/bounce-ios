//
//  PlaneViewController.swift
//  bounce
//
//  Created by Ricardo Granja Chávez on 20/01/24.
//

import UIKit

class PlaneViewController: UIViewController {
    
    lazy var addImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "plus.circle.fill")
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFill
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addAction)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private var balls: [BallModel] = [.init()]
    private var ballDragged: BallModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(addImageView)
        NSLayoutConstraint.activate([
            addImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            addImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            addImageView.heightAnchor.constraint(equalToConstant: 60),
            addImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        self.addAction()
    }
    
    @objc private func addAction() {
        let newBall: BallModel = .init()
        self.balls.insert(newBall, at: .zero)
        self.view.insertSubview(newBall.ballView, at: .zero)
        newBall.start()
    }
}
