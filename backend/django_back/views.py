from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import Item
from .serializers import ItemSerializer

class ItemListCreate(APIView):
    def get(self, request):
        items = Item.objects.all().order_by('id')
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


