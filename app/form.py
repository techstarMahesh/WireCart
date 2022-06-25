from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm, UsernameField
from django.contrib.auth.models import User
from django.utils.translation import gettext, gettext_lazy as _


class CustomerRegistrationForm(UserCreationForm):
    password1 = forms.CharField(
        label='Password', widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    password2 = forms.CharField(label='Conform Password(agin)',
                                widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    email = forms.CharField(required=True, widget=forms.EmailInput(
        attrs={'class': 'form-control'}))

    class Meta:
        model = User
        fields = ['username', 'email', 'password1', 'password2']
        label = {'email': 'Email'}
        widgets = {'username': forms.TextInput(
            attrs={'class': 'form-control'})}


class CustomerLoginForm(AuthenticationForm):
    username = forms.CharField(widget=forms.TextInput(
        attrs={'autofocus': True, 'class': 'form-control'}))
    password = forms.CharField(label=("Password"), strip=False, widget=forms.PasswordInput(
        attrs={'autofocus': True, 'class': 'form-control'}))

    class Meta:
        model = User
        fields = ['username', 'password']
        label = {'username': 'Username'}
        widgets = {'password': forms.PasswordInput(
            attrs={'class': 'form-control'})}
