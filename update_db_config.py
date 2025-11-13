import re

# Читаем файл настроек
with open('backend/kittygram_backend/settings.py', 'r') as f:
    content = f.read()

# Новые настройки для PostgreSQL
new_db_config = '''DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.getenv('POSTGRES_DB', 'kittygram'),
        'USER': os.getenv('POSTGRES_USER', 'kittygram_user'),
        'PASSWORD': os.getenv('POSTGRES_PASSWORD', 'kittygram_password'),
        'HOST': os.getenv('DB_HOST', 'localhost'),
        'PORT': os.getenv('DB_PORT', 5432),
    }
}'''

# Заменяем настройки DATABASES
# Сначала попробуем найти стандартный шаблон Django
if "sqlite3" in content:
    # Заменяем SQLite на PostgreSQL
    content = content.replace("'ENGINE': 'django.db.backends.sqlite3',", "'ENGINE': 'django.db.backends.postgresql',")
    content = content.replace("'NAME': BASE_DIR / 'db.sqlite3',", """'NAME': os.getenv('POSTGRES_DB', 'kittygram'),
        'USER': os.getenv('POSTGRES_USER', 'kittygram_user'),
        'PASSWORD': os.getenv('POSTGRES_PASSWORD', 'kittygram_password'),
        'HOST': os.getenv('DB_HOST', 'localhost'),
        'PORT': os.getenv('DB_PORT', 5432),""")
else:
    # Если другой формат, используем regex замену
    pattern = r"DATABASES\s*=\s*\{[^}]+\}"
    content = re.sub(pattern, new_db_config, content)

# Записываем обновленный файл
with open('backend/kittygram_backend/settings.py', 'w') as f:
    f.write(content)

print("Database configuration updated successfully!")
