![logo](https://github.com/rai-rajeev/Task_manager/assets/106883666/29b15057-5532-4355-9013-5c9a3e9311fd)

# Task Manager
The task management app is a mobile application built using the Flutter framework and integrated with Firebase Firestore for real-time data storage . The app allows users to create, view, update, and delete tasks. It enables users to keep track of their tasks and manage their to-do lists efficiently.
# Features
+ User Authentication (Using google oauth)
+ Task list screen
+ Real-time updates
+ Add new tasks
+ Update/delete task
# Tech Stack 

**Client:** Flutter

**Server:** Firebase

**DataBase:** Cloud Firestore

**External API used:** Goagle oauth

# screenshots
![6d7d8b61-d6b4-4476-9f60-aa927bb559c3](https://github.com/rai-rajeev/Task_manager/assets/106883666/b45616e6-5b71-4206-8f24-1cb1abb7705a)


![03a92ac8-c3c9-4ea1-bd2b-b2b592478904](https://github.com/rai-rajeev/Task_manager/assets/106883666/657ecfa0-fe9a-42ea-81cb-38ab7677fb69)



# Installation
To get started with Task Manager, follow these steps:

1. Ensure that you have Flutter and Dart SDK installed on your machine. For installation instructions, refer to the official [Flutter documentation](https://docs.flutter.dev/get-started/install).
1. Clone the repository:
   
    ```bash
    git clone https://github.com/rai-rajeev/Task_manager.git
    ```
3. Install the dependencies:
   ```bash
   flutter pub get
5. Connect a physical device or emulator.
6. Run the app:
   ```bash
   flutter run
# Download Apk file
https://drive.google.com/file/d/1IWaIUCUomcyEh0CjfxzXZgSz3sU8EGNa/view?usp=sharing
# Demo
https://drive.google.com/file/d/181PpqBXEvoF6TAOJOuBMMa62LRocsp5c/view?usp=sharing
# Working of the App
Once you open the app if you are not a registered user app will redirect to google auth registration. From there, you can choose your email id to register. Once you are registered, you'll see a home page. 
## Home page 
The top left corner has a sidebar containing user details, add new task  and logout options.

it contains two buttons namely view all task and add new task which will direct user to  task list screen and new task creation screen respectively.
## Task list Screen 
it contains two icon button in a row one of which takes user back to home screen and while the other IconButton will navigate the user to the new task creation screen.

There is a list of tasks that have been created by users. Each task in the list displays essential details such as the task title.

When the user swipes a task from left to right, two options will appear: **View Task** and **Update Task**. These options allow users to view the task details and update the task information, respectively.
  
On swiping a task from right to left, the task will get deleted. This swipe action allows users to remove tasks they no longer need or have completed.
## New task creation screen
The same screen can behave differently based on the option from which the user is navigating to it. Let's summarize the behavior based on different entry points:

**Coming from "Add New Task" Option:**

If the user navigates to the screen from the "Add New Task" option, the screen will allow the user to create a new task. It will present a form or input fields where the user can enter the details of the new task, such as the title and  description. Once the user fills in the required information, they can save the task, and it will be added to their task list.

**Coming from "View Task" Option:**

If the user navigates to the screen from the "View Task" option (i.e from option  after swiping a task from left to right), the screen will display the details of the task in a read-only or view mode. The user can see the title and  description. However, they won't be able to edit or update the task from this view.

**Coming from "Update Task" Option:**

If the user navigates to the screen from the "Update Task" option (i.e from option after swiping a task from left to right), the screen will allow the user to edit and update the task details. It will present a form or input fields prefilled with the current details of the task. The user can make the necessary changes and save the updates to the task. 
# Author
 + [@rai-rajeev](https://github.com/rai-rajeev)
