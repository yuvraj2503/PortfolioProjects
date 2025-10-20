import os, pickle, pandas as pd
from .feature_engineering import feature_engineer
MODEL_DIR = os.path.join(os.path.dirname(__file__), '..', 'models')
def predict_churn(df_input):
    model = pickle.load(open(os.path.join(MODEL_DIR,'rf_model.pkl'),'rb'))
    scaler = pickle.load(open(os.path.join(MODEL_DIR,'scaler.pkl'),'rb'))
    df_proc = feature_engineer(df_input)
    numeric_cols = df_proc.select_dtypes('number').columns
    X = df_proc[numeric_cols].fillna(0)
    X[numeric_cols] = scaler.transform(X[numeric_cols])
    probs = model.predict_proba(X)[:,1]
    return pd.DataFrame({'player_id': df_proc['player_id'], 'churn_prob': probs})
