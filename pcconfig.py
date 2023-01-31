import pynecone as pc


config = pc.Config(
    app_name="web_frontend_pynecone",
    db_url="sqlite:///pynecone.db",
    env=pc.Env.DEV,
)
