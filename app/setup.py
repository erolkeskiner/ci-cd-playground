import json

from setuptools import find_packages, setup

with open("README.md", "r", encoding="utf-8") as f:
    long_description = f.read()

with open("target-version.json", "r", encoding="utf-8") as f:
    target_version = json.loads(f.read())['target-version']

setup(
    name='web_app',
    version=target_version,
    author="Erol Keskiner",
    author_email="erolksknr@gmail.com",
    description="A small Flask Web application package",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/erolkeskiner/ci-cd-playground",
    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,
    install_requires=[
        'Flask==1.1.2',
        'flask-healthz==0.0.2',
        'gunicorn==20.0.4'
    ],
    python_requires='>=3.6'
)
