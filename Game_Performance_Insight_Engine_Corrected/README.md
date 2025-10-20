# 🎮 Game Performance Insight Engine

An **end-to-end analytics pipeline** that simulates player engagement data, predicts churn probability, and visualizes retention insights to improve player engagement. Built using Python, SQL, and machine learning techniques.

---

## 📌 Project Overview

In this project, I built a modular analytics pipeline that performs the following tasks:

1. **Data Simulation** – Generates realistic player engagement data including sessions, purchases, activity metrics, and churn labels.  
2. **SQL Integration** – Stores and extracts data using SQLite for structured querying and persistence.  
3. **Feature Engineering** – Creates new features such as engagement score, sessions per day, spend per purchase, and recency buckets.  
4. **Model Training** – Trains machine learning models (Logistic Regression and Random Forest) to predict player churn.  
5. **Visualization** – Generates interactive visualizations using Plotly to gain insights on churn patterns and engagement trends.  
6. **Modular Design** – Organized into separate Python modules for data generation, SQL utilities, feature engineering, modeling, inference, and visualization.

---

## 🧰 Tech Stack

- **Python** – Core programming and data manipulation  
- **Pandas / NumPy** – Data wrangling and preprocessing  
- **SQLite** – SQL database for storing simulated player data  
- **Scikit-learn** – ML models (Logistic Regression, Random Forest)  
- **Plotly** – Interactive charts for visual analysis  

---

## 📁 Project Structure

Game_Performance_Insight_Engine/
├── data/ # SQLite database (player engagement data)
├── models/ # Saved ML models and scaler
├── src/ # Python source modules
│ ├── data_generation.py
│ ├── sql_utils.py
│ ├── feature_engineering.py
│ ├── model_training.py
│ ├── inference.py
│ └── visualization.py
├── notebooks/ # Jupyter notebooks for exploration
│ └── Game_Performance_Insight_Engine.ipynb
├── main.py # Run the full pipeline end-to-end
├── requirements.txt
└── README.md # This file

---

## 🚀 How to Run

1. **Clone the project** (or download and extract if in portfolio repo):

```bash
git clone <your-portfolio-repo-url>
cd Game_Performance_Insight_Engine
```
2.Install dependencies
```bash
pip install -r requirements.txt
```
3.Run the pipeline
```bash
python main.py
```
Generates synthetic player data (or uses provided SQLite DB)

Trains ML models and saves them in /models

Produces HTML visualizations in the project root (churn_by_recency.html, etc.)

Prints sample churn predictions for a few players

Optional: Open the notebook for interactive exploration:
```bash
jupyter notebook notebooks/Game_Performance_Insight_Engine.ipynb
```
