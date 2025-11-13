import re

with open('backend/kittygram_backend/settings.py', 'r') as f:
    content = f.read()

# Обновляем ALLOWED_HOSTS
new_allowed_hosts = "ALLOWED_HOSTS = os.getenv('ALLOWED_HOSTS', 'localhost,127.0.0.1').split(',')"

# Заменяем ALLOWED_HOSTS
pattern = r"ALLOWED_HOSTS\s*=\s*\[[^\]]*\]"
if re.search(pattern, content):
    content = re.sub(pattern, new_allowed_hosts, content)
else:
    # Если нет ALLOWED_HOSTS, добавляем после импортов
    import_section_end = content.find('\n\n')
    if import_section_end != -1:
        content = content[:import_section_end] + '\n\n' + new_allowed_hosts + content[import_section_end:]

with open('backend/kittygram_backend/settings.py', 'w') as f:
    f.write(content)

print("ALLOWED_HOSTS updated successfully!")
