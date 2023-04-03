import uuid
import hashlib

##### Here are my randoom thoughts #######
# Collect Data: Collect all relevant data on your customers, 
# - location(physical address) 
# - email address 
# - phone number, and any other identifying information we have.

physical_address = "37 My St, My Suburb, NSW, 2126"
email_address = "myemail@my.com"
att_1 = "id1"
att_2 = "id2"

#get my address in the right format
physical_address =  stdAddFormat(physical_address)
# get Location id us
loc_id = getLoc(physical_address)  #Experince API

# Hash the location_id to generate a hash
location_id = hashlib.sha256(loc_id.encode()).hexdigest()

#concat with some delimeter 
other_attr = email_address + att_1 + att_1

# Hash the other_attr to generate a hash
other_attr_hash = hashlib.sha256(other_attr.encode()).hexdigest()

# Generate a UUID (version 4) to create a unique customer ID (it's a person ID)
customer_id = uuid.uuid4()

#By mapping the UUID to the hashed physical address, you can ensure that each customer is uniquely identified, 
# even if they move to a new physical address.

# customer_id reamins same even if you change your address

# Combine the UUID and the hashed physical address to create a unique mapping
mapping = {"customer_id": str(customer_id), "location_id": location_id, "other_id":other_attr}

print(mapping)