# 🍽️ MyFoodApp — Java Food Ordering System

A web-based food ordering application developed using **Java, JEE Servlets, JSP, JDBC, and MySQL**. MyFoodApp allows users to browse restaurants, explore menus, add food items to their cart, place orders, and manage their profiles. It also provides administrative features for managing restaurants, menu items, users, and orders.

## 📌 Table of Contents

- [About the Project](#-about-the-project)
- [Features](#-features)
- [Technologies Used](#-technologies-used)
- [Project Structure](#-project-structure)
- [Application Screenshots](#-application-screenshots)
- [Project Demo](#-project-demo)
- [Database Configuration](#-database-configuration)
- [How to Run the Project](#-how-to-run-the-project)
- [Future Enhancements](#-future-enhancements)
- [Author](#-author)

## 📖 About the Project

MyFoodApp is a Java web application designed to provide a simple and convenient online food ordering experience. It follows a layered architecture using DAO classes, DAO implementations, model classes, servlets, JSP pages, and a MySQL database.

The application separates business logic, database operations, and presentation to make the project easier to maintain and extend.

## ✨ Features

### 👤 User Features

- User registration and login
- Restaurant listing and browsing
- View restaurant menus and food items
- Add items to the shopping cart
- Update and manage cart items
- Checkout and place food orders
- View order history and order details
- Manage user profile
- Change password
- Forgot password page
- Account management

### 🛠️ Admin Features

- Admin dashboard
- Add, edit, delete, and search restaurants
- Add, edit, delete, and search menu items
- View and manage users
- View orders and order items
- Manage restaurant and menu information

### 🧩 Technical Features

- Java-based server-side application
- Servlet-based request handling
- JSP pages for dynamic content
- JDBC database connectivity
- DAO pattern for database operations
- Session-based user and cart management
- MySQL relational database
- CSS-based responsive and organized interface

## 🧰 Technologies Used

| Technology | Purpose |
|---|---|
| Java | Application logic |
| JEE Servlets | Request handling |
| JSP | Dynamic web pages |
| JDBC | Database connectivity |
| MySQL | Relational database |
| HTML5 | Web page structure |
| CSS3 | Styling and layout |
| Apache Tomcat 10.1 | Web application server |
| Eclipse IDE | Development environment |
| Git and GitHub | Version control and project hosting |

## 📂 Project Structure

```text
MyFoodApp/
├── src/
│   └── main/
│       ├── java/
│       │   └── com.myfoodapp/
│       │       ├── dao/
│       │       ├── daoimp/
│       │       ├── model/
│       │       ├── servlet/
│       │       └── util/
│       │           └── DBConnection.java
│       └── webapp/
│           ├── components/
│           ├── css/
│           ├── videos/
│           ├── WEB-INF/
│           │   ├── lib/
│           │   └── web.xml
│           ├── login.html
│           ├── signup.html
│           ├── restaurant.jsp
│           ├── menu.jsp
│           ├── cart.jsp
│           ├── checkout.jsp
│           ├── myorders.jsp
│           ├── profile.jsp
│           └── adminDashboard.jsp
├── .gitignore
├── .project
├── .classpath
├── LICENSE
└── README.md
```

*Note: This structure highlights the main folders and example files. The repository contains additional JSP pages, servlets, DAO classes, and stylesheets.*

## 📸 Application Screenshots

Add screenshots of your actual application in the `screenshots/` folder of this repository.

### 🏠 Home Page

![MyFoodApp Home Page](screenshots/home.png)

### 🍴 Restaurant Listing

![Restaurant Listing](screenshots/restaurants.png)

### 🍕 Menu Page

![Menu Page](screenshots/menu.png)

### 🛒 Shopping Cart

![Shopping Cart](screenshots/cart.png)

### 💳 Checkout Page

![Checkout Page](screenshots/checkout.png)

### 📊 Admin Dashboard

![Admin Dashboard](screenshots/admin-dashboard.png)

## 🎥 Project Demo

Watch the project demonstration to see the application workflow, including restaurant browsing, menu selection, cart management, ordering, and administration.

**▶️ [Watch the MyFoodApp Demo](YOUR_YOUTUBE_VIDEO_LINK_HERE)**

*Replace the placeholder with your actual YouTube video link.*

## 🗄️ Database Configuration

MyFoodApp uses MySQL to store application data.

1. Install and start MySQL Server.
2. Create a database for the application.
3. Create the required tables for users, restaurants, menu items, orders, and order items.
4. Update the database connection details in `DBConnection.java`.
5. Ensure that the MySQL JDBC driver is available to the application.

Example database creation:

```sql
CREATE DATABASE foodapp;
```

Update your database connection settings to match your local environment. Do not commit database passwords or other sensitive credentials to GitHub.

## 🚀 How to Run the Project

### Prerequisites

- Java JDK compatible with your project
- Eclipse IDE
- Apache Tomcat 10.1
- MySQL Server
- MySQL JDBC driver

### Installation Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/manohar-leo99/MyFoodApp.git
   ```

2. Open Eclipse IDE.

3. Import the project using **File → Import → Existing Projects into Workspace**.

4. Configure Apache Tomcat 10.1 in Eclipse.

5. Configure the MySQL database connection in `DBConnection.java`.

6. Create the database and required tables.

7. Add or verify the required JDBC library.

8. Run the project on the Tomcat server.

9. Open the application URL provided by Tomcat in your browser.

**Important:** Verify that your servlet API imports and dependencies are compatible with Tomcat 10.1 before running the application.

## 🔮 Future Enhancements

- Online payment gateway integration
- Food search and filtering
- Restaurant ratings and reviews
- Order status tracking
- Email notifications
- Improved mobile responsiveness
- Deployment to a cloud hosting platform

## 👨‍💻 Author

**Manohar Medabalam**

- GitHub: [@manohar-leo99](https://github.com/manohar-leo99)
- Project Repository: [MyFoodApp](https://github.com/manohar-leo99/MyFoodApp)

---

⭐ If you find this project interesting, consider giving the repository a star!

