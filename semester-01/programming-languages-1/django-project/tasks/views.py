from django.contrib.auth.decorators import login_required
from django.shortcuts import get_object_or_404, redirect, render
from django.views.decorators.http import require_POST
from .forms import TaskForm
from .models import Task


@login_required
def task_list(request):
    tasks = Task.objects.filter(owner=request.user)
    status = request.GET.get("status", "")
    if status == "done":
        tasks = tasks.filter(completed=True)
    elif status == "open":
        tasks = tasks.filter(completed=False)
    return render(request, "tasks/list.html", {"tasks": tasks, "status": status})


@login_required
def task_detail(request, pk):
    task = get_object_or_404(Task, pk=pk, owner=request.user)
    return render(request, "tasks/detail.html", {"task": task})


@login_required
def task_edit(request, pk=None):
    task = get_object_or_404(Task, pk=pk, owner=request.user) if pk is not None else None
    form = TaskForm(request.POST if request.method == "POST" else None, instance=task)
    if request.method == "POST" and form.is_valid():
        task = form.save(commit=False)
        task.owner = request.user
        task.save()
        return redirect("tasks:detail", pk=task.pk)
    return render(request, "form.html", {"form": form, "heading": "Задача", "back": "tasks:list"})


@login_required
@require_POST
def task_toggle(request, pk):
    task = get_object_or_404(Task, pk=pk, owner=request.user)
    task.completed = not task.completed
    task.save(update_fields=["completed"])
    return redirect("tasks:list")


@login_required
@require_POST
def task_delete(request, pk):
    get_object_or_404(Task, pk=pk, owner=request.user).delete()
    return redirect("tasks:list")
