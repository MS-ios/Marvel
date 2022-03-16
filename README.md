# About

The purpose of this project is to develop an app app that shows a list of Marvel characters and allows to see the details of each of them individually.

The app leverages the Marvel API to display descriptions and images of the characters in the Marvel universe.

This project has been built using:
  1. Swift,
  2. UIKit, 
  3. Storyboards and nibs,
  4. MVVM architecture and
  5. No third party dependencies.


# Features
- **Characters List:** displays a list of characters and their thumbnails.

- **Character detail:** displays a picture of a character and its full description.

![Simulator Screen Shot - iPhone SE (2nd generation) - 2022-03-16 at 16 16 03](https://user-images.githubusercontent.com/54179274/158573085-dbfd1bd7-88d8-4f54-8f27-7457b946e546.png)

![Simulator Screen Shot - iPhone SE (2nd generation) - 2022-03-16 at 16 16 15](https://user-images.githubusercontent.com/54179274/158573141-9bef9824-82d1-4463-b987-d3e93b23181a.png)


# Architecture
This app has been developed using MVVM architectural pattern, which is a combination of the Model-View-ViewModel architecture. In this implementation, the binding between the Views and the ViewModels is done via closures. The app has three major layers:

- **The Presentation layer,** which contains the views and other UIKit-related units.

- **The Domain layer,** which contains the entities and use cases.

- **The Data layer,** which contains the networking and local data handling, as well as the models and authentication logic needed to connect to the Marvel API.

## Download and run
- **Clone:** First, clone the repository with the 'clone' command.

```sh
$ git clone git@github.com:MS-ios/Marvel.git
```

- **Marvel API keys:** Set your Marvel API keys as constants in ApiConstants file. Go to Marvel -> Services -> ApiConstants.swift file, and edit _privateKey_ and _apiKey_ .
