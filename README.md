This project is a technical assessment for SumUp Analytics Engineer Position
The objective is to answer the following questions:
Top 10 stores per transacted amount
Top 10 products sold
Average transacted amount per store typology and country
Percentage of transactions per device type
Average time for a store to perform its 5 first transactions

I created a CI/CD pipeline that runs the changed models and its immediate downstream on every pull request to the main branch. It uses the state:modified+1 dbt syntax to do this. I chose to output the models to a single table so as to:
 1. Avoid cluttering the datawarehouse with so many pr schemas
 2. As I didnt have a "dev" environment, I wanted to use this to mock one. 

To enable me output to a specific schema on every pull request I had to customise the generate_schema_name macro, I did this so as to have a custom schema when running on ci/cd target, also for it to run on my own schema when my target is "local" (ie when running directly from my terminal) and then the prod schemas based on each folder eg staging models go into sumup_staging. 

For this project I divided my schemas into the following:
1. Staging: consisting of all staging tables that feed from the source tables. They are views by default
2. Intermediary: These are my fact and dim tables as well as the "int" table which is essentially a denormalised table of my fact and dim tables. They are tables by default, although there were some models here that are incremental. I considered partitioning and clustering some other tables but I didnt have enough time for it 
3. Summary: This is where I created summary tables that didn't answer just specifically the questions asked in the assessment but was built to answer further questions they may arise without having to write some other complex queries. Eg if you wanted to see top 10 products by transaction amount or top 20 products sold.
4. Reports: These are the answers to the specific questions asked. 

For my data modelling design I used the Kimball Dimension

I created fact and dimension tables then used a star schema to create a denormalised table.


![sumup_erd](https://user-images.githubusercontent.com/28759554/233973985-042745e9-4227-4ed3-8bc2-47e7e1104e8f.png)

Some assumptions I made:
1. All devices must have a store it is assigned to
2. A transaction can only be done using a device.


The answers to the specific questions can be found on this dashboard I created https://lookerstudio.google.com/u/0/reporting/6b870034-a45a-4183-9aed-37b12ca3baea/page/p_e405ty6f5c 

For future improvements:
1. I'll create a proper dev schema that mirrors the prod instead of using the cicd(although it also mirrors the prod)
2. I didnt write enough tests as I was cautious of the time allocated on this project, specifically I could have written more unit tests and tested the business logic more rigorously
3. My ERD didnt contain every single column as I rushed through it and I just wanted to show the important bits and how each table related to each other.
