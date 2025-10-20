from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import roc_auc_score
import pandas as pd, os, pickle
MODEL_DIR = os.path.join(os.path.dirname(__file__), '..', 'models')
os.makedirs(MODEL_DIR, exist_ok=True)
def train_models(df_feat):
    FEATURES = [c for c in df_feat.columns if c not in ['player_id','country','platform','recency_bucket','churn']]
    X = df_feat[FEATURES].fillna(0); y = df_feat['churn']
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42, stratify=y)
    scaler = StandardScaler()
    X_train_scaled = X_train.copy(); X_test_scaled = X_test.copy()
    numeric_cols = X_train.select_dtypes('number').columns
    X_train_scaled[numeric_cols] = scaler.fit_transform(X_train[numeric_cols])
    X_test_scaled[numeric_cols] = scaler.transform(X_test[numeric_cols])
    lr = LogisticRegression(max_iter=1000); lr.fit(X_train_scaled, y_train)
    auc_lr = roc_auc_score(y_test, lr.predict_proba(X_test_scaled)[:,1])
    rf = RandomForestClassifier(n_estimators=100, random_state=42); rf.fit(X_train, y_train)
    auc_rf = roc_auc_score(y_test, rf.predict_proba(X_test)[:,1])
    with open(os.path.join(MODEL_DIR, 'scaler.pkl'),'wb') as f: pickle.dump(scaler,f)
    with open(os.path.join(MODEL_DIR, 'lr_model.pkl'),'wb') as f: pickle.dump(lr,f)
    with open(os.path.join(MODEL_DIR, 'rf_model.pkl'),'wb') as f: pickle.dump(rf,f)
    print(f"Models saved. LR AUC={auc_lr:.3f}, RF AUC={auc_rf:.3f}") 
