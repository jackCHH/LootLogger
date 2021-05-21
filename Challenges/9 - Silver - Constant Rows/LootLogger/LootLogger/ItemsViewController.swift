import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(_ sender: UIButton) {
        let newItem = itemStore.createItem()
        
        tableView.beginUpdates()
        
        if let index = itemStore.allItems.firstIndex(of: newItem) {
            
            if(index == 0) {
                let noItemsPath = IndexPath(row:0, section: 1)
                tableView.deleteRows(at: [noItemsPath], with: .fade)
            }
            
            let indexPath = IndexPath(row:index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        tableView.endUpdates()
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        // If you are currently in editing mde...
        if isEditing {
            // Change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        } else {
            // Change text of button to inform user of state
            sender.setTitle("Done", for: .normal)
            
            //Enter editing mode
            setEditing(true, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // if the table view is aasking to commit a delete command
        if editingStyle == .delete, indexPath.section == 0{
            let item = itemStore.allItems[indexPath.row]
            
            tableView.beginUpdates()
            // Remove the item from the store
            itemStore.removeItem(item)
            
            // also remove that row from the table view with an animatoin
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            if(indexPath.row == 0 && itemStore.allItems.count == 0) {
                let noItemsPath = IndexPath(row:0, section: 1)
                tableView.insertRows(at: [noItemsPath], with: .automatic)
            }
            
            tableView.endUpdates()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1) {
            if(itemStore.allItems.count == 0) {
                return 1
            } else {
                return 0
            }
        } else {
            return itemStore.allItems.count
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instace of UITableViewCell with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        if(indexPath.section == 1) {
            cell.textLabel?.text = "No Items!"
            cell.detailTextLabel?.text = ""
        } else {
            let item = itemStore.allItems[indexPath.row]
            
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        }
        
        return cell
    }
}
