import numpy as np, pandas as pd, random
def simulate_players(n_players=5000, seed=42):
    random.seed(seed); np.random.seed(seed)
    players = []
    countries = ['US','IN','BR','DE','JP','KR','GB','FR','CA','AU']
    platforms = ['iOS','Android','PC','Console']
    for pid in range(1, n_players+1):
        sessions = max(1, int(np.random.poisson(12)))
        avg_session_length = max(1.0, np.random.normal(20, 8))
        days_active = min(30, max(1, int(np.random.binomial(30, 0.4))))
        purchases = np.random.binomial(3, 0.05)
        total_spend = round(purchases * np.random.exponential(5.0), 2)
        last_active_days_ago = int(np.random.exponential(8.0))
        country = random.choice(countries)
        platform = random.choice(platforms)
        churn_prob = (0.02 * last_active_days_ago) + (0.03 * (30 - days_active)) - (0.1 * purchases)
        churn_prob = 1/(1+np.exp(- (churn_prob - 3)))
        churn = int(np.random.rand() < churn_prob)
        players.append({
            'player_id': pid,
            'sessions': sessions,
            'avg_session_length_min': round(avg_session_length,2),
            'days_active': days_active,
            'purchases': purchases,
            'total_spend': total_spend,
            'last_active_days_ago': int(min(120, abs(last_active_days_ago))),
            'country': country,
            'platform': platform,
            'churn': churn
        })
    return pd.DataFrame(players)
