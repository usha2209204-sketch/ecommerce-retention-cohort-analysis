import csv
import datetime as dt
from random import Random

random = Random(42)

products = [
    (1, 'Wireless Headphones', 'Electronics', 'Audio', 99.99),
    (2, 'Smartwatch Pro', 'Electronics', 'Wearables', 249.99),
    (3, 'Running Shoes', 'Fashion', 'Footwear', 119.99),
    (4, 'Portable Blender', 'Home', 'Kitchen', 79.99),
    (5, 'Office Chair', 'Home', 'Furniture', 189.99),
    (6, 'Face Serum', 'Beauty', 'Skincare', 39.99),
    (7, 'Yoga Mat', 'Sports', 'Fitness', 54.99),
    (8, 'Bluetooth Speaker', 'Electronics', 'Audio', 89.99),
    (9, 'Leather Backpack', 'Fashion', 'Accessories', 129.99),
    (10, 'Coffee Grinder', 'Home', 'Kitchen', 64.99),
    (11, 'Hair Dryer', 'Beauty', 'Personal Care', 49.99),
    (12, 'Resistance Bands', 'Sports', 'Fitness', 29.99),
    (13, '4K Monitor', 'Electronics', 'Display', 329.99),
    (14, 'Winter Jacket', 'Fashion', 'Outerwear', 149.99),
    (15, 'Air Fryer', 'Home', 'Kitchen', 159.99),
]

channels = ['Organic', 'Paid', 'Referral', 'Social']
segments = ['Standard', 'Premium', 'VIP']
countries = ['United States', 'Canada', 'United Kingdom', 'Germany', 'India', 'Australia']

customers = []
for i in range(1, 101):
    signup_date = dt.date(2024, 1, 1) + dt.timedelta(days=random.randint(0, 365))
    customers.append({
        'customer_id': i,
        'customer_name': f'Customer {i}',
        'email': f'customer{i}@example.com',
        'country': random.choice(countries),
        'signup_date': signup_date.isoformat(),
        'acquisition_channel': random.choice(channels),
        'segment': random.choice(segments),
    })

orders = []
order_items = []
order_id = 1
item_id = 1

for customer in customers:
    customer_id = customer['customer_id']
    order_count = random.randint(1, 6)
    if customer_id % 7 == 0:
        order_count = random.randint(2, 8)

    for _ in range(order_count):
        order_date = dt.date(2024, 1, 1) + dt.timedelta(days=random.randint(0, 330))
        order_status = random.choices(['Completed', 'Completed', 'Completed', 'Returned'], weights=[80, 10, 5, 5])[0]
        payment_method = random.choice(['Credit Card', 'PayPal', 'UPI'])
        line_values = []

        for _ in range(random.randint(1, 4)):
            product = random.choice(products)
            quantity = random.randint(1, 3)
            unit_price = product[4]
            discount = round(random.uniform(0, 0.2), 2) * unit_price
            line_total = round((unit_price * quantity) - discount, 2)
            line_values.append((product[0], quantity, unit_price, discount, line_total))

            order_items.append({
                'order_item_id': item_id,
                'order_id': order_id,
                'product_id': product[0],
                'quantity': quantity,
                'unit_price': round(unit_price, 2),
                'discount_amount': round(discount, 2),
                'line_total': round(line_total, 2),
            })
            item_id += 1

        total_amount = round(sum(item[4] for item in line_values), 2)
        orders.append({
            'order_id': order_id,
            'customer_id': customer_id,
            'order_date': order_date.isoformat(),
            'total_amount': total_amount,
            'order_status': order_status,
            'payment_method': payment_method,
        })
        order_id += 1

with open('data/customers.csv', 'w', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=['customer_id','customer_name','email','country','signup_date','acquisition_channel','segment'])
    writer.writeheader()
    writer.writerows(customers)

with open('data/products.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(['product_id','product_name','category','subcategory','unit_price'])
    writer.writerows(products)

with open('data/orders.csv', 'w', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=['order_id','customer_id','order_date','total_amount','order_status','payment_method'])
    writer.writeheader()
    writer.writerows(orders)

with open('data/order_items.csv', 'w', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=['order_item_id','order_id','product_id','quantity','unit_price','discount_amount','line_total'])
    writer.writeheader()
    writer.writerows(order_items)

print('Dataset generated successfully.')
print(f'Customers: {len(customers)}')
print(f'Orders: {len(orders)}')
print(f'Order items: {len(order_items)}')
