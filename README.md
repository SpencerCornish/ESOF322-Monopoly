### ESOF 322 Group #2
#### members:
    Spencer Cornish
    Nate Tranel
    Bryan Plant
    Keely Weisbeck

SOF 322 Team 2: Spencer Cornish, Bryan Plant, Nate Tranel, Keely Weisbeck

1) Since we used Dart, we did not have external .jar file dependencies. We did have external
dependencies, however: dart_dev 1.8.1; dart_style 1.0.8; coverage 0.9.3; test 0.12.25;
browser 0.10.0; and dart_to_js_script_rewriter 1.0.1. These can be seen in the pubspec.yaml
file in our GitHub repository for Monopoly.

2) To run our program, the user must have the Dart VM and the Dartium browser installed.  From here the
project will run intuitively. However, we plan to demo the project as was asked initially.
```
 ___________________________________________________________________________________________________________
|                                                                                                           |
|      Detailed list of steps to run this:                                                                  |
|___________________________________________________________________________________________________________|
|  Mac:                                                                                                     |
|    - Install the Homebrew Package manager with this command below:                                        |
|        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)  |
|    - update Homebrew with this command:                                                                   |
|        brew update                                                                                        |
|    - Install Dart and its dependencies with these commands:                                               |
|        brew tap dart-lang/dart                                                                            |
|        brew install dart --with-content-shell --with-dartium                                              |
|    - You should now be able to navigate to the project folder (/esof322/pa4/Monopoly/) and                |
|      run this to get dependencies:                                                                        |
|        pub get                                                                                            |
|    - Now, you can serve this to the browser                                                               |
|        pub serve                                                                                          |
|    - Open Dartium and navigate to localhost:8080                                                          |
|        Dartium                                                                                            |
|    * If Dartium is not found, manually install from this link: https://webdev.dartlang.org/tools/dartium  |
|___________________________________________________________________________________________________________|
```

3) Strong points of our implementation: the application could easily be web hosted and dart
allowed us to use features that are very visually appealing with minimal overhead. There is
a nice menu at the start to pick the theme for the board. The board rescales to the user's
browser size, so it can be run on a variety of resolutions. The buttons available to the
player reflect choices the player is allowed to make, so it essentially catches most errors
before they happen. The auction, mortgage, and buy/sell building menus are done with modals,
which provide a visually appealing pop-up menu with value checking for the menus. The player
is also provided with a list of the properties they own, although the list does not indicate
the property color. If a property is mortgaged, it is indicated on the board with an "M."

Things that we could improve include the interface with which the player interacts with the
buttons. Though it calculates everything nicely, it is fairly simple. The cost of properties
is displayed from this menu, though the readout is not abundantly clear. Additionally, the
game is missing Community Chest and Chance cards, which are fun to play with. Since we chose
to implement an AI player for this second iteration, those cards were not implemented. If
the project were to have more stages, it would be fun to implement bankruptcies and have a
menu of popular house rules to put into play. Additionally, a customizable theme would make
the product appealing to players. We could improve the overall design of the GUI given more
time, but that can be a very long process. Test coverage could also be improved, though
we test all functionality. The additional test cases would have to use query selectors and
simulate the app environment, and would end up being almost as complicated as the AI
player was to implement. Though we recognize the importance of testing the GUI functions
as well as the other functions, it is apparent that the GUI functions correctly when
looking at it. Finally, the implementation of a player choice trading menu would be very
cool, but that alone could be another iteration, as there are a lot of variables to handle.
If we were to implement trading, we would probably use a modal menu.

Overall, we are very impressed with our work and can use this project as a resume point in
the future, as we gained plenty of experience developing software as a team with frequent
meetings, using a version control system, and following an agile development process to
get this project done.
