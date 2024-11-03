from rest_framework import serializers
from .models import Item, UserItem

class ItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = Item
        fields = ['id', 'title', 'rating', 'type', 'additional_details']

class UserItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserItem
        fields = ['user', 'item', 'progress', 'optional_details']