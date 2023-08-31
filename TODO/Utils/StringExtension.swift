import Foundation
import UIKit
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    func loadAsyncImage(_ imageView: UIImageView) {
        URLSession.shared.dataTask(with: URL(string: self)!) { data, response, error in
            guard let data = data,
                  response != nil,
                  error == nil else { return }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data) ?? UIImage()
            }
        }.resume()
    }
}
