# Airbnb Investment Analysis – Tableau Project

Please click the link below to view the full interactive Airbnb project in Tableau:

🔗 [View Airbnb Project](https://public.tableau.com/views/AirBnbProject_17174361122020/Dashboard1?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link)

---

## Project Overview
This project was built in **Tableau** to help evaluate investment opportunities in the **Seattle, Washington Airbnb market**.  
The client’s goal was to determine whether purchasing a **3-bedroom home** would be a profitable strategy for short-term rentals. Using a dataset dating back to **2016**, I developed a series of visualizations to uncover pricing trends, seasonality, and market competitiveness.  

---

## Data Preparation
I worked with three main tables:  
- **Listings**  
- **Calendar**  
- **Reviews** (excluded from analysis since customer feedback was not a key decision factor)  

A **JOIN operation** was performed to combine the **Listings** and **Calendar** tables using their primary key. This enriched the dataset with both property details and calendar availability, enabling deeper insights.  

📊 *JOIN Clause Screenshot:*  
[View JOIN Clause](https://github.com/curlyeje/Elliott_Portfolio/blob/9affa40f64994cec801a95410d640232edbc9d25/Tableau%20AirBnB%20Project/JOIN%20Clause.png)

---

## Visualizations & Insights

### 1. Average Price per Zip Code  
Analyzed average nightly prices across Seattle zip codes to identify local pricing trends.  
- **Finding**: Zip Code **98134** showed the highest average nightly rate at **$206**.  

![Price Per Zip Code](https://github.com/user-attachments/assets/6ab5c127-fb3c-4708-b8e4-d7c36cc5bf75)

---

### 2. Best Months to Rent Property on Airbnb  
Seasonal trends were explored to highlight the most profitable months for hosting.  
- An **average line** was added to benchmark month-to-month performance.  

![Best Months to Rent](https://github.com/user-attachments/assets/1ae30ef9-7781-48dd-8eae-ae6c0740baec)

---

### 3. Average Price per Bedroom  
This view compared nightly rates by bedroom count, providing insights specific to **3-bedroom homes**.  
- Allowed direct comparison between different property sizes and validated the client’s focus on 3-bedroom investments.  

![Average Price per Bedroom](https://github.com/user-attachments/assets/a2e25f53-d5c5-4281-bfe9-3e234f38d564)

---

### 4. Bedroom Listing Volume  
Visualized the total number of listings by bedroom count.  
- Helped assess **market competition** within the **3-bedroom segment**, ensuring a more informed investment decision.  

![Bedroom Listing Volume](https://github.com/user-attachments/assets/446a9451-6771-430d-b1b7-52e3bdcba4c1)

---

### Final Dashboard  
All visualizations were consolidated into an **interactive Tableau dashboard** to provide a holistic view of the Seattle Airbnb market.  
This dashboard empowered the client to weigh profitability, competition, and seasonality when considering the purchase of a 3-bedroom property.  

📊 *Final Dashboard Screenshot:*  
[View Dashboard](https://github.com/curlyeje/Elliott_Portfolio/blob/9d6e48cfe3547a0df19929895d254dc27dc45b8a/Tableau%20AirBnB%20Project/Dashboard-1.png)

---

## Key Takeaways
- Zip Code **98134** offers the highest average nightly rates ($206).  
- Clear **seasonal trends** indicate certain months are significantly more profitable.  
- **3-bedroom properties** align well with strong nightly pricing and steady demand.  
- Competitive analysis of listing volume provides insight into market saturation.  

