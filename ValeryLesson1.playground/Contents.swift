class Math {
    let x: Int
    let y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func sum() {
        let sum = x + y
        print(sum)
    }
    
    func subtraction() {
        let sub = x - y
        print(sub)
    }
    
    func division() {
        let div = x/y
        print(div)
    }
    
    func multiplication() {
        let mul = x * y
        print(mul)
    }
}

let firstItem = Math(x: 8, y: 3)
firstItem.sum()
firstItem.subtraction()
firstItem.division()
firstItem.multiplication()
