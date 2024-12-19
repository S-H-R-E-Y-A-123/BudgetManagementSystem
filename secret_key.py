import secrets

# Generate a random 16-byte key
SECRET_KEY = secrets.token_hex(16)
print(SECRET_KEY)
