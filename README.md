# Cyclistic Bike-Share Data Analysis

## Executive Summary
This case study analyzes 12 months of historical trip data (October 2025 – September 2026) for Cyclistic, a bike-share program in Chicago. The goal is to identify behavioral differences between **casual riders** and **annual members** to inform targeted marketing strategies aimed at converting casual riders into annual members.

---

## 🛠️ Tech Stack & Resources
* **SQL (SQLite):** Data extraction, cleaning, and aggregation.
* **Google Sheets:** Pivot tables and executive data visualizations.
* **Canva:** Executive slide deck presentation and video walkthrough.
* **Data Source:** [Motivate Inc. AWS S3 Public Bucket](https://divvy-tripdata.s3.amazonaws.com/index.html)

---

## 📊 Key Findings
1. **Usage Patterns:** Members account for the majority of weekday commute trips (peak volume Tuesday–Thursday), while casual riders spike on weekends.
2. **Trip Duration:** Casual riders average significantly longer ride durations (~20 minutes) compared to annual members (~12 minutes).
3. **Seasonality:** Peak usage for both user groups occurs during summer months (June–August), with a sharp decline in winter.

---

## 💡 Recommendations
* **Weekend Conversion Campaign:** Launch targeted promotions on weekends highlighting the cost savings of annual memberships for frequent weekend riders.
* **Seasonal Pass Transition:** Offer seasonal members an automated upgrade path to annual memberships prior to summer peak months.

---

## 📂 Repository Structure
* `sql/cyclistic_analysis.sql`: Full SQL queries used for data processing and aggregation.
* `LICENSE`: MIT License.
