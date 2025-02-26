import os
class Config:
    SQLALCHEMY_DATABASE_URI ="mysql+pymysql://catuser:catpassword@db/catgifs"
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SECRET_KEY = "your_secret_key"
    SQLALCHEMY_ECHO = True  # This will log all SQL queries to the console
