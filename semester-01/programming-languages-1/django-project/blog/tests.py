from django.contrib.auth import get_user_model
from django.test import TestCase
from django.urls import reverse
from rest_framework.test import APIClient
from .models import Post


class BlogTests(TestCase):
    def setUp(self):
        self.user = get_user_model().objects.create_user("writer_a")
        self.other = get_user_model().objects.create_user("writer_b")
        self.post = Post.objects.create(owner=self.user, title="Мой текст", content="Заметка")
        self.foreign = Post.objects.create(owner=self.other, title="Чужой текст", content="Данные")
        self.client.force_login(self.user)

    def test_list_detail(self):
        response = self.client.get(reverse("blog:list"))
        self.assertContains(response, "Мой текст")
        self.assertNotContains(response, "Чужой текст")
        self.assertContains(self.client.get(reverse("blog:detail", args=[self.post.pk])), "Заметка")

    def test_create_edit(self):
        self.assertEqual(self.client.post(reverse("blog:create"), {"title": "Новая", "content": "Текст"}).status_code, 302)
        post = Post.objects.get(title="Новая")
        self.assertEqual(post.owner, self.user)
        self.client.post(reverse("blog:edit", args=[post.pk]), {"title": "Изменено", "content": "Новый текст"})
        post.refresh_from_db()
        self.assertEqual(post.title, "Изменено")

    def test_delete_post(self):
        self.assertEqual(self.client.get(reverse("blog:delete", args=[self.post.pk])).status_code, 405)
        self.client.post(reverse("blog:delete", args=[self.post.pk]))
        self.assertFalse(Post.objects.filter(pk=self.post.pk).exists())

    def test_private(self):
        for name in ("detail", "edit"):
            self.assertEqual(self.client.get(reverse(f"blog:{name}", args=[self.foreign.pk])).status_code, 404)
        self.assertEqual(self.client.post(reverse("blog:delete", args=[self.foreign.pk])).status_code, 404)

    def test_invalid(self):
        response = self.client.post(reverse("blog:create"), {"title": "", "content": "Текст"})
        self.assertEqual(response.status_code, 200)
        self.assertEqual(Post.objects.count(), 2)

    def test_api(self):
        client = APIClient()
        self.assertEqual(client.get("/api/posts/").status_code, 403)
        client.force_authenticate(self.user)
        self.assertEqual([p["id"] for p in client.get("/api/posts/").data], [self.post.pk])
        self.assertEqual(client.get(f"/api/posts/{self.foreign.pk}/").status_code, 404)
        self.assertEqual(client.patch(f"/api/posts/{self.foreign.pk}/", {"title": "x"}, format="json").status_code, 404)
        response = client.post("/api/posts/", {"title": "API", "content": "content"}, format="json")
        self.assertEqual(response.status_code, 201)
        pk = response.data["id"]
        self.assertEqual(Post.objects.get(pk=pk).owner, self.user)
        self.assertEqual(client.put(f"/api/posts/{pk}/", {"title": "Updated", "content": "text"}, format="json").status_code, 200)
        self.assertEqual(client.delete(f"/api/posts/{pk}/").status_code, 204)
