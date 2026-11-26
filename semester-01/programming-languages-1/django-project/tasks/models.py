from django.conf import settings
from django.db import models


class Task(models.Model):
    owner = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="tasks")
    title = models.CharField("Название", max_length=150)
    description = models.TextField("Описание", blank=True)
    completed = models.BooleanField("Выполнено", default=False)
    created_at = models.DateTimeField("Создано", auto_now_add=True)

    class Meta:
        ordering = ["completed", "-created_at", "-pk"]

    def __str__(self):
        return self.title
