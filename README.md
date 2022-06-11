# Budget Notifications

A notification manager to notify the fashion reatilers about their budget utilization of a prodcut over the course of a month.

## General notes

The codebase of the notification manager handles all the cases mentioned in the coding assesment guidelines. This code base also covers the implementation of the additional thoughts. That includes the `notification manger class`,`supporting utility methods`, `new DB schema and tables`.

## Database and schema

Used `postgres` as the DB and created old and new schema that includes new `tables` and `schema` to suffice the implementation of the notification manager. Apart from the 2 tables. I have added 2 more tables with the revised schema of the exisitng two tables.

### Shops

The table `t_shops` holds master data about all the shops in our system.

- `a_id`: id of the shop(auto increment).

- `a_name`: name of the shop.

- `a_online`: Specifies, whether a shop's products are currently being listed on the Stylight website. `1` means they are listed, `0` means they aren't.

### Budgets

The table `t_budgets` holds all shops' monthly budgets.

- `s_id`: shops budget id (auto increment).

- `a_shop_id`: Signifies, which shop the budget is associated with.

- `a_budget_amount`: Signifies the monetary value a shop is willing to spend with Stylight in a given month.

- `a_amount_spent`: Represents how much money the shop has spent in that month.

- `a_month`: Signifies the month a budget is valid for. The _day_ component of the date is irrelevant and by convention always set to 1.

- `a_notification_id`: Signifies the notification id which is associated with notification id percentage value. Defaults to `1` notification id.

### Notifications

The table `t_shops_notifications` holds percentage values.

- `n_id`: notification id (auto increment).

- `n_percentage`: Signifies, the percentage value of the notification.

### Notifications audit

The table `t_shops_notifications_audit` holds the shop budget id, notification id and percentage value used for the filtering and check purposes.

- `audit_id`: audit id (auto increment).

- `shop_id`: Signifies, the shop budget id and associated to the `t_budgets` table `s_id` column.

- `notification_id`: Signifies, the notification id and associated to the `t_shops_notifications` table `n_id` column.

- `percentage_used`: Signifies, the budget percentage used by the retailer. Calculated on the fly while creating or manipluating the data in the notification manager class.

- `created_at`: Signifies, the time the record got created. Defaults to the current `timestamp` without `timezone`.

## Implementation

The new feature request has been implemented as stated in the new feature section. Below is a list of features that are available in the code base.

- Python CLI app which when can be invoked to send the notifications.

- Implemented all the rules mentioned in the impleementation section.

- In case of notifications to be send. The notifications will be printed out on the CLI with the proper details and formatted string.

- Notify shops when they reach 50% of the current month's budget.

- Notify once more when they reach 100% of the current month's budget, the shops should be notified again and set _offline_ in the `t_shops` table column `a_online` that is false in this case.

### New Features

Implemented both the additional thoughts mention in the section.

- Does your solution avoid sending duplicate notifications : Implemented a check where notifications manager avoid sending duplicate notifications to the retailers. I have used the `t_shops_notifications_audit` table to check if the notification has been sent previously using a query (available in the `constants.py`) and the combination of `shop_id`, `notification_id` and `percenatge_used`. If the query returns empty response with the filters that means there is no entry for the particular `shop budget id` and notification can be send.

- How does your solution handle a budget change after a notification has already been sent? : the notification manager is capable of handling the budget change even after a notification has already been sent to the retailers. The budget can be changed without worrying about the notification which was sent previously.

  - The `t_shops_notifications_audit` can be used to check if the `percentage_used` is same or there is a change in the value.

  - `percentage_used` will be calculated everytime before the notification is sent and inseerted in to the table.

  - If there is a change in the `percentage_used` then the notification manager will send the notification again.

  - As there is no direct dependency on the budget being changed. A notification can be send again.

## Folder structure

Below is the folder structure and modules descriptions.

- notifications

  - config
    - .env
    - settings.py
  - cnxn.py
  - constants.py
  - main.py
  - service.py
  - utils.py

## Run the notification manager

To run the application. Please follow below steps.

- Install all the `requirements` freezed in the `requirements.txt`.
- Execute the `migration.sql` in the `pgadmin` to create all the tables with data and constraints
- Change the database configuration in the `.env` file.
- Run the `main.py` using the command `python main.py`
- Voila application will start sending the notifications.

## Tools or applications used

- Python 3.10
- Pip 22.1.2
- Postgres 14.0
- Pipreqs (to create requiremennts and save dependencies)
- PgAdmin4
