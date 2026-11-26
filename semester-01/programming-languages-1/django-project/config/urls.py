from django.contrib import admin
from django.contrib.auth import views as auth_views
from django.urls import include, path
from django.views.generic import RedirectView
from rest_framework.routers import DefaultRouter
from blog.api import PostViewSet
from tasks.api import TaskViewSet
from .views import register

router = DefaultRouter()
router.register("posts", PostViewSet, basename="post")
router.register("tasks", TaskViewSet, basename="task")

urlpatterns = [
    path("", RedirectView.as_view(pattern_name="tasks:list", permanent=False)),
    path("admin/", admin.site.urls),
    path("login/", auth_views.LoginView.as_view(), name="login"),
    path("logout/", auth_views.LogoutView.as_view(), name="logout"),
    path("register/", register, name="register"),
    path("blog/", include("blog.urls")),
    path("tasks/", include("tasks.urls")),
    path("api/", include(router.urls)),
]
