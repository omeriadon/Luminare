# ``Luminare/LuminareButtonCompose``

A horizontalrow of Luminare buttons.

With optional parameter ``LuminareButtonComposePosition``, to set whether this is at the bottom or top of a list to adjust button rounding behaviour.

@Row {
    @Column {
        ```swift
        LuminareButtonCompose(.bottom) {
            Button {
                print(1)
            } label: {
                Text("Button 1")
            }
            
            Button {
                print(2)
            } label: {
                Text("Button 2")
            }
            
            Button {
                print(3)
            } label: {
                    Text("Button 3")
            }
        }
        ```
    }
}

@Row {
    @Column {
        ![LuminareButtonCompose](LuminareButtonCompose)
    }
}

## Topics

### Position

- ``LuminareButtonComposePosition``
