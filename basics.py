from sqlalchemy import create_engine, text, MetaData, Table, Column, Integer, String
from sqlalchemy.orm import Session

# orm -> object relational mapping. 

engine = create_engine("sqlite:///mydatabase.db", echo=True)

conn = engine.connect()
conn.execute(text("CREATE TABLE IF NOT EXISTS people (name str, age int)"))
conn.commit()

session = Session(engine)
session.execute(text('INSERT INTO people (name, age) VALUES ("RAM", 30);'))
session.commit()

meta = MetaData()
people = Table(
    "people", 
    meta, 
    Column('id', Integer, primary_key=True),
    Column('name', String, nullable=False),
    Column('age', Integer)
)
meta.create_all(engine)