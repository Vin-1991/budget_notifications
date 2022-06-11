__all__ = ["read_sql_queries", "unpack_list", "update_sql_query", "insert_to_table"]

import pandas as pd
from typing import List

from cnxn import engine


def read_sql_queries(query: str) -> pd.DataFrame:
    """
    This method reads a sql query using pandas read_sql_query annd convert to dataframe.
    Parameters
    ----------
        query : str
            raw sql query to execute.

    Returns
    -------
        df : dataframe
            `pandas.DataFrame`.
    """
    df: pd.DataFrame = pd.read_sql_query(query, engine)
    return df


def unpack_list(ids_list: List) -> str:
    """
    This method takes list of ids, unpack and joins.
    Parameters
    ----------
        ids_list : List
            list of ids to unpack

    Returns
    -------
        ids: str
            returns the joined list of ids
    """
    return ", ".join(str(id) for id in ids_list)


def update_sql_query(sql_query: str):
    """
    This method takes sql query to update the data in the database table.
    Parameters
    ----------
        sql_query : str
            raw sql query to update

    Returns
    -------
        successfull response upon commit
    """
    return engine.execute(sql_query)


def insert_to_table(df: pd.DataFrame):
    """
    This method takes a dataframe as input to insert the data in to the table using pandas to_sql.
    Parameters
    ----------
        df : dataframe
            df to insert in the table

    Returns
    -------

    """
    df.to_sql(
        "t_shops_notifications_audit", con=engine, if_exists="append", index=False
    )
