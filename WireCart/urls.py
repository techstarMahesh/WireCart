from django.contrib import admin
from django.urls import path, include

# Change the admin site
admin.site.site_header = "WireCart Admin Portal"
admin.site.site_title = "WireCart"
admin.site.index_title = "Administration Panel"

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('app.urls')),
]
