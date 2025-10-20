import sqlite3, pandas as pd, os
DB_PATH = os.path.join(os.path.dirname(__file__), '..', 'data', 'game_insight.db')
def save_to_sqlite(df, db_path=DB_PATH, table_name='player_engagement'):
    os.makedirs(os.path.dirname(db_path), exist_ok=True)
    conn = sqlite3.connect(db_path)
    df.to_sql(table_name, conn, if_exists='replace', index=False)
    conn.commit(); conn.close()
