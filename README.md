### Steps to Run the App
- Clone repo and should be able to build out of the box, no additional dependencies that requires install to run the app.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
- Architecture, implement MVVM for clear separation of concern
- UI, easy & simple UI, added webview for video so there is more than just the recipe name, cuisine type, and picture.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
5 Hours, first decided how the the app will be laid out and how I wanted to implement the API. (Used singleton since this is a one screen app there really only need to be one instance.)

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
- Decided to go with MVVM pattern as I feel like it makes testing relatively easy as you can just focus testing the view model due to the separation of business logic and UI.
- I did not end up setting up mock for unit tests but I do strongly prefer it in consideration of time. Therefore I have noticed flakiness within the unit tests.
- Singleton vs Dependency Injection, decided to skip the dependency injection to keep it simple for this small app over singleton pattern. It also made more sense as the required app is just 1 screen so why go through all the set up for this specific project, but another trade-off due to this would be singletons are less modular and therefore a little harder to test.

### Weakest Part of the Project: What do you think is the weakest part of your project?
- Unit tests, the ideal scenario would have everything locally mocked resulting in consistent outcome and can easily simulate variety of different solution.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
- No external dependencies
