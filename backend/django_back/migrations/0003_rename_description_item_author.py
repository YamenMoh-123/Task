# Generated by Django 4.2.16 on 2024-10-28 01:06

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('django_back', '0002_rename_name_item_title'),
    ]

    operations = [
        migrations.RenameField(
            model_name='item',
            old_name='description',
            new_name='author',
        ),
    ]
