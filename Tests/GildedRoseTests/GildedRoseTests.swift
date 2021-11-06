@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {

    // MARK: - Inventory
    
    func test_updateQuality_onAnyItem_doesNotChangeNameOrOrderOfInventory() throws {
        // Given
        let items = [
            Item(name: "Healing potion", sellIn: 0, quality: 0),
            Item(name: "Mana potion", sellIn: 0, quality: 0),
            Item(name: "Stamina potion", sellIn: 0, quality: 0),
        ]
        let app = GildedRose(items: items)
        let expectedNames: [String] = app.items.map({ $0.name })
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items.map({ $0.name }), expectedNames)
    }
    
    // MARK: - Regular items
    
    func test_updateQuality_onRegularItem_decreasesSellInByOne() throws {
        // Given
        let items = [Item(name: "Healing potion", sellIn: 1, quality: 0)]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items[0].sellIn, 0)
    }
    
    func test_updateQuality_onRegularItem_beforeItsSellIn_decreasesQualityByOne() throws {
        // Given
        let items = [Item(name: "Healing potion", sellIn: 1, quality: 1)]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items[0].quality, 0)
    }
    
    func test_updateQuality_onRegularItem_pastItsSellIn_decreasesQualityByTwo() throws {
        // Given
        let items = [Item(name: "Healing potion", sellIn: 0, quality: 3)]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items[0].quality, 1)
    }
    
    func test_updateQuality_onRegularItem_doesNotDecreasesQualityPastZero() throws {
        // Given
        let items = [Item(name: "Healing potion", sellIn: 0, quality: 0)]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items[0].quality, 0)
    }
    
    // MARK: - Aged Brie
    
    func test_updateQuality_onAgedBrie_decreasesSellInByOne() throws {
        // Given
        let items = [Item(name: "Aged Brie", sellIn: 1, quality: 0)]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items[0].sellIn, 0)
    }
    
    func test_updateQuality_onAgedBrie_beforeItsSellIn_increasesQualityByOne() throws {
        // Given
        let items = [Item(name: "Aged Brie", sellIn: 1, quality: 0)]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items[0].quality, 1)
    }
    
    func test_updateQuality_onAgedBrie_pastItsSellIn_increasesQualityByTwo() throws {
        // Given
        let items = [Item(name: "Aged Brie", sellIn: 0, quality: 0)]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items[0].quality, 2)
    }
    
    func test_updateQuality_onAgedBrie_doesNotIncreaseQualityPast50() throws {
        // Given
        let items = [Item(name: "Aged Brie", sellIn: 0, quality: 50)]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items[0].quality, 50)
    }
    
    // MARK: - Sulfuras, Hand of Ragnaros
    
    func test_updateQuality_onSulfuras_doesNotChangeSellIn() throws {
        // Given
        let items = [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: -1, quality: 0)]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items[0].sellIn, -1)
    }
    
    func test_updateQuality_onSulfuras_doesNotChangeQuality() throws {
        // Given
        let items = [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: -1, quality: 80)]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items[0].quality, 80)
    }
    
    // MARK: - Backstage passes
    
    func test_updateQuality_onBackStagePasses_decreasesSellInByOne() throws {
        // Given
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 1, quality: 0)]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items[0].sellIn, 0)
    }
    
    func test_updateQuality_onBackStagePasses_withSellInRemainingMoreThan10_increasesQualityByOne() throws {
        // Given
        let items = [
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 20, quality: 0),
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 11, quality: 0),
        ]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        app.items.forEach {
            XCTAssertEqual($0.quality, 1, "Test failed on Backstage Pass with `\($0.sellIn)` remaining.")
        }
    }
    
    func test_updateQuality_onBackStagePasses_withSellInRemainingFrom10To5_increasesQualityByTwo() throws {
        // Given
        let items = [
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 0),
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 6, quality: 0),
        ]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        app.items.forEach {
            XCTAssertEqual($0.quality, 2, "Test failed on Backstage Pass with `\($0.sellIn)` remaining.")
        }
    }
    
    func test_updateQuality_onBackStagePasses_withSellInRemainingFrom5ToZero_increasesQualityByThree() throws {
        // Given
        let items = [
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 0),
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 1, quality: 0),
        ]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        app.items.forEach {
            XCTAssertEqual($0.quality, 3, "Test failed on Backstage Pass with `\($0.sellIn)` remaining.")
        }
    }
    func test_updateQuality_onBackStagePasses_pastItsSellIn_setsTheQualityToZero() throws {
        // Given
        let items = [
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 0, quality: 50),
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: -1, quality: 50),
        ]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        app.items.forEach {
            XCTAssertEqual($0.quality, 0, "Test failed on Backstage Pass with `\($0.sellIn)` remaining.")
        }
    }
    
    func test_updateQuality_onBackStagePasses_doesNotIncreaseQualityPast50() throws {
        // Given
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 50)]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items[0].quality, 50)
    }
    
    // MARK: - Conjured items
    
    func test_updateQuality_onConjuredItem_decreasesSellInByOne() throws {
        // Given
        let items = [Item(name: "Conjured Healing potion", sellIn: 1, quality: 0)]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items[0].sellIn, 0)
    }
    
    func test_updateQuality_onConjuredItem_beforeItsSellIn_decreasesQualityByTwo() throws {
        // Given
        let items = [Item(name: "Conjured Healing potion", sellIn: 1, quality: 2)]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items[0].quality, 0)
    }
    
    func test_updateQuality_onConjuredItem_pastItsSellIn_decreasesQualityByFour() throws {
        // Given
        let items = [Item(name: "Conjured Healing potion", sellIn: 0, quality: 4)]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items[0].quality, 0)
    }
    
    func test_updateQuality_onConjuredItem_doesNotDecreasesQualityPastZero() throws {
        // Given
        let items = [Item(name: "Conjured Healing potion", sellIn: 0, quality: 1)]
        let app = GildedRose(items: items)
        
        // When
        app.updateQuality()
        
        // Then
        XCTAssertEqual(app.items[0].quality, 0)
    }
    
    // MARK: - System helpers
    
    static var allTests = [
        ("test_updateQuality_onAnyItem_doesNotChangeNameOrOrderOfInventory", test_updateQuality_onAnyItem_doesNotChangeNameOrOrderOfInventory),
    ]
}
