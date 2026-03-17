import factory

from apps.addresses.models import Address
from apps.customers.models import Customer
from apps.deliveries.models import Delivery
from apps.orders.models import Order, OrderItem
from apps.products.models import Product


class DeliveryFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Delivery

    route = factory.Faker("city")


class AddressFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Address

    street = factory.Faker("street_name")
    number = factory.Faker("building_number")
    district = factory.Faker("city")
    city = factory.Faker("city")
    state = "SP"
    zip_code = factory.Faker("postcode")
    country = "Brasil"


class CustomerFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Customer

    code = factory.Sequence(lambda n: f"CLI-{n:04d}")
    name = factory.Faker("name")
    id_number = factory.Faker("ssn")
    address = factory.SubFactory(AddressFactory)


class ProductFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Product

    sku_code = factory.Sequence(lambda n: f"SKU-{n:04d}")
    description = factory.Faker("sentence")
    price = factory.Faker(
        "pydecimal", left_digits=4, right_digits=2, positive=True
    )


class OrderFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Order

    order_number = factory.Sequence(lambda n: f"ORD-{n:04d}")
    picking = factory.Sequence(lambda n: f"PCK-{n:04d}")
    customer = factory.SubFactory(CustomerFactory)
    delivery = factory.SubFactory(DeliveryFactory)
    status = "pending"


class OrderItemFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = OrderItem

    order = factory.SubFactory(OrderFactory)
    product = factory.SubFactory(ProductFactory)
    quantity = factory.Faker(
        "pydecimal", min_value=1, max_value=100, right_digits=3
    )


# Alias for old tests that use the Portuguese name.
PedidoFactory = OrderFactory
