import plotly.express as px, os
def generate_visuals(df_feat):
    out_dir = os.path.join(os.path.dirname(__file__), '..')
    churn_by_recency = df_feat.groupby('recency_bucket')['churn'].mean().reset_index().dropna()
    fig = px.bar(churn_by_recency, x='recency_bucket', y='churn', title='Churn Rate by Recency Bucket')
    fig.write_html(os.path.join(out_dir, 'churn_by_recency.html'))
    print('Visuals written.')
