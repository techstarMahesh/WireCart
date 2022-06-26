from django.shortcuts import render
from django.views import View
from .models import Customer, Product, Cart, OrderPlaced
from .form import CustomerRegistrationForm, MyPasswordChangeForm, CustomerProfileForm
from django.contrib import messages

from app import form

# def home(request):
#  return render(request, 'app/home.html')

class ProductView(View):
    def get(self, request):
        topwears = Product.objects.filter(category='TW')
        bottomwears = Product.objects.filter(category='BW')
        mobiles = Product.objects.filter(category='M')
        return render(request, 'app/home.html', {'topwears': topwears, 'bottomwears': bottomwears, 'mobiles': mobiles})

# def product_detail(request):
#     return render(request, 'app/productdetail.html')

class ProductDetailView(View):
    def get(self, request, pk):
        product = Product.objects.get(pk=pk)
        return render(request, 'app/productdetail.html', {'product': product})

def add_to_cart(request):
    return render(request, 'app/addtocart.html')

def buy_now(request):
    return render(request, 'app/buynow.html')

# def profile(request):
#     return render(request, 'app/profile.html')

def address(request):
    add = Customer.objects.filter(user=request.user)
    return render(request, 'app/address.html',{'add':add,'active':'btn-primary'})

def orders(request):
    return render(request, 'app/orders.html')

# def change_password(request):
#     return render(request, 'app/changepassword.html')

def mobile(request, data=None):
    if data == None:
        mobiles = Product.objects.filter(category='M')
    elif data == 'Redmi' or data == 'Nokia' or data == 'Moto' or data == 'Realme':
        mobiles = Product.objects.filter(category='M').filter(brand=data)
    elif data == 'Below':
        mobiles = Product.objects.filter(category='M').filter(discounted_price__lt=10000)
    elif data == 'Above':
        mobiles = Product.objects.filter(category='M').filter(discounted_price__gt=10000)
    return render(request, 'app/mobile.html' , {'mobiles': mobiles})

def leptop(request, data=None):
    if data == None:
        leptop = Product.objects.filter(category='L')
    elif data == 'Asus' or data == 'MSI' or data == 'Lenovo' or data == 'HP':
        leptop = Product.objects.filter(category='L').filter(brand=data)
    elif data == 'Below':
        leptop = Product.objects.filter(category='L').filter(discounted_price__lt=50000)
    elif data == 'Above':
        leptop = Product.objects.filter(category='L').filter(discounted_price__gt=50000)
    return render(request, 'app/leptop.html' , {'leptops': leptop})

def bottomWear(request, data=None):
    if data == None:
        bottomWear = Product.objects.filter(category='BW')
    return render(request, 'app/bottomWear.html', {'bottomWear': bottomWear})

def topWear(request):
    topWear = Product.objects.filter(category='TW')
    return render(request, 'app/topWear.html', {'topWear': topWear})

# def login(request):
#     return render(request, 'app/login.html')

# def customerregistration(request):
#     return render(request, 'app/customerregistration.html')

class CustomerRegistrationView(View):
    def get(self, request):
        form = CustomerRegistrationForm()
        return render(request, 'app/customerregistration.html', {'form': form})
    def post(self, request):
        form = CustomerRegistrationForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Registration Successfully')
        return render(request, 'app/customerregistration.html', {'form': form})

def checkout(request):
    return render(request, 'app/checkout.html')

class ProfileView(View):
    def get(self, request):
        form = CustomerProfileForm() 
        return render(request, 'app/profile.html' , {'form': form,'active':'btn-primary'})
    def post(self, request):
        form=CustomerProfileForm(request.POST)
        if form.is_valid():
            usr = request.user
            name = form.cleaned_data['name']
            locality = form.cleaned_data['locality']
            city = form.cleaned_data['city']
            state = form.cleaned_data['state']
            zipcode = form.cleaned_data['zipcode']
            reg = Customer(user=usr,name=name,locality=locality, city=city,state=state, zipcode=zipcode)
            reg.save()
            messages.success(request, "Congratulations!! Profile Updated Successfully")
        return render(request, 'app/profile.html',{'form':form,'active':'btn-primary'})
