from django.shortcuts import redirect, render
from django.views import View
from .models import Customer, Product, Cart, OrderPlaced
from .form import CustomerRegistrationForm, MyPasswordChangeForm, CustomerProfileForm
from django.contrib import messages
from django.db.models import Q
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator


class ProductView(View):
    def get(self, request):
        topwears = Product.objects.filter(category='TW')
        bottomwears = Product.objects.filter(category='BW')
        mobiles = Product.objects.filter(category='M')
        return render(request, 'app/home.html', {'topwears': topwears, 'bottomwears': bottomwears, 'mobiles': mobiles})


class ProductDetailView(View):
    def get(self, request, pk):
        product = Product.objects.get(pk=pk)
        iteam_cart = False
        if request.user.is_authenticated:
            iteam_cart = Cart.objects.filter(Q(product=product.id) & Q(user=request.user)).exists()
        return render(request, 'app/productdetail.html', {'product': product, 'item': iteam_cart})

@login_required
def add_to_cart(request):
    user = request.user
    product_id = request.GET.get('prod_id')
    product = Product.objects.get(id=product_id)
    Cart(user=user, product=product).save()
    return redirect('/cart')

@login_required
def show_cart(request):
    if request.user.is_authenticated:
        user = request.user
        cart = Cart.objects.filter(user=user)
        print(cart)
        amount = 0.0
        shipping_charge = 40.0
        total_amount = 0.0
        cart_product = [p for p in Cart.objects.all() if p.user == user]
        print(cart_product)
        if cart_product:
            for p in cart_product:
                tempamount = (p.quantity * p.product.discounted_price)
                amount += tempamount
                total_amount = amount + shipping_charge
            return render(request, 'app/addtocart.html', {'carts':cart,'totalamount':total_amount,'amount':amount} )
        else:
            return render(request, 'app/emptycart.html')

@login_required
def plus_cart(request):
    if request.method == 'GET':
        prod_id = request.GET['prod_id']
        print(prod_id)
        # c = Cart.objects.get(product_id=prod_id)
        c = Cart.objects.get(Q(product=prod_id) & Q(user=request.user))
        c.quantity += 1
        c.save()
        amount = 0.0
        shipping_charge = 40.0
        total_amount = 0.0
        cart_product = [p for p in Cart.objects.all() if p.user == request.user]
        for p in cart_product:
            tempamount = (p.quantity * p.product.discounted_price)
            amount += tempamount
            total_amount = amount + shipping_charge
        data = {'totalamount': total_amount, 'amount': amount, 'quantity': c.quantity}
        return JsonResponse(data)

@login_required
def minus_cart(request):
    if request.method == 'GET':
        prod_id = request.GET['prod_id']
        c = Cart.objects.get(Q(product=prod_id) & Q(user=request.user))
        c.quantity -= 1
        c.save()
        amount = 0.0
        shipping_charge = 40.0
        total_amount = 0.0
        cart_product = [p for p in Cart.objects.all() if p.user == request.user]
        for p in cart_product:
            tempamount = (p.quantity * p.product.discounted_price)
            amount += tempamount
            total_amount = amount + shipping_charge
        data = {'totalamount': total_amount, 'amount': amount, 'quantity': c.quantity}
        return JsonResponse(data)

@login_required
def remove_cart(request):
    if request.method == 'GET':
        prod_id = request.GET['prod_id']
        c = Cart.objects.get(Q(product=prod_id) & Q(user=request.user))
        c.delete()
        amount = 0.0
        shipping_charge = 40.0
        total_amount = 0.0
        cart_product = [p for p in Cart.objects.all() if p.user == request.user]
        for p in cart_product:
            tempamount = (p.quantity * p.product.discounted_price)
            amount += tempamount
            total_amount = amount + shipping_charge
        data = {'totalamount': total_amount, 'amount': amount}
        return JsonResponse(data)


@login_required
def buy_now(request):
    return render(request, 'app/buynow.html')

# def profile(request):
#     return render(request, 'app/profile.html')

@login_required
def address(request):
    add = Customer.objects.filter(user=request.user)
    return render(request, 'app/address.html',{'add':add,'active':'btn-primary'})

@login_required
def orders(request):
    user = request.user
    op = OrderPlaced.objects.filter(user=user)
    return render(request, 'app/orders.html', {'placed': op})

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

@login_required
def checkout(request):
    user = request.user
    add = Customer.objects.filter(user=user)
    cart_iteams = Cart.objects.filter(user=user)
    amount = 0.0
    shipping_charge = 40.0
    total_amount = 0.0
    cart_product = [p for p in Cart.objects.all() if p.user == request.user]
    if cart_product:
        for p in cart_product:
            tempamount = (p.quantity * p.product.discounted_price)
            amount += tempamount
        total_amount = amount + shipping_charge
        data = {'totalamount': total_amount, 'amount': amount, 'quantity': cart_iteams, 'add': add}
    return render(request, 'app/checkout.html', data)

@login_required
def payment_done(request):
    user = request.user
    custid = request.GET.get('custid')
    customer = Customer.objects.get(id=custid)
    cart = Cart.objects.filter(user=user)
    for c in cart:
        OrderPlaced(user=user, product=c.product, quantity=c.quantity, customer=customer).save()
        c.delete()
    return redirect('/orders')

@method_decorator(login_required, name='dispatch')
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
