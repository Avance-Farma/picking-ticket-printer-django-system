#!/usr/bin/env python
"""
Creates a Django superuser from environment variables.

Usage:
    python create_superuser.py

Environment variables:
    SUPERUSER_USERNAME  (default: admin)
    SUPERUSER_EMAIL     (default: admin@example.com)
    SUPERUSER_PASSWORD  (default: changeme)

If a user with the given username already exists, it will be deleted
and recreated so that the password and email are always up to date.
"""

import os
import sys

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "core.settings")

import django  # noqa: E402

django.setup()

from django.contrib.auth import get_user_model  # noqa: E402

User = get_user_model()

username = os.environ.get("SUPERUSER_USERNAME", "admin")
email = os.environ.get("SUPERUSER_EMAIL", "admin@example.com")
password = os.environ.get("SUPERUSER_PASSWORD", "changeme")

print(f"Creating superuser '{username}' ({email}) …")

if User.objects.filter(username=username).exists():
    User.objects.filter(username=username).delete()
    print(f"  Existing user '{username}' deleted.")

User.objects.create_superuser(username=username, email=email, password=password)
print(f"  Superuser '{username}' created successfully.")
