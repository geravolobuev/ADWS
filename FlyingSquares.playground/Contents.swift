import UIKit
import PlaygroundSupport

let liveViewFrame = CGRect(x: 0, y: 0, width: 500, height: 500)
let liveView = UIView(frame: liveViewFrame)
liveView.backgroundColor = .gray

PlaygroundPage.current.liveView = liveView

let smallFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
let square = UIView(frame: smallFrame)
square.backgroundColor = .systemPink

UIView.animate(withDuration: 3.0, animations:  {
    square.backgroundColor = .blue
    square.frame = CGRect(x: 50, y: 100, width: 150, height: 150)
}) { (_) in
    
    UIView.animate(withDuration: 3.0) {
        square.frame = smallFrame
        square.backgroundColor = .systemPink
    }
}

liveView.addSubview(square)

/* */

let rightCornerFrame = CGRect(x: 450, y: 450, width: 50, height: 50)
let rightCornerSquare = UIView(frame: rightCornerFrame)
rightCornerSquare.backgroundColor = .yellow

UIView.animate(withDuration: 3.0, delay: 2.0, options: [], animations: {
    rightCornerSquare.backgroundColor = .green
    rightCornerSquare.frame = CGRect(x: 250, y: 250, width: 50, height: 50)
}, completion: { (_) in
    UIView.animate(withDuration: 1.0) {
        rightCornerSquare.frame = rightCornerFrame
    }
})

liveView.addSubview(rightCornerSquare)

/* */

let centerSquareFrame = CGRect(x: 250, y: 250, width: 50, height: 50)
let centerSquare = UIView(frame: centerSquareFrame)
centerSquare.backgroundColor = .black

UIView.animate(withDuration: 3.0, animations: {
    let translate = CGAffineTransform(translationX: 20, y: 30)
    let rotate = CGAffineTransform(rotationAngle: .pi)
    let scale = CGAffineTransform(scaleX: 2.0, y: 2.0)
    let comboTransform = translate.concatenating(rotate).concatenating(scale)
    
    centerSquare.transform = comboTransform
}, completion:  { (_) in
    UIView.animate(withDuration: 2.0, animations: {
        centerSquare.transform = CGAffineTransform.identity
    })
})

liveView.addSubview(centerSquare)
