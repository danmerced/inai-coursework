from django.contrib.auth import get_user_model
from django.test import TestCase
from django.urls import reverse
from rest_framework.test import APIClient
from .models import Task


class TaskTests(TestCase):
    def setUp(self):
        self.user = get_user_model().objects.create_user("student_a", password="TestOnly672!")
        self.other = get_user_model().objects.create_user("student_b", password="TestOnly671!")
        self.task = Task.objects.create(owner=self.user, title="Моя задача")
        self.secret = Task.objects.create(owner=self.other, title="Чужая задача")
        self.client.force_login(self.user)

    def test_list_and_detail(self):
        response = self.client.get(reverse("tasks:list"))
        self.assertContains(response, self.task.title)
        self.assertNotContains(response, self.secret.title)
        self.assertContains(self.client.get(reverse("tasks:detail", args=[self.task.pk])), self.task.title)

    def test_create(self):
        response = self.client.post(reverse("tasks:create"), {"title": "Новая", "description": "Текст"})
        task = Task.objects.get(title="Новая")
        self.assertRedirects(response, reverse("tasks:detail", args=[task.pk]))
        self.assertEqual(task.owner, self.user)

    def test_edit(self):
        self.client.post(reverse("tasks:edit", args=[self.task.pk]),
                         {"title": "Обновлена", "description": "Текст", "completed": "on"})
        self.task.refresh_from_db()
        self.assertEqual(self.task.title, "Обновлена")
        self.assertTrue(self.task.completed)

    def test_toggle_filter(self):
        response = self.client.post(reverse("tasks:toggle", args=[self.task.pk]))
        self.assertRedirects(response, reverse("tasks:list"))
        self.task.refresh_from_db()
        self.assertTrue(self.task.completed)
        self.assertContains(self.client.get(reverse("tasks:list") + "?status=done"), self.task.title)
        self.assertNotContains(self.client.get(reverse("tasks:list") + "?status=open"), self.task.title)

    def test_delete(self):
        self.assertEqual(self.client.get(reverse("tasks:delete", args=[self.task.pk])).status_code, 405)
        self.client.post(reverse("tasks:delete", args=[self.task.pk]))
        self.assertFalse(Task.objects.filter(pk=self.task.pk).exists())

    def test_foreign_task(self):
        for name in ("detail", "edit"):
            self.assertEqual(self.client.get(reverse(f"tasks:{name}", args=[self.secret.pk])).status_code, 404)
        for name in ("edit", "toggle", "delete"):
            self.assertEqual(self.client.post(reverse(f"tasks:{name}", args=[self.secret.pk]), {"title": "x"}).status_code, 404)
        self.assertTrue(Task.objects.filter(pk=self.secret.pk).exists())

    def test_invalid(self):
        response = self.client.post(reverse("tasks:create"), {"title": " "})
        self.assertEqual(response.status_code, 200)
        self.assertEqual(Task.objects.count(), 2)

    def test_login_required(self):
        self.client.logout()
        self.assertRedirects(self.client.get(reverse("tasks:list")), reverse("login") + "?next=/tasks/")

    def test_api_crud(self):
        client = APIClient()
        self.assertEqual(client.get("/api/tasks/").status_code, 403)
        client.force_authenticate(self.user)
        response = client.get("/api/tasks/")
        self.assertEqual([item["id"] for item in response.data], [self.task.pk])
        self.assertEqual(client.get(f"/api/tasks/{self.secret.pk}/").status_code, 404)
        response = client.post("/api/tasks/", {"title": "API task"}, format="json")
        self.assertEqual(response.status_code, 201)
        pk = response.data["id"]
        self.assertEqual(Task.objects.get(pk=pk).owner, self.user)
        self.assertEqual(client.patch(f"/api/tasks/{pk}/", {"completed": True}, format="json").status_code, 200)
        self.assertTrue(Task.objects.get(pk=pk).completed)
        self.assertEqual(client.delete(f"/api/tasks/{pk}/").status_code, 204)


class AuthTests(TestCase):
    def test_registration(self):
        response = self.client.post(reverse("register"), {
            "username": "new_student", "password1": "ValidDemoPw93!", "password2": "ValidDemoPw93!",
        })
        self.assertRedirects(response, reverse("tasks:list"))
        user = get_user_model().objects.get(username="new_student")
        self.assertTrue(user.check_password("ValidDemoPw93!"))
        self.assertEqual(int(self.client.session["_auth_user_id"]), user.pk)

    def test_login_logout(self):
        get_user_model().objects.create_user("student", password="TestOnly672!")
        response = self.client.post(reverse("login"), {"username": "student", "password": "TestOnly672!"})
        self.assertRedirects(response, reverse("tasks:list"))
        self.assertEqual(self.client.get(reverse("logout")).status_code, 405)
        response = self.client.post(reverse("logout"))
        self.assertRedirects(response, reverse("login"))
        self.assertNotIn("_auth_user_id", self.client.session)
