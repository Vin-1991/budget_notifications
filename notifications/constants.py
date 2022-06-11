CREATE_FILTER_DATA_QUERY = """SELECT * from t_shops ts 
                            join t_budgets tb on ts.a_id = tb.a_shop_id
                            where ts.a_online = 1::boolean
                            and tb.a_notification_id = 1
                            and extract(month FROM tb.a_month) = extract (month FROM CURRENT_DATE)
                            """

GET_ALL_PERCENTAGES_VALUE_QUERY = (
    "SELECT n_percentage from t_shops_notifications where n_percentage > 0"
)

UPDATE_TABLE_SHOPS = """UPDATE t_shops set a_online = false where a_id in ({a_ids})"""

UPDATE_TABLE_BUDGETS = """UPDATE t_budgets set a_notification_id = {notifications_id} where s_id in ({s_ids})"""

CHECK_NOTIFICATION_EXIST_QUERY = """SELECT shop_id, notification_id, percentage_used from t_shops_notifications_audit
                                    where shop_id = {shop_id} and notification_id = {notification_id} 
                                    and percentage_used = {percentage_used}"""

FETCH_LATEST_NOTIFICATION_DETAILS_QUERY = """SELECT * from t_shops ts
                                            join t_budgets tb on ts.a_id = tb.a_shop_id
                                            where  tb.s_id in ({s_ids})
                                            and extract(month FROM tb.a_month) = extract (month FROM CURRENT_DATE)"""


NOTIFICATIONS_SENT_TO = "Sending notifications to shops those who have exhausted their {percentage} % amount \n"

GENERAL_MESSAGE = """Dear {shop_name} - ({shop_id}),\n
This is to inform you that you have exhausted ({shop_amount_spent}) amount out of -> {shop_budget_amount} that is
[{shop_percentage}] % of the original amount for the current month * {shop_month} * and date {shop_date}. \n"""

HUNDRED_PERCENT_USAGE_MESSAGE = """Note : As you have exhausted the 100% of the original amount, we are marking you as offline. Kindly contact customer
support to request for more budget allocation. \n"""
