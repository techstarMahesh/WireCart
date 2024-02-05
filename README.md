# About this project
This is an E-Commerce Application using Python(Django). In this app, we can perform admin, and user-related actions needed to run an e-commerce company. 

## E-commerce website name is **[WireCart](https://techstarmahesh.github.io/WireCart/)**
- Star this repo on [GitHub](https://github.com/techstarMahesh/WireCart)
- Check out the [WireCart website](https://techstarmahesh.github.io/WireCart/)
- [Mahesh Final Project Report.docx](https://github.com/techstarMahesh/WireCart/files/13772927/Mahesh.Final.Project.Report.docx)


## Language use to develop this website
- Python Django Framework 
- Bootstrap Framework
- Font-Awesome Library
- jQuery (for animation)
- Google Fonts API
- HTML5 & CSS3
- JavaScript 
- AJAX 
- JSON 
- MySQL Lite Database

## What is WireCart?
WireCart is a E-commerce website that is used to sell products.

## What actions can be done in WireCart?
### Admin Privilege
- Add new product
- Edit product
- Delete product
- Add new category
- Edit category
- Delete category
- Add new user
- Edit user
- Delete user
- Add new order
- Edit order
- Delete order
- Add new shipping method
- Edit shipping method
- Delete shipping method

### User Privilege
- Log in
- Log out
- Register
- Reset password
- Change password
- add to cart
- remove from cart
- add to wishlist
- remove from wishlist
- checkout
- view cart
- View product
- View category
- View user
- View order
- View shipping method
- View cart
- View wishlist
- View order history
- View order detail

## How to install in your computer?

### Clone project

```bash
git clone https://github.com/techstarMahesh/WireCart
```

### Go to folder

```bash
cd WireCart
```
### Open VS Code in that folder

```bash
code .
```

### Install VirtualEnv to create Virtual Enverment

```bash
pip install virtualenv
```

### Create Virtual enverment 

```bash
virtualenv env
```

### Activate the `env` shell first:

```bash
.\env\Scripts\activate.ps1
```

### Install requard package

```bash
pip install -r .\requirements.txt
```

### run project

```bash
python manage.py runserver
```

### Open bellow link:
<a target="_blank" href="http://localhost:8000/">http://localhost:8000/</a>

## Admin Link
<a target="_blank" href="http://localhost:8000/admin/">http://localhost:8000/admin/</a>

### Super Admin Password
#### username and password
```bash
admin
```

## How run using docker image. 

### Create Docker image
```bash
docker build -t wirecart .
```

### Run Docker image
```bash
docker run -d -p 8000:8000 wirecart
```

### Stop Docker image
```bash
docker stop wirecart
```

## How to run using Compose file

### Just run Compose file
```bash
docker-compose up -d
```

### How to remove Docker image
```bash
docker rm wirecart
```

### How to remove all Docker image
```bash
docker rm $(docker ps -a -q)
```

### How to remove all Docker containers
```bash
docker rm $(docker ps -a -q)
```

# You good to go🙂

## Here are some screenshorts
![image](https://user-images.githubusercontent.com/46925955/196788676-68b333c7-c389-4d87-99e8-6415ee78d1ea.png)
![image](https://user-images.githubusercontent.com/46925955/196788728-c9b4397f-de33-4259-91b1-76022a264f9e.png)
![image](https://user-images.githubusercontent.com/46925955/196788797-4b4d6454-ec0a-46b3-9133-ffade021b017.png)
![image](https://user-images.githubusercontent.com/46925955/196788923-301f7f95-f8ca-45c2-89c7-eac95cceccbd.png)

## Login Page
![image](https://user-images.githubusercontent.com/46925955/196789057-010a97bf-3b46-4d82-a3da-e2d8abbe88c3.png)

## Registration
![image](https://user-images.githubusercontent.com/46925955/196789159-060a16fe-91ac-41da-b0bc-c8f7be7aa305.png)

## Reset Password 
![image](https://user-images.githubusercontent.com/46925955/196789282-4b795d1a-8e45-4a0a-863c-e583d699e8a9.png)

## Contact Us
![image](https://user-images.githubusercontent.com/46925955/197399094-3784ca80-75bd-4c25-9d38-d65434be15b5.png)

## Django Admin Panel
![image](https://user-images.githubusercontent.com/46925955/196794634-400fc111-7891-45b4-a706-ac5845d6ccf8.png)


## [Live](http://techstarmahesh.pythonanywhere.com/)

[Buy cup of coffee](https://www.buymeacoffee.com/techstarmahesh/)
thanks for reading this. 