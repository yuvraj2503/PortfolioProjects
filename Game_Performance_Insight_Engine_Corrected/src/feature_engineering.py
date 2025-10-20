import pandas as pd
def feature_engineer(df):
    df2 = df.copy()
    df2['sessions_per_day'] = df2['sessions'] / df2['days_active'].replace(0,1)
    df2['spend_per_purchase'] = df2.apply(lambda r: r['total_spend']/r['purchases'] if r['purchases']>0 else 0.0, axis=1)
    df2['recency_bucket'] = pd.cut(df2['last_active_days_ago'], bins=[-1,3,7,14,30,60,120], labels=['0-3','4-7','8-14','15-30','31-60','61-120'])
    df2['engagement_score'] = (0.4 * df2['sessions_per_day']) + (0.3 * (df2['avg_session_length_min']/30)) + (0.3 * (df2['days_active']/30))
    top_countries = df2['country'].value_counts().nlargest(6).index.tolist()
    df2['country_other'] = df2['country'].apply(lambda x: x if x in top_countries else 'OTHER')
    df2 = pd.get_dummies(df2, columns=['platform','country_other'], drop_first=True)
    return df2
