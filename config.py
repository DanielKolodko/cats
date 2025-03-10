import os

class Config:
    SQLALCHEMY_DATABASE_URI = os.environ.get(
        'SQLALCHEMY_DATABASE_URI',
        "mysql+pymysql://catuser:catpassword@my-release-helmchart-mysql-service/catgifs"
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SECRET_KEY = os.environ.get('SECRET_KEY', "your_secret_key")
    SQLALCHEMY_ECHO = True  # This will log all SQL queries to the console
