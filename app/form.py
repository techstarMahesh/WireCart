from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm, UsernameField, PasswordChangeForm, PasswordResetForm, SetPasswordForm
from django.contrib.auth.models import User
from django.utils.translation import gettext, gettext_lazy as _
from django.contrib.auth import password_validation


class CustomerRegistrationForm(UserCreationForm):
    password1 = forms.CharField(label='Password', widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    password2 = forms.CharField(label='Conform Password(agin)',widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    email = forms.CharField(required=True, widget=forms.EmailInput(attrs={'class': 'form-control'}))

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


class MyPasswordChangeForm(PasswordChangeForm):
    old_password = forms.CharField(label=_("Old Password"),strip=False, widget=forms.PasswordInput(attrs={'autocomplete':'current-password','autofocus': True,'class': 'form-control'}))
    new_password1 = forms.CharField(label=_("New Password"),strip=False, widget=forms.PasswordInput(attrs={'autocomplete':'new-password','class':'form-control'}),help_text=password_validation.password_validators_help_text_html())
    new_password2 = forms.CharField(label=_("Confirm NewPassword"),strip=False, widget=forms.PasswordInput(attrs={'autocomplete':'new-password','class':'form-control'}))

class MyPasswordResetForm(PasswordResetForm):
    email = forms.EmailField(label=_("Email"),widget=forms.EmailInput(attrs={'autofocus': True,'class': 'form-control'}))
    def clean_email(self):
        email = self.cleaned_data.get('email')
        if not User.objects.filter(email=email).exists():
            raise forms.ValidationError("Email does not exist")
        return email

class MySetPasswordForm(SetPasswordForm):
    new_password1 = forms.CharField(label=_("New Password"),strip=False, widget=forms.PasswordInput(attrs={'autocomplete':'new-password','class':'form-control'}),help_text=password_validation.password_validators_help_text_html())
    new_password2 = forms.CharField(label=_("Confirm New Password"),strip=False, widget=forms.PasswordInput(attrs={'autocomplete':'new-password','class':'form-control'}))