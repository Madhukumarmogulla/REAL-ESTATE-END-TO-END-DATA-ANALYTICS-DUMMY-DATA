# REAL-ESTATE-END-TO-END-DATA-ANALYTICS-DUMMY-DATA
## Real Estate Industry: Enhancing Property Investment Analysis

**Problem Statement:** "PropertyInsights Inc." is a real estate investment firm that acquires and manages residential and commercial properties. They need to improve their decision-making process for new property acquisitions and optimize the performance of their existing portfolio. Currently, data related to property listings, sales history, rental income, property expenses, tenant demographics, local economic indicators, and competitor activity is scattered across various spreadsheets, external market data providers, and legacy internal systems. This fragmentation makes it challenging to conduct comprehensive market analysis, assess investment risks, identify profitable acquisition targets, and benchmark property performance effectively.

## Data Warehouse & Database Design Considerations:

* **Source Systems:**  MLS data feeds, public records, internal accounting software, property management systems, demographic data APIs, competitor analysis reports.

* **Key Entities/Dimensions:** Property (address, type, size, features), Location (city, neighborhood, zip code), Time (transaction date, rental period), Tenant (demographics, lease terms), Market Condition (interest rates, unemployment).

* **Facts:** Sale Price, Rental Income, Acquisition Cost, Operating Expenses, Vacancy Rate, Property Value Appreciation.

* **Problem to Solve with DW:** Identifying undervalued properties, predicting rental income trends, analyzing the impact of market changes on property values, comparing property performance across regions/types, optimizing tenant acquisition strategies.

* **Example Queries:** "Which property types in specific zip codes have shown the highest appreciation in the last 5 years?", "What is the average ROI for residential properties acquired between 200k−400k in the last decade?", "How does average rental income correlate with local employment rates?", "Identify properties with consistently high maintenance costs relative to their income."

<img width="1024" height="1024" alt="image" src="https://github.com/user-attachments/assets/c27b53d4-e17c-46aa-85c0-689c1c890559" />

## The "Data Detective" Approach: How to Understand Your Data

The "Data Detective" Approach for Real Estate Data
Problem Statement: "PropertyInsights Inc." is a real estate investment firm that acquires and manages residential and commercial properties. They need to improve their decision-making process for new property acquisitions and optimize the performance of their existing portfolio.
Phase 1: High-Level Overview (The Big Picture)
What is the Source?
Clues: Our dummy data implies various sources: Property_Details (likely from internal asset management or public records), Transaction_History (sales/acquisition records), Rental_Income (property management system), Property_Expenses (accounting/expense tracking).
Why it matters: These are all transactional or descriptive operational systems. This means we can expect granular, possibly un-summarized data.
What is the Subject Area?
Clues: Property acquisition, sales, rental performance, property costs.
Why it matters: The core focus is on individual property performance, investment returns, and market trends.
What are the Tables/Files?
Property_Details: Seems like a descriptive (dimension) table about individual properties.
Transaction_History: Looks like an event/fact table recording sales and acquisitions.
Rental_Income: Appears to be a periodic fact table, likely monthly.
Property_Expenses: Another event/fact table, tracking various costs.
Why it matters: This initial categorization helps us think about star schema design (dimensions describe "what," facts describe "events/measurements").
How are the Tables Related?
Clues: All tables seem to have Property_ID.
Hypothesis: Property_ID is the key that connects all these different aspects of a property's lifecycle. Property_Details will be the "one" side of a 1-to-many relationship with the other "many" fact tables.
Phase 2: Deep Dive - Column by Column (The Details)
Let's examine each table in detail using the Power Query Editor's inspection tools (Column Quality, Column Distribution, Column Profile).
Table: Property_Details (Likely a Dimension Table: Dim_Property)
Column Name	Data Type (Expected)	Questions & Observations	Action/Cleaning Strategy
Property_ID	Text	Is it unique? (Should be primary key). Example: P001.	Verify 100% Unique, 100% Valid. If duplicates, investigate (data error or composite key needed?).
Property_Type	Text	Values: Residential, Commercial. Are there variations (e.g., "Res.", "Comm.")?	Use Column Distribution to see unique values. Replace Values for inconsistencies. Ensure Text data type.
Address	Text	Free-form text. No obvious issues, but check for leading/trailing spaces.	Use Transform -> Trim to remove whitespace.
City	Text	Values: San Diego, Phoenix, Sacramento, Austin, Denver. Case consistency?	Use Column Distribution. Transform -> Capitalize Each Word or Proper Case for consistency.
State	Text	Values: CA, AZ, TX, CO. Are there full names (e.g., "California") or typos?	Use Column Distribution. Replace Values if needed (e.g., "Calif" -> "CA"). Ensure Text data type.
Zip_Code	Text / Whole Number	Could be text if leading zeros are important (e.g., 02108), or number if only numeric.	If leading zeros are important for specific regions, keep as Text. Otherwise, can convert to Whole Number.
Sq_Footage	Whole Number	Range? 1200-8000. Any negatives or zeros?	Convert to Whole Number. Check Column Profile for min/max. Filter out/flag unreasonable values.
Built_Year	Whole Number	Range? 1975-2010. Any future years or very old/0?	Convert to Whole Number. Check Column Profile for min/max. Filter out/flag invalid years.
Num_Bedrooms	Whole Number	Range? 0-4. Commercial properties might have 0.	Convert to Whole Number. Check Column Profile. 0 for commercial is expected.
Num_Bathrooms	Whole Number	Range? 1-4. Decimals (e.g., 2.5) if half-baths are represented. Our dummy has whole.	Convert to Whole Number (or Decimal Number if half-baths were present).
Zoning	Text	Values: R1, C2, C1. Any typos or missing values?	Use Column Distribution. Replace Values for inconsistencies. Decide how to handle blanks (e.g., "Unknown").
Table: Transaction_History (Likely a Fact Table: Fact_Transactions)
Column Name	Data Type (Expected)	Questions & Observations	Action/Cleaning Strategy
Transaction_ID	Text	Is it unique? (Primary key for this table).	Verify 100% Unique, 100% Valid. Remove duplicates if found.
Property_ID	Text	Foreign key to Dim_Property. Are all IDs valid and present in Dim_Property?	Ensure consistent data type with Dim_Property[Property_ID]. Check Column Profile for errors/blanks.
Transaction_Date	Date	Are dates in a consistent format? YYYY-MM-DD. Is Acquisition date before Sale date for same property?	Convert to Date. Check Column Profile for min/max. Flag dates that are nonsensical (e.g., far future).
Transaction_Type	Text	Values: Acquisition, Sale. Are there variations?	Use Column Distribution to normalize (e.g., "Acquire" -> "Acquisition").
Sale_Price_USD	Decimal Number	Range? 380000-1200000. Any zeros or negatives? Unusually high/low prices?	Convert to Decimal Number. Check Column Profile for min/max. Filter out/flag unreasonable values or errors.
Buyer_Type	Text	Values: Investor, Individual. Are there other types?	Use Column Distribution to normalize values. Decide how to handle blanks.
Table: Rental_Income (Likely a Fact Table: Fact_Rental_Performance)
Column Name	Data Type (Expected)	Questions & Observations	Action/Cleaning Strategy
Rental_ID	Text	Is it unique? (Primary key for this table).	Verify 100% Unique, 100% Valid. Remove duplicates if found.
Property_ID	Text	Foreign key to Dim_Property. Are all IDs valid?	Ensure consistent data type. Check Column Profile for errors/blanks.
Period_Month	Whole Number	Range? 1-12.	Convert to Whole Number. Check Column Profile. Validate range.
Period_Year	Whole Number	Range? Current year or recent past.	Convert to Whole Number. Check Column Profile. Validate range.
Rental_Income_USD	Decimal Number	Range? 0-6000. 0 likely means vacant. Any negatives?	Convert to Decimal Number. Check Column Profile. 0 is expected for vacant. Filter out negatives if inappropriate.
Occupancy_Status	Text	Values: Occupied, Vacant. Any other statuses?	Use Column Distribution to normalize.
Vacancy_Days	Whole Number	Range? 0-31 (or days in month). 0 for occupied properties.	Convert to Whole Number. Check Column Profile. 0 is expected for occupied. Filter out negatives.
Derived Column	Date	Combine Period_Month and Period_Year to create a Date for Time Dimension.	Add Column -> Custom Column to create Date.FromText([Period_Year] & "-" & [Period_Month] & "-01").
Table: Property_Expenses (Likely a Fact Table: Fact_Property_Expenses)
Column Name	Data Type (Expected)	Questions & Observations	Action/Cleaning Strategy
Expense_ID	Text	Is it unique? (Primary key for this table).	Verify 100% Unique, 100% Valid. Remove duplicates if found.
Property_ID	Text	Foreign key to Dim_Property. Are all IDs valid?	Ensure consistent data type. Check Column Profile for errors/blanks.
Expense_Date	Date	Are dates consistent?	Convert to Date. Check Column Profile.
Expense_Type	Text	Values: Property Tax, Repair (Plumbing), Landscaping, Utilities, Cleaning. Variations?	Use Column Distribution to identify and normalize categories (e.g., "Plumbing Repair" -> "Repair (Plumbing)").
Amount_USD	Decimal Number	Range? 150-800. Any zeros or negatives?	Convert to Decimal Number. Check Column Profile. Filter out negatives if inappropriate.
Vendor	Text	Values: City of SD, PlumbGenius, Green Thumb, Phoenix Power, Spotless. Consistency?	Use Column Distribution to spot variations. Replace Values to normalize vendor names.
Phase 3: Context and Validation (The "Why")
Documentation (if available):
For a real estate firm, ideally, there would be:
A "Property Master Data" document explaining what Zoning codes mean (e.g., R1=Single Family Residential).
A list of standard Property_Type and Expense_Type categories.
Definitions for "Acquisition" vs. "Sale" in Transaction_Type.
Action: If such documents exist, refer to them constantly to validate your understanding and cleaning decisions.
Ask a Subject Matter Expert (SME):
Who to ask: A property manager, an investment analyst, or someone from the accounting department.
Questions:
"What constitutes a 'good' Performance Ratio for a property?" (This will be a calculated metric you'll need after modeling).
"How do we classify different types of Repair expenses?"
"Are Sq_Footage values always Gross or Net? What about for commercial vs. residential?"
"Are there specific Zoning types we focus on for investment?"
"How are Vacancy_Days calculated? Is 0 always 'occupied'?"
"What's the expected frequency for Rental_Income records? Always monthly?"
"What does it mean if Sale_Price_USD is 0?" (Could be a transfer, not a true sale).
Cross-Validation:
Compare with existing reports: Does the total Rental_Income_USD for a specific property match what's in a monthly rental report?
Calculate simple metrics: For a property, calculate Total_Expenses_Year from Property_Expenses and see if it looks reasonable compared to its Rental_Income_USD.
