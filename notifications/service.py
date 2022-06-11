__all__ = ["NotificationManager"]

from typing import List
import pandas as pd
import time

from utils import read_sql_queries, unpack_list, update_sql_query, insert_to_table
from constants import (
    CREATE_FILTER_DATA_QUERY,
    GET_ALL_PERCENTAGES_VALUE_QUERY,
    UPDATE_TABLE_SHOPS,
    UPDATE_TABLE_BUDGETS,
    CHECK_NOTIFICATION_EXIST_QUERY,
    FETCH_LATEST_NOTIFICATION_DETAILS_QUERY,
    NOTIFICATIONS_SENT_TO,
    GENERAL_MESSAGE,
    HUNDRED_PERCENT_USAGE_MESSAGE,
)


class NotificationManager:
    @classmethod
    def get_relevant_data(cls):
        """
        This method checks, create data and trigger notifications methods.
            - Read sql query to get the data for sending and creating the notifications.
            - Perform updates, append new columns to dataframe and modify df.
            - Trigger update table function to update the notification values.
            - Trigger send notification function to create and send notifications.
        Parameters
        ----------

        Returns
        -------

        """
        print("-" * 150)
        print("Checking records to send the notifications..\n")
        # read sql query to get the data for filtering and transforming.
        response_df = read_sql_queries(CREATE_FILTER_DATA_QUERY)

        print("Generating formula to filter the records.\n")
        # main formula to get the percentage values for filter purposes of the records.
        main_formula: float = round(
            response_df["a_amount_spent"] * 100 / response_df["a_budget_amount"], 1
        )
        # appending new column percenatge to df.
        response_df["percentage"] = main_formula
        # appending new column only month to df.
        response_df["month"] = pd.DatetimeIndex(response_df["a_month"]).month

        print("Formula created filtering the records now..\n")
        # extracting only records which are >= 50 and <= 100 from the df.
        fifty_percent = response_df[(main_formula >= 50.0) & (main_formula <= 100.0)]
        # extracting only records which are >=100 from the df.
        hundred_percent = response_df[main_formula >= 100.0]

        print("Filtered the records preparing notifications to send..\n")

        for value in cls.get_all_percentages().values:
            queries = []
            if value == 50 and not fifty_percent.empty:
                # unpack and join the shop ids.
                s_ids = unpack_list(fifty_percent["s_id"].tolist())
                if s_ids:
                    queries += [
                        UPDATE_TABLE_BUDGETS.format(notifications_id=2, s_ids=s_ids),
                    ]
                    # update the `t_budgets` table with the new notification id that is 2.
                    print("Updating records with new notification id.\n")
                    cls.update_table(queries)
                    # execute the query to check the updated notification of the shop
                    response_df = read_sql_queries(
                        FETCH_LATEST_NOTIFICATION_DETAILS_QUERY.format(s_ids=s_ids)
                    )
                    # map the new notification ids with the old one
                    fifty_percent["a_notification_id"] = fifty_percent[
                        "a_notification_id"
                    ].map(response_df["a_notification_id"])
                    cls.send_notifications(fifty_percent, percentage=value)

            elif value == 100 and not hundred_percent.empty:
                a_ids = unpack_list(hundred_percent["a_id"].tolist())
                s_ids = unpack_list(hundred_percent["s_id"].tolist())
                if a_ids:
                    queries += [
                        UPDATE_TABLE_SHOPS.format(a_ids=a_ids),
                        UPDATE_TABLE_BUDGETS.format(notifications_id=3, s_ids=s_ids),
                    ]
                    # update the `t_budgets` table with the new notification id that is 3 and mark all the
                    # shops those have exhausted the 100% quota.
                    print("Updating records with new notification id.\n")
                    cls.update_table(queries)
                    # execute the query to check the updated notification of the shop
                    response_df = read_sql_queries(
                        FETCH_LATEST_NOTIFICATION_DETAILS_QUERY.format(s_ids=s_ids)
                    )
                    # map the new notification ids with the old one
                    hundred_percent["a_notification_id"] = hundred_percent[
                        "a_notification_id"
                    ].map(response_df["a_notification_id"])
                    cls.send_notifications(hundred_percent, percentage=value)
            print("-" * 100)
        else:
            print("All caught up...\n")

    @classmethod
    def send_notifications(cls, df: pd.DataFrame, percentage: int) -> str:
        """
        This method takes a dataframe and percentage value to send the notifications
            - Checks if the notifications exist using `check_if_notification_exist` function.
            - If `true` then insert the data in to the `t_shops_notifications_audit` table,
              create notifications and send.
        Parameters
        ----------
            df : pd.DataFrame
                `pandas.DataFrame` conatining all the values of passed data
            percentage : int
                percentage value
        Returns
        -------

        """
        time.sleep(1)
        print("-" * 150)

        print(NOTIFICATIONS_SENT_TO.format(percentage=percentage))

        # iterate on the shops
        for shop in df.itertuples():
            df_result = cls.check_if_notification_exist(shop)
            if df_result.empty:
                # create dataframe to insert the data in the `t_shops_notifications_audit` table
                data = {
                    "shop_id": [shop.s_id],
                    "notification_id": [shop.a_notification_id],
                    "percentage_used": [shop.percentage],
                }
                df = pd.DataFrame(data)
                insert_to_table(df)
                # create a notifications and send
                cls.create_notification(shop, percentage)

        print("-" * 150)

    @staticmethod
    def check_if_notification_exist(shop: pd.DataFrame) -> pd.DataFrame:
        """
        This method takes shops dataframe and checks if the notification entry exists or not.
        Parameters
        ----------
            df : pd.DataFrame
                `pandas.DataFrame` containing shop related data.
        Returns
        -------
            df : pd.DataFrame
                `pandas.DataFrame` empty or data related df.
        """
        return read_sql_queries(
            CHECK_NOTIFICATION_EXIST_QUERY.format(
                shop_id=shop.s_id,
                notification_id=shop.a_notification_id,
                percentage_used=shop.percentage,
            )
        )

    @staticmethod
    def create_notification(shop: pd.DataFrame, percentage: int):
        """
        This method takes a dataframe and percentage value to send and create the notifications
        Parameters
        ----------
            df : pd.DataFrame
                `pandas.DataFrame` conatining all the values of passed data
            percentage : int
                percentage value
        Returns
        -------

        """

        print("-" * 100)
        print(
            f"Sending notification to shop id ({shop.a_id}) and name ({shop.a_name}) \n"
        )

        print(
            GENERAL_MESSAGE.format(
                shop_name=shop.a_name,
                shop_id=shop.a_id,
                shop_amount_spent=shop.a_amount_spent,
                shop_budget_amount=shop.a_budget_amount,
                shop_percentage=shop.percentage,
                shop_month=shop.month,
                shop_date=shop.a_month,
            )
        )

        if percentage == 100:
            print(HUNDRED_PERCENT_USAGE_MESSAGE)

        print("Thank you! \n")
        print(f"Notification sent to shop id ({shop.a_id}) and name ({shop.a_name}) \n")
        print("-" * 100)

    @staticmethod
    def get_all_percentages():
        """
        This method reads a sql query to get all the percenatges valuee from the `t_shops_notifications` table.
        Parameters
        ----------

        Returns
        -------
            df : dataframe
                `pandas.DataFrame`.
        """

        return read_sql_queries(GET_ALL_PERCENTAGES_VALUE_QUERY)

    @staticmethod
    def update_table(queries: List) -> str:
        """
        This method takes sql list of sql queries to update the values in the table.
        Parameters
        ----------
            queries : List
                List of update queries.
        Returns
        -------
            message : str
               returns a success message
        """
        for query in queries:
            update_sql_query(query)

        return "Updated succesfully!"
