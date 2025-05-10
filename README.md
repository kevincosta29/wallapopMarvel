<br>
<p align="center">
<img src="readme-resources/icon.png" class="center" alt="drawing" width="300"/>
</p>
<br>

# Marvel Comics

This project based on the Marvel [API](https://developer.marvel.com/docs), lists differents comics with information like:

- List characters
- Detail of character (image, information...)
    - Comics where appear
    - Series where appear

## Implemented functionality

1. Native implemented network with using [KNetwork](https://github.com/kevincosta29/swift-package-network).
2. Using Kingfisher to load image for the SwiftUI components
3. Architecture MVP
4. In addtion of MVP whe use a FlowManager to navigate between different controllers
5. For each controller we use a Configurator that set up the entire controller

## Character List
- Configurator: Setup everything that will need the Character List like presenter, data source, flow manager...
- Presenter: Have all the business logic related with
    - Retrieve all characters and make pagination
    - Filter for searchs
    - Navigation to the detail of the character
- Data Sources: Class in charge to retrieve all the necessary data
- Views: 
    - Controller with a table view to display all the characters
    - Cell for each row that is displayed
    - Custom view in SwiftUI to display the content of the cell

## Character Detail
- Configurator: Setup everything that will need the Character List like presenter, data source, flow manager...
- Presenter: Have all the business logic related with
    - Retrieve all characters and make pagination
    - Filter for searchs
    - Navigation to the detail of the character
- Data Sources: Class in charge to retrieve all the necessary data
- Views: 
    - Controller with scroll view and stack that will contain all the different sections of the detail
    - Header view in SwiftUI containing image, title and description of the character
    - Section View in SwiftUI that contanins a title of the seciton and a horizontal scroll to display comics or series
    - Section Item View is reusable view in SwiftUI that will display the title of the comic or serie and image