from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import Item
from .serializers import ItemSerializer, UserItemSerializer


class ItemListCreate(APIView):
    def get(self, request):
        user_id = request.query_params.get('id')
        item_type = request.query_params.get('type')

        if not user_id or not item_type:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        items = Item.objects.all().order_by('id')

        items = items.filter(useritem__user_id=user_id)
        items = items.filter(type=item_type)

        serializer = ItemSerializer(items, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = ItemSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class ItemDetail(APIView):
    def get_object(self, id):
        try:
            return Item.objects.get(id=id)
        except Item.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

    def get(self, request, id):
        item = self.get_object(id)
        if isinstance(item, Response):
            return item
        serializer = ItemSerializer(item)
        return Response(serializer.data)

    def put(self, request, id):
        item = self.get_object(id)
        if isinstance(item, Response):
            return item
        serializer = ItemSerializer(item, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, id):
        item = self.get_object(id)
        if isinstance(item, Response):
            return item
        item.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


class UserItemCreate(APIView):
    def post(self, request):
        user_item_data = {
            'user': request.data.get('user_id'),
            'item': request.data.get('item_id'),
            'progress': request.data.get('progress', ''),
            'optional_details': request.data.get('optional_details', {})
        }

        user_item_serializer = UserItemSerializer(data=user_item_data)
        if user_item_serializer.is_valid():
            user_item_serializer.save()
            return Response(user_item_serializer.data, status=status.HTTP_201_CREATED)
        return Response(user_item_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
