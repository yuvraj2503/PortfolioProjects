from src import data_generation, sql_utils, feature_engineering, model_training, inference, visualization
if __name__ == '__main__':
    df = data_generation.simulate_players(1000)
    sql_utils.save_to_sqlite(df)
    df_feat = feature_engineering.feature_engineer(df)
    model_training.train_models(df_feat)
    visualization.generate_visuals(df_feat)
    print('Done')