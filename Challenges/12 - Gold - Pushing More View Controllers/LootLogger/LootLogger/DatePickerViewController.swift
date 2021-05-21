import UIKit

class DatePickerViewController: UIViewController {
    var item: Item!
    
    @IBAction func onDateChanged(_ sender: UIDatePicker) {
        item.dateCreated = sender.date
    }
}
