import environ

env = environ.Env(
    BASE_URL=(str, ""),
)

# reading .env file
environ.Env.read_env()


PG_SQL_DRIVER = env.str("PG_SQL_DRIVER")
PG_SQL_SERVER = env.str("PG_SQL_SERVER")
PG_SQL_USERNAME = env.str("PG_SQL_USERNAME")
PG_SQL_PASSWORD = env.str("PG_SQL_PASSWORD")
PG_SQL_DATABASE = env.str("PG_SQL_DATABASE")
