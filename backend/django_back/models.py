from django.db import models

class Item(models.Model):
    title = models.CharField(max_length=100)
    author = models.TextField()
    rating = models.CharField(max_length=10)

    def __str__(self):
        return self.title
