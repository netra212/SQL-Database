from sqlalchemy import create_engine, text
from sqlalchemy.orm import Session

# orm -> object relational mapping. 

engine = create_engine("sqlite:///mydatabase.db", echo=True)

conn = engine.connect()
conn.execute(text("CREATE TABLE IF NOT EXISTS people (name str, age int)"))
conn.commit()

session = Session(engine)
session.execute(text('INSERT INTO people (name, age) VALUES ("RAM", 30);'))
session.commit()