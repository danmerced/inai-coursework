from django.urls import path
from . import views

app_name = "blog"
urlpatterns = [
    path("", views.post_list, name="list"),
    path("new/", views.post_edit, name="create"),
    path("<int:pk>/", views.post_detail, name="detail"),
    path("<int:pk>/edit/", views.post_edit, name="edit"),
    path("<int:pk>/delete/", views.post_delete, name="delete"),
]
