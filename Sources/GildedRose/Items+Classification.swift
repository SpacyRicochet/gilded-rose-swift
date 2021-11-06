extension Item {
    func updateQuality() {
        switch classification {
            case .regular:
                let decrease = sellIn > 0 ? 1 : 2
                quality -= decrease
            
            case .agedBrie:
                let increase = sellIn > 0 ? 1 : 2
                quality += increase
                
            case .sulfuras:
                quality = 80
                
            case .backstagePass:
                if sellIn > 10 {
                    quality += 1
                } else if sellIn > 5 {
                    quality += 2
                } else if sellIn > 0 {
                    quality += 3
                } else {
                    quality = 0
                }
                
            case .conjured:
                let decrease = sellIn > 0 ? 2 : 4
                quality -= decrease
        }
        
        if classification != .sulfuras {
            quality = min(quality, 50)
            sellIn -= 1
        }
        quality = max(quality, 0)
    }
}

private extension Item {
    enum Classification {
        case regular
        case agedBrie
        case sulfuras
        case backstagePass
        case conjured
    }
    
    var classification: Classification {
        if name == "Aged Brie" {
            return .agedBrie
        }
        else if name == "Sulfuras, Hand of Ragnaros" {
            return .sulfuras
        }
        else if name == "Backstage passes to a TAFKAL80ETC concert" {
            return .backstagePass
        }
        else if name.hasPrefix("Conjured") {
            return .conjured
        }
        else {
            return .regular
        }
    }
}
