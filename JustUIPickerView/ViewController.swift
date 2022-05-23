
import UIKit

class ViewController: UIViewController {
    
    let universe = ["Marvel", "DC"]
    let dcPersons = ["Aquaman","Batman","Superman","Wonderwoman"]
    let marvelPersons = ["Hulk","Ironman","Spiderman","Groot"]

    lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.center.x = view.center.x
        picker.center.y = view.center.y + 200
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 100, width: view.frame.width - 50, height: view.frame.height / 2))
        imageView.center.x = view.center.x
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowColor = UIColor.lightGray.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowOpacity = 15
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 50))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .darkGray
        label.text = "Chose your hero:"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(picker)
        view.addSubview(imageView)
        view.addSubview(label)
    }

    func setImage(name: String) {
        guard let newImage = UIImage(named: name) else { return }
        imageView.image = newImage
    }
}


extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return universe.count
        } else {
            return dcPersons.count > marvelPersons.count ? marvelPersons.count : dcPersons.count
        }
    }
    
}

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return universe[row]
        } else {
            if picker.selectedRow(inComponent: 0) == 0 {
                return marvelPersons[row]
            } else {
                return dcPersons[row]
            }
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            picker.reloadComponent(1)
            if picker.selectedRow(inComponent: 0) == 0 {
                setImage(name: marvelPersons[pickerView.selectedRow(inComponent: 1)])
            } else {
                setImage(name: dcPersons[pickerView.selectedRow(inComponent: 1)])
            }
        } else {
            if picker.selectedRow(inComponent: 0) == 0 {
                setImage(name: marvelPersons[row])
            } else {
                setImage(name: dcPersons[row])
            }
        }
    }
}
