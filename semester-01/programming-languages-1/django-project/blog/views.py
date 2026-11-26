from django.contrib.auth.decorators import login_required
from django.shortcuts import get_object_or_404, redirect, render
from django.views.decorators.http import require_POST
from .forms import PostForm
from .models import Post


@login_required
def post_list(request):
    posts = Post.objects.filter(owner=request.user)
    return render(request, "blog/list.html", {"posts": posts})


@login_required
def post_detail(request, pk):
    post = get_object_or_404(Post, pk=pk, owner=request.user)
    return render(request, "blog/detail.html", {"post": post})


@login_required
def post_edit(request, pk=None):
    post = get_object_or_404(Post, pk=pk, owner=request.user) if pk is not None else None
    form = PostForm(request.POST if request.method == "POST" else None, instance=post)
    if request.method == "POST" and form.is_valid():
        post = form.save(commit=False)
        post.owner = request.user
        post.save()
        return redirect("blog:detail", pk=post.pk)
    return render(request, "form.html", {"form": form, "heading": "Запись блога", "back": "blog:list"})


@login_required
@require_POST
def post_delete(request, pk):
    get_object_or_404(Post, pk=pk, owner=request.user).delete()
    return redirect("blog:list")
