import UIKit

class ItemStore {
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func getOver50count() -> Int{
       var count = 0
        
        for item in allItems {
            if item.valueInDollars >= 50 {
                count += 1
            }
        }
        
        return count
    }
    
    func getLess50count() -> Int{
        var count = 0
        
        for item in allItems {
            if item.valueInDollars < 50 {
                count += 1
            }
        }
        
        return count
    }
    
    func getOver50() -> [Item]{
       var items = [Item]()
        
        for item in allItems {
            if item.valueInDollars >= 50 {
                items.append(item)
            }
        }
        
        return items
    }
    
    func getLess50() -> [Item]{
        var items = [Item]()
        
        for item in allItems {
            if item.valueInDollars < 50 {
                items.append(item)
            }
        }
        
        return items
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // get reference to object being movoed so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        // Remove item from array
        allItems.remove(at: fromIndex)
        
        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
}
