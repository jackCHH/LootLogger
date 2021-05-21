import UIKit

class ItemStore {
    var showOnlyFavorite: Bool = false
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
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
    
    func toggleShowOnlyFavorite() {
        self.showOnlyFavorite = !self.showOnlyFavorite
    }
    
    func getItem() -> [Item] {
        if(showOnlyFavorite) {
            return allItems.filter {$0.isFavorite == true }
        } else {
            return allItems
        }
    }
}
