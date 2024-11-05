from rest_framework import serializers
from .models import Item, UserItem

class ItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = Item
        fields = ['id', 'title', 'type', 'additional_details']

class UserItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserItem
        fields = ['user', 'item', 'progress', 'rating', 'favourite','progress', 'optional_details']

class FlatUserItemSerializer(serializers.ModelSerializer):
    item_id = serializers.IntegerField(source='item.id')
    title = serializers.CharField(source='item.title')
    item_type = serializers.CharField(source='item.type')
    additional_details = serializers.JSONField(source='item.additional_details')
    class Meta:
        model = UserItem
        fields = ['item_id', 'title', 'item_type', 'additional_details', 'rating', 'progress','favourite', 'optional_details']
